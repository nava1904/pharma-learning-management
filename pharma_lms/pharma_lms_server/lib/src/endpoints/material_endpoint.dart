import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/event_service.dart';
import '../services/rbac_helper.dart';

/// Material & progress endpoint (M1 + M2 upload).
class MaterialEndpoint extends Endpoint {
  Future<Material?> getMaterial(Session session, int id) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    await RbacHelper.requirePermission(session, resource: 'material', action: 'read');
    return await Material.db.findById(session, id);
  }

  /// Get public URL for viewing material content (PDF, video, SCORM, etc.).
  /// SCORM: storage key format materials/{id}/scorm/index.html for zip packages.
  Future<String?> getMaterialViewUrl(
    Session session,
    String storageKey,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    await RbacHelper.requirePermission(session, resource: 'material', action: 'read');
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
    await RbacHelper.requirePermission(session, resource: 'material', action: 'write');
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
    await RbacHelper.requirePermission(session, resource: 'material', action: 'write');
    return await session.storage.createDirectFileUploadDescription(
      storageId: 'public',
      path: path,
    );
  }

  /// Verify upload completed; must be called or file may be deleted.
  Future<bool> verifyUpload(Session session, String path) async {
    await RbacHelper.requirePermission(session, resource: 'material', action: 'write');
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
    await RbacHelper.requirePermission(session, resource: 'material', action: 'write');
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
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'material', action: 'read');
    return await MaterialVersion.db.find(
      session,
      where: (t) => t.materialId.equals(materialId),
    );
  }

  Future<List<Material>> listMaterials(
    Session session, {
    required int organizationId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'material', action: 'read');
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
    await RbacHelper.requirePermission(session, resource: 'material', action: 'read');
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
      final result = await MaterialProgress.db.updateRow(session, updated);
      await EventService.emitMaterialProgress(
        session,
        userId: userId,
        materialId: materialId,
        progressPct: progressPct,
        completedAt: completedAt ?? existing.completedAt,
        enrollmentId: enrollmentId ?? existing.enrollmentId,
        lessonId: lessonId,
      );
      if (enrollmentId != null &&
          progressPct > 0 &&
          (existing.progressPct == 0 || existing.progressPct < progressPct)) {
        final enrollment = await Enrollment.db.findById(session, enrollmentId);
        if (enrollment != null &&
            enrollment.startedAt == null &&
            enrollment.userId != null &&
            enrollment.courseVersionId != null) {
          final now = DateTime.now();
          await Enrollment.db.updateRow(
            session,
            enrollment.copyWith(
              status: 'in_progress',
              startedAt: now,
            ),
          );
          await EventService.emitEnrollmentStarted(
            session,
            enrollmentId: enrollmentId,
            userId: enrollment.userId!,
            courseVersionId: enrollment.courseVersionId!,
            startedAt: now,
          );
        }
      }
      return result;
    }

    final inserted = await MaterialProgress.db.insertRow(
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
    await EventService.emitMaterialProgress(
      session,
      userId: userId,
      materialId: materialId,
      progressPct: progressPct,
      completedAt: completedAt,
      enrollmentId: enrollmentId,
      lessonId: lessonId,
    );
    if (enrollmentId != null && progressPct > 0) {
      final enrollment = await Enrollment.db.findById(session, enrollmentId);
      if (enrollment != null &&
          enrollment.startedAt == null &&
          enrollment.userId != null &&
          enrollment.courseVersionId != null) {
        final now = DateTime.now();
        await Enrollment.db.updateRow(
          session,
          enrollment.copyWith(
            status: 'in_progress',
            startedAt: now,
          ),
        );
        await EventService.emitEnrollmentStarted(
          session,
          enrollmentId: enrollmentId,
          userId: enrollment.userId!,
          courseVersionId: enrollment.courseVersionId!,
          startedAt: now,
        );
      }
    }
    return inserted;
  }

  Future<MaterialProgress?> getProgress(
    Session session, {
    required int userId,
    required int materialId,
    int? enrollmentId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    await RbacHelper.requirePermission(session, resource: 'material', action: 'read');
    final all = await MaterialProgress.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) & t.materialId.equals(materialId),
    );
    if (enrollmentId != null) {
      final match = all.where((p) => p.enrollmentId == enrollmentId).toList();
      if (match.isNotEmpty) return match.first;
    }
    return all.isNotEmpty ? all.first : null;
  }

  /// Heartbeat: record engagement (tab_focused, scroll_depth, play_position).
  /// Server accumulates timeSpentSeconds only when tabFocused; sets readTimeMet
  /// when all conditions met (time, PDF scroll 80%, video 90%).
  /// videoPositionSeconds and scrollDepthPct stored for resume-from-last-position.
  Future<MaterialProgress> recordEngagement(
    Session session, {
    required int userId,
    required int materialId,
    required int lessonId,
    int? enrollmentId,
    required bool tabFocused,
    int? scrollDepthPct,
    int? videoWatchedPct,
    int? videoPositionSeconds,
    int deltaSeconds = 10,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'material', action: 'read');
    final lesson = await Lesson.db.findById(
      session,
      lessonId,
      include: Lesson.include(material: Material.include()),
    );
    if (lesson == null) throw Exception('Lesson not found');
    if (lesson.materialId != materialId) {
      throw Exception('Lesson materialId does not match');
    }

    final material = lesson.material;
    final durationMinutes = lesson.durationMinutes ?? 1;
    final requiredSeconds = durationMinutes * 60;

    var existing = await MaterialProgress.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) & t.materialId.equals(materialId),
    );

    int newTimeSpent = existing?.timeSpentSeconds ?? 0;
    if (tabFocused && deltaSeconds > 0) {
      newTimeSpent += deltaSeconds;
      if (newTimeSpent > requiredSeconds) newTimeSpent = requiredSeconds;
    }

    Map<String, dynamic> interaction = {};
    if (existing?.interactionJson != null) {
      try {
        final decoded = jsonDecode(existing!.interactionJson!) as Map<String, dynamic>?;
        if (decoded != null) interaction = Map<String, dynamic>.from(decoded);
      } on FormatException {
        // ignore
      }
    }
    if (scrollDepthPct != null) {
      interaction['pdfScrollPct'] = scrollDepthPct;
    }
    if (videoWatchedPct != null) {
      interaction['videoWatchedPct'] = videoWatchedPct;
    }
    if (videoPositionSeconds != null) {
      interaction['videoPositionSeconds'] = videoPositionSeconds;
    }
    final interactionJson = interaction.isEmpty ? null : jsonEncode(interaction);

    bool readTimeMet = existing?.readTimeMet ?? false;
    if (!readTimeMet && newTimeSpent >= requiredSeconds && material != null) {
      final type = material.materialType.toLowerCase();
      if (type == 'video') {
        final pct = interaction['videoWatchedPct'] as num?;
        readTimeMet = pct != null && pct >= 90;
      } else if (type == 'pdf') {
        final pct = interaction['pdfScrollPct'] as num?;
        readTimeMet = pct != null && pct >= 80;
      } else {
        readTimeMet = true;
      }
    }

    if (existing != null) {
      final updated = existing.copyWith(
        timeSpentSeconds: newTimeSpent,
        interactionJson: interactionJson ?? existing.interactionJson,
        readTimeMet: readTimeMet ? true : existing.readTimeMet,
        enrollmentId: enrollmentId ?? existing.enrollmentId,
      );
      return await MaterialProgress.db.updateRow(session, updated);
    }

    return await MaterialProgress.db.insertRow(
      session,
      MaterialProgress(
        userId: userId,
        materialId: materialId,
        progressPct: 0,
        timeSpentSeconds: newTimeSpent,
        interactionJson: interactionJson,
        readTimeMet: readTimeMet ? true : null,
        enrollmentId: enrollmentId,
      ),
    );
  }
}
