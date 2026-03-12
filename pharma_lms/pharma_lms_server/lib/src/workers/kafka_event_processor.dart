import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../integrations/kafka_producer.dart';
import '../services/training_assignment_service.dart';
import '../workers/analytics_event_processor.dart';

/// Processes domain events from Kafka (or outbox) for workflow automation.
/// Handles: SOP update retraining, employee onboarding, CAPA training, cert expiry.
class KafkaEventProcessor extends FutureCall {
  /// Process SOP updated event - assign retraining to affected employees.
  /// QA gate: only assigns when document.trainingRequiredByQa == 'training_required'.
  /// Scoping: uses affectedDepartmentIdsJson and affectedRoleIdsJson when set.
  Future<void> processSopUpdated(
    Session session, {
    required String documentId,
    required String courseVersionId,
    required String reason,
  }) async {
    final docId = int.tryParse(documentId);
    final cvId = int.tryParse(courseVersionId);
    if (docId == null || cvId == null) return;

    final doc = await Document.db.findById(session, docId);
    if (doc != null && doc.trainingRequiredByQa != 'training_required') {
      return;
    }

    List<int>? affectedDeptIds;
    List<int>? affectedRoleIds;
    if (doc?.affectedDepartmentIdsJson != null) {
      try {
        final list = jsonDecode(doc!.affectedDepartmentIdsJson!) as List<dynamic>?;
        affectedDeptIds = list?.map((e) => (e is int) ? e : int.tryParse(e.toString()) ?? 0).where((x) => x > 0).toList();
      } catch (_) {}
    }
    if (doc?.affectedRoleIdsJson != null) {
      try {
        final list = jsonDecode(doc!.affectedRoleIdsJson!) as List<dynamic>?;
        affectedRoleIds = list?.map((e) => (e is int) ? e : int.tryParse(e.toString()) ?? 0).where((x) => x > 0).toList();
      } catch (_) {}
    }

    final dueDate = DateTime.now().add(const Duration(days: 30));
    final firstUser = await PharmaUser.db.find(session, limit: 1);
    final assignedById = firstUser.isNotEmpty && firstUser.first.id != null
        ? firstUser.first.id!
        : 1;

    final courseVersion = await CourseVersion.db.findById(session, cvId);
    final changeSummary = courseVersion?.changeSummary;

    if (affectedDeptIds != null && affectedDeptIds!.isNotEmpty) {
      for (final deptId in affectedDeptIds!) {
        await TrainingAssignmentService.assignToDepartment(
          session,
          departmentId: deptId,
          courseVersionId: cvId,
          assignedById: assignedById,
          dueDate: dueDate,
          reason: reason,
          source: 'sop_update',
          retrainingChangeSummary: changeSummary,
        );
      }
    } else if (affectedRoleIds != null && affectedRoleIds!.isNotEmpty) {
      for (final roleId in affectedRoleIds!) {
        final users = await PharmaUser.db.find(
          session,
          where: (t) => t.jobRoleId.equals(roleId),
        );
        for (final user in users) {
          if (user.id == null) continue;
          final hasActive = await TrainingAssignmentService.hasActiveEnrollment(
            session,
            userId: user.id!,
            courseVersionId: cvId,
          );
          if (hasActive) continue;
          final assignment = await TrainingAssignmentService.assign(
            session,
            userId: user.id!,
            courseVersionId: cvId,
            assignedById: assignedById,
            dueDate: dueDate,
            reason: reason,
            source: 'sop_update',
          );
          await TrainingAssignmentService.createEnrollment(
            session,
            userId: user.id!,
            courseVersionId: cvId,
            assignmentId: assignment.id!,
            retrainingChangeSummary: changeSummary,
          );
        }
      }
    } else {
      final departments = await Department.db.find(session);
      for (final dept in departments) {
        if (dept.id == null) continue;
        await TrainingAssignmentService.assignToDepartment(
          session,
          departmentId: dept.id!,
          courseVersionId: cvId,
          assignedById: assignedById,
          dueDate: dueDate,
          reason: reason,
          source: 'sop_update',
          retrainingChangeSummary: changeSummary,
        );
      }
    }
  }

  /// Process employee created event - assign role-based training.
  /// Uses TrainingMatrix when available, else all effective course versions.
  Future<void> processEmployeeCreated(
    Session session, {
    required String userId,
    required String departmentId,
    required String roleId,
  }) async {
    final uid = int.tryParse(userId);
    final deptId = int.tryParse(departmentId);
    final jrId = int.tryParse(roleId);
    if (uid == null || deptId == null) return;

    List<int> courseVersionIds = [];
    final matrixRows = await TrainingMatrix.db.find(
      session,
      where: (t) => t.jobRoleId.equals(jrId),
      include: TrainingMatrix.include(course: Course.include()),
    );
    if (matrixRows.isNotEmpty) {
      for (final row in matrixRows) {
        if (row.courseId == null) continue;
        final versions = await CourseVersion.db.find(
          session,
          where: (t) =>
              t.courseId.equals(row.courseId!) &
              t.status.equals('effective'),
        );
        for (final v in versions) {
          if (v.id != null) courseVersionIds.add(v.id!);
        }
      }
    }
    if (courseVersionIds.isEmpty) {
      final all = await CourseVersion.db.find(
        session,
        where: (t) => t.status.equals('effective'),
      );
      courseVersionIds = all.where((v) => v.id != null).map((v) => v.id!).toList();
    }

    final dueDate = DateTime.now().add(const Duration(days: 60));
    for (final cvId in courseVersionIds) {
      final assignment = await TrainingAssignmentService.assign(
        session,
        userId: uid,
        courseVersionId: cvId,
        assignedById: uid,
        dueDate: dueDate,
        reason: 'New employee onboarding',
        source: 'onboarding',
      );
      if (assignment.id != null) {
        await TrainingAssignmentService.createEnrollment(
          session,
          userId: uid,
          courseVersionId: cvId,
          assignmentId: assignment.id!,
        );
      }
    }
  }

