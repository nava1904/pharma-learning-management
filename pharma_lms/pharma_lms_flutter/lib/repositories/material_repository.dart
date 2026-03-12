import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../core/client.dart';

/// Repository for materials and progress. Decouples UI from client.material API.
class MaterialRepository {
  MaterialRepository([this._api]);

  dynamic get api => _api ?? client;
  final dynamic _api;

  Future<List<Material>> listMaterials({
    required int organizationId,
  }) =>
      api.material.listMaterials(organizationId: organizationId);

  Future<Material> createMaterial({
    required String title,
    required String materialType,
    required int organizationId,
  }) =>
      api.material.createMaterial(
        title: title,
        materialType: materialType,
        organizationId: organizationId,
      );

  Future<String?> getUploadDescription(String path) =>
      api.material.getUploadDescription(path);

  Future<void> verifyUpload(String path) =>
      api.material.verifyUpload(path);

  Future<MaterialVersion> createMaterialVersion({
    required int materialId,
    required String storageKey,
  }) =>
      api.material.createMaterialVersion(
        materialId: materialId,
        storageKey: storageKey,
      );

  Future<String?> getMaterialViewUrl(String storageKey) =>
      api.material.getMaterialViewUrl(storageKey);

  Future<MaterialProgress?> getProgress({
    required int userId,
    required int materialId,
    int? enrollmentId,
  }) =>
      api.material.getProgress(
        userId: userId,
        materialId: materialId,
        enrollmentId: enrollmentId,
      );

  Future<MaterialProgress> recordEngagement({
    required int userId,
    required int materialId,
    required int lessonId,
    int? enrollmentId,
    required bool tabFocused,
    int? scrollDepthPct,
    int? videoWatchedPct,
    int? videoPositionSeconds,
    int deltaSeconds = 10,
  }) =>
      api.material.recordEngagement(
        userId: userId,
        materialId: materialId,
        lessonId: lessonId,
        enrollmentId: enrollmentId,
        tabFocused: tabFocused,
        scrollDepthPct: scrollDepthPct,
        videoWatchedPct: videoWatchedPct,
        videoPositionSeconds: videoPositionSeconds,
        deltaSeconds: deltaSeconds,
      );

  Future<MaterialProgress> updateProgress({
    required int userId,
    required int materialId,
    int? progressPct,
    DateTime? completedAt,
    int? timeSpentSeconds,
    bool? readTimeMet,
    int? lessonId,
    int? enrollmentId,
    String? interactionJson,
  }) =>
      api.material.updateProgress(
        userId: userId,
        materialId: materialId,
        progressPct: progressPct,
        completedAt: completedAt,
        timeSpentSeconds: timeSpentSeconds,
        readTimeMet: readTimeMet,
        lessonId: lessonId,
        enrollmentId: enrollmentId,
        interactionJson: interactionJson,
      );
}
