import 'package:serverpod/serverpod.dart';

/// Event trigger endpoint - stub for manual testing of workflow events.
/// Triggers future calls (SOP update retraining, employee onboarding).
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
}
