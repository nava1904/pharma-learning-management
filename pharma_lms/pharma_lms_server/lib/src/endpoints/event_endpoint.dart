import 'package:serverpod/serverpod.dart';

import '../services/system_automation_service.dart';

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

  /// Trigger CAPA training complete event (SYS-WF-06).
  /// Sets effectiveness check due date and updates CAPA status.
  Future<Map<String, dynamic>> triggerCapaTrainingComplete(
    Session session, {
    required int capaId,
  }) async {
    try {
      await SystemAutomationService.handleCapaTrainingCompleted(
        session,
        capaId: capaId,
      );
      return {'success': true, 'capaId': capaId, 'message': 'CAPA training complete processed'};
    } catch (e) {
      return {'success': false, 'capaId': capaId, 'error': e.toString()};
    }
  }
}
