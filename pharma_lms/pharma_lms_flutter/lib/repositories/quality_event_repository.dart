import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../core/client.dart';

/// Repository for quality events and CAPA. Decouples UI from client.qualityEvent API.
class QualityEventRepository {
  QualityEventRepository([this._api]);

  dynamic get api => _api ?? client;
  final dynamic _api;

  Future<List<QualityEvent>> listQualityEvents({
    String? eventType,
    String? status,
  }) =>
      api.qualityEvent.listQualityEvents(
        eventType: eventType,
        status: status,
      );

  Future<List<Capa>> listCapas({String? status}) =>
      api.qualityEvent.listCapas(status: status);

  Future<QualityEvent> createQualityEvent({
    required String eventType,
    required String title,
    required String status,
    String? referenceId,
  }) =>
      api.qualityEvent.createQualityEvent(
        eventType: eventType,
        title: title,
        status: status,
        referenceId: referenceId,
      );

  Future<Capa> createCapa({
    required int qualityEventId,
    String? description,
    String? rootCause,
    bool trainingRequired = false,
  }) =>
      api.qualityEvent.createCapa(
        qualityEventId: qualityEventId,
        description: description,
        rootCause: rootCause,
        trainingRequired: trainingRequired,
      );

  Future<Capa> updateCapaStatus({
    required int capaId,
    required String status,
  }) =>
      api.qualityEvent.updateCapaStatus(
        capaId: capaId,
        status: status,
      );

  Future<Capa> closeCapa({
    required int capaId,
    required int closedById,
  }) =>
      api.qualityEvent.closeCapa(
        capaId: capaId,
        closedById: closedById,
      );
}