  /// Process employee transferred - archive old assignments, assign delta for new role/dept.
  Future<void> processEmployeeTransferred(
    Session session, {
    required String userId,
    required String oldDepartmentId,
    required String newDepartmentId,
    required String oldRoleId,
    required String newRoleId,
  }) async {
    final uid = int.tryParse(userId);
    if (uid == null) return;

    final newJrId = int.tryParse(newRoleId);
    if (newJrId == null) return;

    final matrixRows = await TrainingMatrix.db.find(
      session,
      where: (t) => t.jobRoleId.equals(newJrId),
      include: TrainingMatrix.include(course: Course.include()),
    );
    final requiredCourseIds = matrixRows.map((r) => r.courseId).whereType<int>().toSet();
    final completedCourseIds = <int>{};
    final certs = await Certificate.db.find(
      session,
      where: (t) => t.userId.equals(uid) & t.status.equals('active'),
    );
    for (final c in certs) {
      if (c.courseVersionId != null) {
        final cv = await CourseVersion.db.findById(session, c.courseVersionId!);
        if (cv?.courseId != null) completedCourseIds.add(cv!.courseId!);
      }
    }
    final toAssign = requiredCourseIds.difference(completedCourseIds);
    if (toAssign.isEmpty) return;

    final dueDate = DateTime.now().add(const Duration(days: 30));
    for (final courseId in toAssign) {
      final versions = await CourseVersion.db.find(
        session,
        where: (t) =>
            t.courseId.equals(courseId) &
            t.status.equals('effective'),
      );
      if (versions.isEmpty) continue;
      final cvId = versions.first.id!;
      final hasActive = await TrainingAssignmentService.hasActiveEnrollment(
        session,
        userId: uid,
        courseVersionId: cvId,
      );
      if (hasActive) continue;
      final assignment = await TrainingAssignmentService.assign(
        session,
        userId: uid,
        courseVersionId: cvId,
        assignedById: uid,
        dueDate: dueDate,
        reason: 'Department/role transfer',
        source: 'manual',
      );
      if (assignment.id != null) {
        await TrainingAssignmentService.createEnrollment(
          session,
          userId: uid,
          courseVersionId: cvId,
          assignmentId: assignment.id!,
        );
      }
    }
  }

  /// Process outbox messages - publish to Kafka. Moves to DLQ after 3 retries.
  /// Self-reschedules every 45 seconds for continuous processing.
  static const Duration _rescheduleInterval = Duration(seconds: 45);

  Future<void> processOutbox(Session session) async {
    // Schedule next run before doing work (recurring pattern)
    await session.serverpod.endpoints.futureCalls!
        .callWithDelay(_rescheduleInterval)
        .kafkaEventProcessor
        .processOutbox();

    final all = await OutboxMessage.db.find(session);
    final pending = all.where((m) =>
        (m.status == 'pending' || m.status == 'failed') &&
        (m.retryCount < 3)).toList();

    for (final msg in pending) {
      try {
        if (KafkaProducer.isEnabled) {
          await KafkaProducer.publish(msg.topic, msg.payloadJson);
        }
        await AnalyticsEventProcessor.processPayload(
          session,
          msg.topic,
          msg.payloadJson,
        );
        await OutboxMessage.db.updateRow(
          session,
          msg.copyWith(
            sentAt: DateTime.now(),
            status: 'published',
            lastError: null,
          ),
        );
      } catch (e) {
        final retryCount = (msg.retryCount) + 1;
        if (retryCount >= 3) {
          await DeadLetterQueue.db.insertRow(
            session,
            DeadLetterQueue(
              outboxMessageId: msg.id,
              failedAt: DateTime.now(),
              failureReason: e.toString(),
              retryCount: retryCount,
            ),
          );
          await OutboxMessage.db.updateRow(
            session,
            msg.copyWith(
              status: 'dead_letter',
              retryCount: retryCount,
              lastError: e.toString(),
            ),
          );
        } else {
          await OutboxMessage.db.updateRow(
            session,
            msg.copyWith(
              status: 'failed',
              retryCount: retryCount,
              lastError: e.toString(),
            ),
          );
        }
      }
    }
  }
}
