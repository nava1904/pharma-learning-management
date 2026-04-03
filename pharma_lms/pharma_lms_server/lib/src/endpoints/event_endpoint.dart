import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/compliance_calculator_service.dart';
import '../services/system_automation_service.dart';
import '../services/audit_service.dart';
import '../audit_event_types.dart';

/// Converts a Map<String, dynamic> to Map<String, String> for Serverpod wire serialization.
Map<String, String> _stringifyMap(Map<String, dynamic> m) =>
    m.map((k, v) => MapEntry(k, v is Map || v is List ? jsonEncode(v) : (v?.toString() ?? '')));

/// Event trigger endpoint — invokes workflow processors (Kafka/future calls, automation services).
/// Triggers future calls (SOP update retraining, employee onboarding).
/// Implements all Pharma LMS event workflows per GMP and 21 CFR Part 11.
class EventEndpoint extends Endpoint {
  /// Trigger SOP updated event - assigns retraining to all departments.
  Future<void> triggerSopUpdated(
    Session session, {
    required String documentId,
    required String courseVersionId,
    String reason = 'SOP update - manual trigger',
  }) async {
    await session.serverpod.endpoints.futureCalls!.callWithDelay(Duration.zero).kafkaEventProcessor
        .processSopUpdated(
      documentId: documentId,
      courseVersionId: courseVersionId,
      reason: reason,
    );
  }

  /// Trigger employee created event - assigns role-based training.
  Future<void> triggerEmployeeCreated(
    Session session, {
    required String userId,
    required String departmentId,
    required String roleId,
  }) async {
    await session.serverpod.endpoints.futureCalls!.callWithDelay(Duration.zero).kafkaEventProcessor
        .processEmployeeCreated(
      userId: userId,
      departmentId: departmentId,
      roleId: roleId,
    );
  }

  /// Trigger employee transferred event - assigns delta training for new role/dept.
  Future<void> triggerEmployeeTransferred(
    Session session, {
    required String userId,
    required String oldDepartmentId,
    required String newDepartmentId,
    required String oldRoleId,
    required String newRoleId,
  }) async {
    await session.serverpod.endpoints.futureCalls!.callWithDelay(Duration.zero).kafkaEventProcessor
        .processEmployeeTransferred(
      userId: userId,
      oldDepartmentId: oldDepartmentId,
      newDepartmentId: newDepartmentId,
      oldRoleId: oldRoleId,
      newRoleId: newRoleId,
    );
  }

  /// Trigger CAPA training complete event (SYS-WF-06).
  /// Sets effectiveness check due date and updates CAPA status.
  Future<Map<String, String>> triggerCapaTrainingComplete(
    Session session, {
    required int capaId,
  }) async {
    try {
      await SystemAutomationService.handleCapaTrainingCompleted(
        session,
        capaId: capaId,
      );
      return _stringifyMap({'success': true, 'capaId': capaId, 'message': 'CAPA training complete processed'});
    } catch (e) {
      return _stringifyMap({'success': false, 'capaId': capaId, 'error': e.toString()});
    }
  }

  /// SYS-WF-08b: Compliance Drop Alert - check departments below threshold and notify QA.
  /// Triggers: When compliance rate falls below configured threshold (default 90%).
  /// Actions: Creates compliance alerts, notifies QA team, records in audit trail.
  Future<Map<String, String>> triggerComplianceDropAlert(
    Session session, {
    double threshold = 0.90,
  }) async {
    try {
      final departments = await Department.db.find(session);
      final alertedDepartments = <Map<String, dynamic>>[];
      
      for (final dept in departments) {
        if (dept.id == null) continue;
        
        final metrics = await ComplianceCalculatorService.getDepartmentCompliance(
          session,
          departmentId: dept.id!,
        );
        
        if (metrics.complianceRate < threshold * 100) {
          alertedDepartments.add({
            'departmentId': dept.id,
            'departmentName': dept.name,
            'complianceRate': metrics.complianceRate,
            'threshold': threshold * 100,
            'overdue': metrics.overdue,
          });
          
          // Create notification for QA users (find by job role name containing 'qa' or 'quality')
          final qaRoles = await JobRole.db.find(
            session,
            where: (t) => t.name.ilike('%qa%') | t.name.ilike('%quality%'),
          );
          final qaRoleIds = qaRoles.map((r) => r.id).whereType<int>().toList();
          
          if (qaRoleIds.isNotEmpty) {
            final qaUsers = await PharmaUser.db.find(
              session,
              where: (t) => t.jobRoleId.inSet(qaRoleIds.toSet()),
              limit: 10,
            );
            
            for (final qa in qaUsers) {
              if (qa.id == null) continue;
              await Notification.db.insertRow(
                session,
                Notification(
                  userId: qa.id!,
                  type: 'compliance_drop_alert',
                  channel: 'in_app',
                  createdAt: DateTime.now(),
                ),
              );
            }
          }
          
          // Log to audit trail
          await AuditService.log(
            session,
            entityType: 'department',
            entityId: dept.id.toString(),
            action: AuditEventType.complianceDropAlert,
            newValueJson: jsonEncode({
              'departmentName': dept.name,
              'complianceRate': metrics.complianceRate,
              'threshold': threshold * 100,
            }),
            reason: 'Compliance drop detected - ${dept.name} at ${metrics.complianceRate.toStringAsFixed(1)}%',
          );
        }
      }
      
      return _stringifyMap({
        'success': true,
        'alertCount': alertedDepartments.length,
        'alertedDepartments': alertedDepartments,
        'threshold': threshold * 100,
      });
    } catch (e) {
      return _stringifyMap({'success': false, 'error': e.toString()});
    }
  }

