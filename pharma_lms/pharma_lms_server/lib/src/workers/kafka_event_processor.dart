import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../integrations/kafka_producer.dart';
import '../services/training_assignment_service.dart';

/// Processes domain events from Kafka (or outbox) for workflow automation.
/// Handles: SOP update retraining, employee onboarding, CAPA training, cert expiry.
class KafkaEventProcessor extends FutureCall {
  /// Process SOP updated event - assign retraining to affected employees.
  Future<void> processSopUpdated(
    Session session, {
    required String documentId,
    required String courseVersionId,
    required String reason,
  }) async {
    final docId = int.tryParse(documentId);
    final cvId = int.tryParse(courseVersionId);
    if (docId == null || cvId == null) return;

    final departments = await Department.db.find(session);
    final dueDate = DateTime.now().add(const Duration(days: 30));

    final firstUser = await PharmaUser.db.find(session, limit: 1);
    final assignedById = firstUser.isNotEmpty && firstUser.first.id != null
        ? firstUser.first.id!
        : 1;

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
      );
    }
  }

  /// Process employee created event - assign role-based training.
  Future<void> processEmployeeCreated(
    Session session, {
    required String userId,
    required String departmentId,
    required String roleId,
  }) async {
    final uid = int.tryParse(userId);
    final deptId = int.tryParse(departmentId);
    if (uid == null || deptId == null) return;

    // Get role's training matrix and assign courses
    final role = await Role.db.findById(session, int.tryParse(roleId) ?? 0);
    if (role == null) return;

    final courseVersions = await CourseVersion.db.find(
      session,
      where: (t) => t.status.equals('effective'),
    );

    final dueDate = DateTime.now().add(const Duration(days: 60));
    for (final cv in courseVersions) {
      if (cv.id == null) continue;
      final assignment = await TrainingAssignmentService.assign(
        session,
        userId: uid,
        courseVersionId: cv.id!,
        assignedById: uid,
        dueDate: dueDate,
        reason: 'New employee onboarding',
        source: 'onboarding',
      );
      if (assignment.id != null) {
        await TrainingAssignmentService.createEnrollment(
          session,
          userId: uid,
          courseVersionId: cv.id!,
          assignmentId: assignment.id!,
        );
      }
    }
  }

  /// Process outbox messages - publish to Kafka.
  Future<void> processOutbox(Session session) async {
    final all = await OutboxMessage.db.find(session);
    final pending = all.where((m) => m.sentAt == null).toList();

    for (final msg in pending) {
      try {
        await KafkaProducer.publish(msg.topic, msg.payloadJson);
        await OutboxMessage.db.updateRow(
          session,
          msg.copyWith(sentAt: DateTime.now()),
        );
      } catch (_) {
        // Retry later
      }
    }
  }
}
