import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Material & progress endpoint (M1 + M2 upload).
class MaterialEndpoint extends Endpoint {
  Future<Material?> getMaterial(Session session, int id) async {
    return await Material.db.findById(session, id);
  }

  /// Get public URL for viewing material content (PDF, video, etc.).
  Future<String?> getMaterialViewUrl(
    Session session,
    String storageKey,
  ) async {
    final exists = await session.storage.fileExists(
      storageId: 'public',
      path: storageKey,
    );
    if (!exists) return null;
    final uri = await session.storage.getPublicUrl(
      storageId: 'public',
      path: storageKey,
    );
    return uri?.toString();
  }

  Future<Material> createMaterial(
    Session session, {
    required String title,
    required String materialType,
    required int organizationId,
  }) async {
    return await Material.db.insertRow(
      session,
      Material(
        title: title,
        materialType: materialType,
        organizationId: organizationId,
      ),
    );
  }

  /// Get upload description for direct client upload. Path like materials/{materialId}/v1.pdf
  Future<String?> getUploadDescription(
    Session session,
    String path,
  ) async {
    return await session.storage.createDirectFileUploadDescription(
      storageId: 'public',
      path: path,
    );
  }

  /// Verify upload completed; must be called or file may be deleted.
  Future<bool> verifyUpload(Session session, String path) async {
    return await session.storage.verifyDirectFileUpload(
      storageId: 'public',
      path: path,
    );
  }

  /// Create material version after successful upload.
  Future<MaterialVersion> createMaterialVersion(
    Session session, {
    required int materialId,
    required String storageKey,
  }) async {
    final existing = await MaterialVersion.db.find(
      session,
      where: (t) => t.materialId.equals(materialId),
    );
    final nextVersion = existing.isEmpty ? 1 : (existing.map((v) => v.version).reduce((a, b) => a > b ? a : b) + 1);
    return await MaterialVersion.db.insertRow(
      session,
      MaterialVersion(
        materialId: materialId,
        version: nextVersion,
        storageKey: storageKey,
      ),
    );
  }

  Future<List<MaterialVersion>> getMaterialVersions(
    Session session,
    int materialId,
  ) async {
    return await MaterialVersion.db.find(
      session,
      where: (t) => t.materialId.equals(materialId),
    );
  }

  Future<List<Material>> listMaterials(
    Session session, {
    required int organizationId,
  }) async {
    return await Material.db.find(
      session,
      where: (t) => t.organizationId.equals(organizationId),
    );
  }

  /// Update or create material progress for minimum read time / pausable learning.
  Future<MaterialProgress> updateProgress(
    Session session, {
    required int userId,
    required int materialId,
    required int progressPct,
    DateTime? completedAt,
    String? interactionJson,
  }) async {
    final existing = await MaterialProgress.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) & t.materialId.equals(materialId),
    );

    if (existing != null) {
      final updated = existing.copyWith(
        progressPct: progressPct,
        completedAt: completedAt ?? existing.completedAt,
        interactionJson: interactionJson ?? existing.interactionJson,
      );
      return await MaterialProgress.db.updateRow(session, updated);
    }

    return await MaterialProgress.db.insertRow(
      session,
      MaterialProgress(
        userId: userId,
        materialId: materialId,
        progressPct: progressPct,
        completedAt: completedAt,
        interactionJson: interactionJson,
      ),
    );
  }

  Future<MaterialProgress?> getProgress(
    Session session, {
    required int userId,
    required int materialId,
  }) async {
    return await MaterialProgress.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) & t.materialId.equals(materialId),
    );
  }
}
