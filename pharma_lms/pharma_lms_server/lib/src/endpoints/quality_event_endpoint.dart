import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/training_assignment_service.dart';

/// Quality Event Integration domain endpoint.
class QualityEventEndpoint extends Endpoint {
  Future<List<QualityEvent>> listQualityEvents(
    Session session, {
    int? siteId,
    String? eventType,
    String? status,
  }) async {
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
    return await QualityEvent.db.findById(session, id);
  }

  Future<QualityEvent> createQualityEvent(
    Session session, {
    required String eventType,
    required String title,
    required String status,
    String? referenceId,
    int? siteId,
  }) async {
    final event = QualityEvent(
      eventType: eventType,
      referenceId: referenceId,
      title: title,
      status: status,
      siteId: siteId ?? 0,
    );
    return await QualityEvent.db.insertRow(session, event);
  }

  Future<Capa> createCapa(
    Session session, {
    required int qualityEventId,
    String? description,
    String? rootCause,
    bool trainingRequired = false,
  }) async {
    final capa = Capa(
      qualityEventId: qualityEventId,
      description: description,
      rootCause: rootCause,
      trainingRequired: trainingRequired,
    );
    return await Capa.db.insertRow(session, capa);
  }

  Future<TrainingAssignment?> assignTrainingFromCapa(
    Session session, {
    required int capaId,
    required int userId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
  }) async {
    final capa = await Capa.db.findById(session, capaId);
    if (capa == null) return null;

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
