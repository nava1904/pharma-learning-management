import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/rbac_helper.dart';
import '../services/training_assignment_service.dart';

/// Quality Event Integration domain endpoint.
class QualityEventEndpoint extends Endpoint {
  Future<List<QualityEvent>> listQualityEvents(
    Session session, {
    int? siteId,
    String? eventType,
    String? status,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'read');
    var results = await QualityEvent.db.find(session);
    if (siteId != null) {
      results = results.where((e) => e.siteId == siteId).toList();
    }
    if (eventType != null) {
      results = results.where((e) => e.eventType == eventType).toList();
    }
    if (status != null) {
      results = results.where((e) => e.status == status).toList();
    }
    return results;
  }

  Future<QualityEvent?> getQualityEvent(Session session, int id) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'read');
    return await QualityEvent.db.findById(session, id);
  }

  Future<List<Capa>> listCapas(
    Session session, {
    int? qualityEventId,
    String? status,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'read');
    var results = await Capa.db.find(
      session,
      include: Capa.include(qualityEvent: QualityEvent.include()),
    );
    if (qualityEventId != null) {
      results = results.where((c) => c.qualityEventId == qualityEventId).toList();
    }
    if (status != null) {
      results = results.where((c) => c.status == status).toList();
    }
    return results;
  }

  Future<QualityEvent> createQualityEvent(
    Session session, {
    required String eventType,
    required String title,
    required String status,
    String? referenceId,
    int? siteId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'write');
    final event = QualityEvent(
      eventType: eventType,
      referenceId: referenceId,
      title: title,
      status: status,
      siteId: siteId ?? 0,
    );
    return await QualityEvent.db.insertRow(session, event);
  }

  /// Valid CAPA state transitions (QA-003 formal lifecycle).
  static const _validTransitions = <String, Set<String>>{
    'Initiation': {'Investigation'},
    'Investigation': {'ActionPlanApproved'},
    'ActionPlanApproved': {'Implementation'},
    'Implementation': {'Verification'},
    'Verification': {'Closed'},
    'Closed': {},
  };

  /// Update CAPA lifecycle status. Enforces valid state machine transitions.
  Future<Capa> updateCapaStatus(
    Session session, {
    required int capaId,
    required String status,
    String? rootCause,
    DateTime? rcaCompletedAt,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'write');
    final capa = await Capa.db.findById(session, capaId);
    if (capa == null) throw Exception('CAPA not found');
    if (capa.status == 'Closed') throw Exception('Cannot update closed CAPA');

    final allowed = _validTransitions[capa.status];
    if (allowed == null || !allowed.contains(status)) {
      throw Exception(
        'Invalid CAPA transition: ${capa.status} -> $status. '
        'Allowed: ${allowed?.join(", ") ?? "none"}',
      );
    }

    var updated = capa.copyWith(
      status: status,
      rootCause: rootCause ?? capa.rootCause,
      rcaCompletedAt: rcaCompletedAt ?? capa.rcaCompletedAt,
    );
    final result = await Capa.db.updateRow(session, updated);
    await AuditService.log(
      session,
      entityType: 'capa',
      entityId: capaId.toString(),
      action: 'CapaStatusChanged',
      oldValueJson: '{"status":"${capa.status}"}',
      newValueJson: '{"status":"$status"}',
    );
    return result;
  }

  /// Close CAPA (QA verifies no recurrence).
  /// Requires: status must be Verification; if trainingRequired, effectivenessCheckDue must be set.
  Future<Capa> closeCapa(
    Session session, {
    required int capaId,
    required int closedById,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'write');
    final capa = await Capa.db.findById(session, capaId);
    if (capa == null) throw Exception('CAPA not found');
    if (capa.status == 'Closed') throw Exception('CAPA already closed');
    if (capa.status != 'Verification') {
      throw Exception(
        'CAPA must be in Verification status before closing. Current: ${capa.status}',
      );
    }
    if (capa.trainingRequired && capa.effectivenessCheckDue == null) {
      throw Exception(
        'Effectiveness check must be scheduled (effectivenessCheckDue) before closing CAPA with training',
      );
    }
    final updated = capa.copyWith(
      status: 'Closed',
      closedAt: DateTime.now(),
      closedById: closedById,
    );
    final result = await Capa.db.updateRow(session, updated);
    await AuditService.log(
      session,
      entityType: 'capa',
      entityId: capaId.toString(),
      action: 'CapaClosed',
      newValueJson: '{"closedById":$closedById}',
      userId: closedById,
    );
    return result;
  }

  Future<Capa> createCapa(
    Session session, {
    required int qualityEventId,
    String? description,
    String? rootCause,
    bool trainingRequired = false,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'write');
    final capa = Capa(
      qualityEventId: qualityEventId,
      description: description,
      rootCause: rootCause,
      trainingRequired: trainingRequired,
    );
    final result = await Capa.db.insertRow(session, capa);
    await AuditService.log(
      session,
      entityType: 'capa',
      entityId: result.id.toString(),
      action: 'CapaCreated',
      newValueJson: '{"qualityEventId":$qualityEventId,"trainingRequired":$trainingRequired}',
    );
    return result;
  }

  Future<TrainingAssignment?> assignTrainingFromCapa(
    Session session, {
    required int capaId,
    required int userId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'write');
    final capa = await Capa.db.findById(session, capaId);
    if (capa == null) return null;

    final hasActive = await TrainingAssignmentService.hasActiveEnrollment(
      session,
      userId: userId,
      courseVersionId: courseVersionId,
    );
    if (hasActive) return null;

    final assignment = await TrainingAssignmentService.assign(
      session,
      userId: userId,
      courseVersionId: courseVersionId,
      assignedById: assignedById,
      dueDate: dueDate,
      reason: 'CAPA corrective training',
      source: 'capa',
    );

    if (assignment.id != null) {
      await Capa.db.updateRow(
        session,
        capa.copyWith(trainingAssignmentId: assignment.id),
      );
    }

    await TrainingAssignmentService.createEnrollment(
      session,
      userId: userId,
      courseVersionId: courseVersionId,
      assignmentId: assignment.id!,
    );

    return assignment;
  }

  Future<List<InspectionReport>> listInspectionReports(
    Session session, {
    int? organizationId,
    int? siteId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'inspection', action: 'read');
    if (organizationId != null) {
      var results = await InspectionReport.db.find(
        session,
        where: (t) => t.organizationId.equals(organizationId),
      );
      if (siteId != null) {
        results = results.where((r) => r.siteId == siteId).toList();
      }
      return results;
    }
    return await InspectionReport.db.find(session);
  }

  Future<InspectionReport> createInspectionReport(
    Session session, {
    required int organizationId,
    required String status,
    int? siteId,
    String? inspector,
    DateTime? inspectionDate,
    String? findingsJson,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'inspection', action: 'write');
    final report = InspectionReport(
      organizationId: organizationId,
      siteId: siteId ?? 0,
      inspector: inspector,
      inspectionDate: inspectionDate,
      findingsJson: findingsJson,
      status: status,
    );
    return await InspectionReport.db.insertRow(session, report);
  }
}