  /// SYS-WF-09: New Training Course Release - assigns training to target roles.
  /// Triggers: When a new course version is published (status='effective').
  /// Actions: Uses TrainingMatrix to assign to affected job roles.
  Future<Map<String, String>> triggerNewCourseRelease(
    Session session, {
    required int courseVersionId,
  }) async {
    try {
      final courseVersion = await CourseVersion.db.findById(
        session, 
        courseVersionId,
        include: CourseVersion.include(course: Course.include()),
      );
      if (courseVersion == null) {
        return _stringifyMap({'success': false, 'error': 'Course version not found'});
      }
      
      final courseId = courseVersion.courseId;
      
      // Find training matrix entries for this course
      final matrixRows = await TrainingMatrix.db.find(
        session,
        where: (t) => t.courseId.equals(courseId),
      );
      
      if (matrixRows.isEmpty) {
        return _stringifyMap({
          'success': true,
          'message': 'No training matrix entries found for this course',
          'assignmentsCreated': 0,
        });
      }
      
      final assignedUserIds = <int>[];
      final dueDate = DateTime.now().add(const Duration(days: 30));
      final firstUser = await PharmaUser.db.find(session, limit: 1);
      final assignedById = firstUser.isNotEmpty && firstUser.first.id != null
          ? firstUser.first.id!
          : 1;
      
      for (final row in matrixRows) {
        final jobRoleId = row.jobRoleId;
        
        // Find users with this job role
        final users = await PharmaUser.db.find(
          session,
          where: (t) => t.jobRoleId.equals(jobRoleId),
        );
        
        for (final user in users) {
          if (user.id == null) continue;
          
          // Check for existing active enrollment
          final existing = await Enrollment.db.findFirstRow(
            session,
            where: (t) =>
                t.userId.equals(user.id!) &
                t.courseVersionId.equals(courseVersionId) &
                t.status.inSet({'not_started', 'in_progress'}),
          );
          
          if (existing != null) continue;
          
          // Create assignment
          final assignment = TrainingAssignment(
            userId: user.id!,
            courseVersionId: courseVersionId,
            assignedById: assignedById,
            dueDate: dueDate,
            reason: 'New course release: ${courseVersion.course?.title ?? 'Course $courseId'}',
            source: 'course_release',
            assignmentType: 'individual',
            targetUserId: user.id,
          );
          
          final savedAssignment = await TrainingAssignment.db.insertRow(session, assignment);
          
          // Create enrollment
          if (savedAssignment.id != null) {
            await Enrollment.db.insertRow(
              session,
              Enrollment(
                userId: user.id!,
                courseVersionId: courseVersionId,
                assignmentId: savedAssignment.id,
                status: 'not_started',
                startedAt: DateTime.now(),
              ),
            );
            assignedUserIds.add(user.id!);
          }
        }
      }
      
      // Log to audit trail
      await AuditService.log(
        session,
        entityType: 'course_version',
        entityId: courseVersionId.toString(),
        action: AuditEventType.courseReleaseAssigned,
        newValueJson: jsonEncode({
          'courseVersionId': courseVersionId,
          'assignedCount': assignedUserIds.length,
        }),
        reason: 'New course release - ${assignedUserIds.length} assignments created',
      );
      
      return _stringifyMap({
        'success': true,
        'courseVersionId': courseVersionId,
        'assignmentsCreated': assignedUserIds.length,
        'assignedUserIds': assignedUserIds,
      });
    } catch (e) {
      return _stringifyMap({'success': false, 'error': e.toString()});
    }
  }
}
