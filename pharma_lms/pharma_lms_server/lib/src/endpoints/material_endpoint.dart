import 'dart:convert';

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
  /// Server-enforced: when progressPct=100 or completedAt is set, requires
  /// timeSpentSeconds >= lesson.durationMinutes*60, readTimeMet=true, and
  /// for video: videoWatchedPct>=90, for pdf: pdfScrollPct>=80 in interactionJson.
  Future<MaterialProgress> updateProgress(
    Session session, {
    required int userId,
    required int materialId,
    required int progressPct,
    DateTime? completedAt,
    String? interactionJson,
    int? timeSpentSeconds,
    bool? readTimeMet,
    int? materialVersionId,
    int? enrollmentId,
    int? lessonId,
  }) async {
    final isCompletion = progressPct >= 100 || completedAt != null;

    if (isCompletion && lessonId != null) {
      final lesson = await Lesson.db.findById(
        session,
        lessonId,
        include: Lesson.include(material: Material.include()),
      );
      if (lesson == null) throw Exception('Lesson not found');
      if (lesson.materialId != materialId) {
        throw Exception('Lesson materialId does not match');
      }

      final durationMinutes = lesson.durationMinutes ?? 1;
      final requiredSeconds = durationMinutes * 60;

      if (timeSpentSeconds == null || timeSpentSeconds < requiredSeconds) {
        throw Exception(
          'Minimum read time not met: need $requiredSeconds seconds, got ${timeSpentSeconds ?? 0}',
        );
      }
      if (readTimeMet != true) {
        throw Exception('Read time must be explicitly acknowledged');
      }

      final material = lesson.material;
      if (material != null && interactionJson != null) {
        try {
          final json = jsonDecode(interactionJson) as Map<String, dynamic>?;
          if (json != null) {
            final type = material.materialType.toLowerCase();
            if (type == 'video') {
              final pct = json['videoWatchedPct'] as num?;
              if (pct != null && pct < 90) {
                throw Exception(
                  'Video engagement rule: must watch at least 90%, got $pct%',
                );
              }
            } else if (type == 'pdf') {
              final pct = json['pdfScrollPct'] as num?;
              if (pct != null && pct < 80) {
                throw Exception(
                  'PDF engagement rule: must scroll at least 80%, got $pct%',
                );
              }
            }
          }
        } on FormatException {
          // interactionJson invalid; for video/pdf we may reject
          if (material.materialType.toLowerCase() == 'video' ||
              material.materialType.toLowerCase() == 'pdf') {
            throw Exception(
              'Invalid interaction data for ${material.materialType} material',
            );
          }
        }
      }
    }

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
        timeSpentSeconds: timeSpentSeconds ?? existing.timeSpentSeconds,
        readTimeMet: readTimeMet ?? existing.readTimeMet,
        materialVersionId: materialVersionId ?? existing.materialVersionId,
        enrollmentId: enrollmentId ?? existing.enrollmentId,
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
        timeSpentSeconds: timeSpentSeconds,
        readTimeMet: readTimeMet,
        materialVersionId: materialVersionId,
        enrollmentId: enrollmentId,
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
