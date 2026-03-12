import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'audit_service.dart';
import 'event_service.dart';

/// Training assignment service for creating and managing assignments.
class TrainingAssignmentService {
  /// Check if user has an active (non-completed) enrollment for a course version.
  static Future<bool> hasActiveEnrollment(
    Session session, {
    required int userId,
    required int courseVersionId,
  }) async {
    final existing = await Enrollment.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.courseVersionId.equals(courseVersionId) &
          t.status.notEquals('completed'),
    );
    return existing.isNotEmpty;
  }

  /// Assign a course version to a user.
  static Future<TrainingAssignment> assign(
    Session session, {
    required int userId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
    String priority = 'medium',
    String? reason,
    String source = 'manual',
  }) async {
    final assignment = TrainingAssignment(
      userId: userId,
      courseVersionId: courseVersionId,
      assignedById: assignedById,
      dueDate: dueDate,
      priority: priority,
      reason: reason,
      source: source,
    );
    final inserted = await TrainingAssignment.db.insertRow(session, assignment);

    await AuditService.log(
      session,
      entityType: 'training_assignment',
      entityId: inserted.id.toString(),
      action: 'TrainingAssigned',
      newValueJson:
          '{"courseVersionId":$courseVersionId,"userId":$userId,"dueDate":"${dueDate.toIso8601String()}","assignedById":$assignedById}',
      userId: assignedById,
    );

    if (inserted.id != null) {
      await EventService.emitAssignmentCreated(
        session,
        assignmentId: inserted.id!,
        userId: userId,
        courseVersionId: courseVersionId,
        dueDate: dueDate,
        source: source,
      );
    }

    return inserted;
  }

  /// Create enrollment from assignment.
  static Future<Enrollment> createEnrollment(
    Session session, {
    required int userId,
    required int courseVersionId,
    required int assignmentId,
    String? retrainingChangeSummary,
  }) async {
    final enrollment = Enrollment(
      userId: userId,
      courseVersionId: courseVersionId,
      assignmentId: assignmentId,
      status: 'not_started',
      retrainingChangeSummary: retrainingChangeSummary,
    );
    final inserted = await Enrollment.db.insertRow(session, enrollment);

    final assignment = await TrainingAssignment.db.findById(session, assignmentId);
    final assignedById = assignment?.assignedById;

    await AuditService.log(
      session,
      entityType: 'enrollment',
      entityId: inserted.id.toString(),
      action: 'EnrollmentCreated',
      newValueJson:
          '{"enrollmentId":${inserted.id},"courseVersionId":$courseVersionId,"userId":$userId}',
      userId: assignedById,
    );

    return inserted;
  }

  /// Update assignment due date or priority.
  static Future<TrainingAssignment> updateAssignment(
    Session session, {
    required int assignmentId,
    DateTime? dueDate,
    String? priority,
    required int updatedById,
  }) async {
    final existing = await TrainingAssignment.db.findById(session, assignmentId);
    if (existing == null) throw Exception('Assignment not found');
    if (existing.status == 'cancelled') {
      throw Exception('Cannot update cancelled assignment');
    }

    final oldJson =
        '{"dueDate":"${existing.dueDate.toIso8601String()}","priority":"${existing.priority}"}';
    final updated = existing.copyWith(
      dueDate: dueDate ?? existing.dueDate,
      priority: priority ?? existing.priority,
    );
    final result = await TrainingAssignment.db.updateRow(session, updated);

    await AuditService.log(
      session,
      entityType: 'training_assignment',
      entityId: assignmentId.toString(),
      action: 'AssignmentUpdated',
      oldValueJson: oldJson,
      newValueJson:
          '{"dueDate":"${result.dueDate.toIso8601String()}","priority":"${result.priority}"}',
      userId: updatedById,
    );

    return result;
  }

  /// Cancel an assignment.
  static Future<TrainingAssignment> cancelAssignment(
    Session session, {
    required int assignmentId,
    required int cancelledById,
    String? reason,
  }) async {
    final existing = await TrainingAssignment.db.findById(session, assignmentId);
    if (existing == null) throw Exception('Assignment not found');
    if (existing.status == 'cancelled') {
      throw Exception('Assignment already cancelled');
    }

    final now = DateTime.now();
    final updated = existing.copyWith(
      status: 'cancelled',
      cancelledAt: now,
      cancelledById: cancelledById,
      cancellationReason: reason,
    );
    final result = await TrainingAssignment.db.updateRow(session, updated);

    await AuditService.log(
      session,
      entityType: 'training_assignment',
      entityId: assignmentId.toString(),
      action: 'AssignmentCancelled',
      oldValueJson:
          '{"dueDate":"${existing.dueDate.toIso8601String()}","status":"${existing.status}"}',
      newValueJson: '{"cancelledAt":"${now.toIso8601String()}","reason":"$reason"}',
      userId: cancelledById,
    );

    return result;
  }

  /// Assign training to all users in a department for a course version.
  /// Skips users who already have an active enrollment for this course.
  static Future<List<TrainingAssignment>> assignToDepartment(
    Session session, {
    required int departmentId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
    String? reason,
    String source = 'manual',
    String? retrainingChangeSummary,
  }) async {
    final users = await PharmaUser.db.find(
      session,
      where: (t) => t.departmentId.equals(departmentId),
    );

    final assignments = <TrainingAssignment>[];
    for (final user in users) {
      if (user.id != null) {
        final hasActive = await hasActiveEnrollment(
          session,
          userId: user.id!,
          courseVersionId: courseVersionId,
        );
        if (hasActive) continue;

        final assignment = await assign(
          session,
          userId: user.id!,
          courseVersionId: courseVersionId,
          assignedById: assignedById,
          dueDate: dueDate,
          reason: reason,
          source: source,
        );
        assignments.add(assignment);

        await createEnrollment(
          session,
          userId: user.id!,
          courseVersionId: courseVersionId,
          assignmentId: assignment.id!,
          retrainingChangeSummary: retrainingChangeSummary,
        );
      }
    }
    return assignments;
  }
}
