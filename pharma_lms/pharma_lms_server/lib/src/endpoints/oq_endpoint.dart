import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/esignature_service.dart';
import '../services/rbac_helper.dart';

/// Converts a Map<String, dynamic> to Map<String, String> for Serverpod wire serialization.
Map<String, String> _stringifyMap(Map<String, dynamic> m) =>
    m.map((k, v) => MapEntry(k, v is Map || v is List ? jsonEncode(v) : (v?.toString() ?? '')));

/// Operator Qualification (OQ) / On-the-Job Training (OJT) workflow endpoint.
/// Implements the 4-phase OQ process: Theoretical → Practical → Dual E-Signature → QA Verification.
class OqEndpoint extends Endpoint {
  // ─── Practical Checklist Management ───────────────────────────────

  /// Create a practical checklist item for a competency.
  Future<PracticalChecklistItem?> createChecklistItem(
    Session session, {
    required int competencyId,
    required String title,
    String? description,
    int orderIndex = 0,
    bool isCritical = false,
    required int organizationId,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return null;
    await RbacHelper.requirePermission(session, resource: 'training', action: 'create');

    final item = PracticalChecklistItem(
      competencyId: competencyId,
      title: title,
      description: description,
      orderIndex: orderIndex,
      isCritical: isCritical,
      organizationId: organizationId,
    );
    final result = await PracticalChecklistItem.db.insertRow(session, item);

    await AuditService.log(
      session,
      entityType: 'practical_checklist_item',
      entityId: result.id.toString(),
      action: 'ChecklistItemCreated',
      newValueJson: '{"competencyId":$competencyId,"title":"$title","isCritical":$isCritical}',
      userId: me!.id,
    );

    return result;
  }

  /// List all checklist items for a competency.
  Future<List<PracticalChecklistItem>> listChecklistItems(
    Session session, {
    required int competencyId,
    int? organizationId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];

    var whereExpr = PracticalChecklistItem.t.competencyId.equals(competencyId);
    if (organizationId != null) {
      whereExpr = whereExpr & PracticalChecklistItem.t.organizationId.equals(organizationId);
    }

    return PracticalChecklistItem.db.find(
      session,
      where: (_) => whereExpr,
      orderBy: (t) => t.orderIndex,
      include: PracticalChecklistItem.include(
        competency: Competency.include(),
      ),
    );
  }

  /// Update a checklist item.
  Future<PracticalChecklistItem?> updateChecklistItem(
    Session session, {
    required int itemId,
    String? title,
    String? description,
    int? orderIndex,
    bool? isCritical,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return null;
    await RbacHelper.requirePermission(session, resource: 'training', action: 'update');

    final existing = await PracticalChecklistItem.db.findById(session, itemId);
    if (existing == null) return null;

    return PracticalChecklistItem.db.updateRow(
      session,
      existing.copyWith(
        title: title ?? existing.title,
        description: description ?? existing.description,
        orderIndex: orderIndex ?? existing.orderIndex,
        isCritical: isCritical ?? existing.isCritical,
      ),
    );
  }

  /// Delete a checklist item.
  Future<bool> deleteChecklistItem(Session session, int itemId) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'delete');
    final existing = await PracticalChecklistItem.db.findById(session, itemId);
    if (existing == null) return false;
    await PracticalChecklistItem.db.deleteRow(session, existing);
    return true;
  }

  // ─── Observation Logging (Practical Phase) ────────────────────────

  /// Record an observation for a trainee on a checklist item.
  /// Evaluator signs with e-signature.
  Future<ObservationLog?> recordObservation(
    Session session, {
    required int userId,
    required int competencyId,
    required int checklistItemId,
    required String result,
    String? notes,
    required String evaluatorSignatureMeaning,
    String? evaluatorPasswordPlaintext,
    required int organizationId,
  }) async {
    final evaluator = await RbacHelper.getCurrentPharmaUser(session);
    if (evaluator?.id == null) return null;
    await RbacHelper.requirePermission(session, resource: 'training', action: 'assign');

    if (evaluator!.id == userId) {
      throw Exception('Evaluator cannot evaluate themselves');
    }

    // Validate the checklist item belongs to the competency
    final item = await PracticalChecklistItem.db.findById(session, checklistItemId);
    if (item == null || item.competencyId != competencyId) {
      throw Exception('Invalid checklist item for this competency');
    }

    // Evaluator e-signature
    final evaluatorSig = await EsignatureService.sign(
      session,
      userId: evaluator.id!,
      signatureMeaning: evaluatorSignatureMeaning,
      entityType: 'observation_log',
      entityId: '${userId}_$checklistItemId',
      passwordPlaintext: evaluatorPasswordPlaintext,
    );

    final log = ObservationLog(
      userId: userId,
      evaluatorId: evaluator.id!,
      competencyId: competencyId,
      checklistItemId: checklistItemId,
      result: result,
      notes: notes,
      evaluatorEsignatureId: evaluatorSig.id,
      organizationId: organizationId,
    );

    final saved = await ObservationLog.db.insertRow(session, log);

    await AuditService.log(
      session,
      entityType: 'observation_log',
      entityId: saved.id.toString(),
      action: 'ObservationRecorded',
      newValueJson:
          '{"userId":$userId,"competencyId":$competencyId,"checklistItemId":$checklistItemId,"result":"$result","evaluatorId":${evaluator.id}}',
      userId: evaluator.id,
    );

    return saved;
  }

  /// Trainee countersigns an observation (dual e-signature).
  Future<ObservationLog?> traineeCountersignObservation(
    Session session, {
    required int observationLogId,
    required String signatureMeaning,
    String? passwordPlaintext,
  }) async {
    final trainee = await RbacHelper.getCurrentPharmaUser(session);
    if (trainee?.id == null) return null;

    final log = await ObservationLog.db.findById(session, observationLogId);
    if (log == null) throw Exception('Observation log not found');
    if (log.userId != trainee!.id) {
      throw Exception('Only the trainee can countersign this observation');
    }
    if (log.traineeEsignatureId != null) {
      throw Exception('Trainee has already countersigned this observation');
    }

    final traineeSig = await EsignatureService.sign(
      session,
      userId: trainee.id!,
      signatureMeaning: signatureMeaning,
      entityType: 'observation_log_trainee',
      entityId: observationLogId.toString(),
      passwordPlaintext: passwordPlaintext,
    );

    final updated = log.copyWith(traineeEsignatureId: traineeSig.id);
    final result = await ObservationLog.db.updateRow(session, updated);

    await AuditService.log(
      session,
      entityType: 'observation_log',
      entityId: observationLogId.toString(),
      action: 'TraineeCountersigned',
      newValueJson:
          '{"traineeId":${trainee.id},"traineeEsignatureId":${traineeSig.id}}',
      userId: trainee.id,
    );

    return result;
  }

  /// List observation logs for a user + competency.
  Future<List<ObservationLog>> listObservationsForUser(
    Session session, {
    required int userId,
    int? competencyId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];

    var whereExpr = ObservationLog.t.userId.equals(userId);
    if (competencyId != null) {
      whereExpr = whereExpr & ObservationLog.t.competencyId.equals(competencyId);
    }

    return ObservationLog.db.find(
      session,
      where: (_) => whereExpr,
      orderBy: (t) => t.observedAt,
      orderDescending: true,
      include: ObservationLog.include(
        user: PharmaUser.include(),
        evaluator: PharmaUser.include(),
        competency: Competency.include(),
        checklistItem: PracticalChecklistItem.include(),
      ),
    );
  }

  // ─── OQ Completion Check ──────────────────────────────────────────

  /// Check if all practical checklist items for a competency are passed by a user,
  /// with both evaluator and trainee e-signatures.
  Future<Map<String, String>> getOqProgress(
    Session session, {
    required int userId,
    required int competencyId,
    required int organizationId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) {
      return _emptyProgress();
    }

    final items = await PracticalChecklistItem.db.find(
      session,
      where: (t) =>
          t.competencyId.equals(competencyId) &
          t.organizationId.equals(organizationId),
      orderBy: (t) => t.orderIndex,
    );

    if (items.isEmpty) {
      return _stringifyMap({
        'totalItems': 0,
        'passedItems': 0,
        'failedItems': 0,
        'pendingItems': 0,
        'allPassed': false,
        'allDualSigned': false,
        'progressPct': 0.0,
        'details': <Map<String, dynamic>>[],
      });
    }

    int passed = 0;
    int failed = 0;
    int pending = 0;
    bool allDualSigned = true;
    final details = <Map<String, dynamic>>[];

    for (final item in items) {
      final observation = await ObservationLog.db.findFirstRow(
        session,
        where: (t) =>
            t.userId.equals(userId) &
            t.checklistItemId.equals(item.id!) &
            t.competencyId.equals(competencyId),
        orderBy: (t) => t.observedAt,
        orderDescending: true,
      );

      if (observation == null) {
        pending++;
        allDualSigned = false;
        details.add({
          'itemId': item.id,
          'title': item.title,
          'isCritical': item.isCritical,
          'result': 'pending',
          'dualSigned': false,
        });
      } else {
        final dualSigned = observation.evaluatorEsignatureId != null &&
            observation.traineeEsignatureId != null;
        if (!dualSigned) allDualSigned = false;

        if (observation.result == 'pass') {
          passed++;
        } else if (observation.result == 'fail') {
          failed++;
        } else {
          pending++;
        }

        details.add({
          'itemId': item.id,
          'title': item.title,
          'isCritical': item.isCritical,
          'result': observation.result,
          'dualSigned': dualSigned,
          'observedAt': observation.observedAt.toIso8601String(),
          'evaluatorId': observation.evaluatorId,
          'notes': observation.notes,
        });
      }
    }

    final total = items.length;
    final pct = total > 0 ? (passed / total * 100.0) : 0.0;

    return _stringifyMap({
      'totalItems': total,
      'passedItems': passed,
      'failedItems': failed,
      'pendingItems': pending,
      'allPassed': passed == total,
      'allDualSigned': allDualSigned,
      'progressPct': pct,
      'details': details,
    });
  }

  Map<String, String> _emptyProgress() => _stringifyMap({
        'totalItems': 0,
        'passedItems': 0,
        'failedItems': 0,
        'pendingItems': 0,
        'allPassed': false,
        'allDualSigned': false,
        'progressPct': 0.0,
        'details': <Map<String, dynamic>>[],
      });

  // ─── QA Verification & Competency Award ───────────────────────────

  /// QA verifies the OQ is complete and awards the UserCompetency.
  /// Requires: all checklist items passed, all dual-signed, QA permission.
  Future<UserCompetency?> qaVerifyAndAwardCompetency(
    Session session, {
    required int userId,
    required int competencyId,
    required int organizationId,
    required String qaSignatureMeaning,
    String? qaPasswordPlaintext,
    DateTime? expiresAt,
  }) async {
    final qa = await RbacHelper.getCurrentPharmaUser(session);
    if (qa?.id == null) return null;
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'write');

    // Verify OQ progress is complete
    final progress = await getOqProgress(
      session,
      userId: userId,
      competencyId: competencyId,
      organizationId: organizationId,
    );

    if (progress['allPassed'] != 'true') {
      throw Exception(
        'Cannot award competency: not all checklist items passed. '
        '${progress["passedItems"]}/${progress["totalItems"]} passed.',
      );
    }
    if (progress['allDualSigned'] != 'true') {
      throw Exception(
        'Cannot award competency: not all observations have dual e-signatures.',
      );
    }

    // Check for existing active competency
    final existingCompetency = await UserCompetency.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.competencyId.equals(competencyId),
    );
    if (existingCompetency != null) {
      // If already exists and not expired, skip
      if (existingCompetency.expiresAt == null ||
          existingCompetency.expiresAt!.isAfter(DateTime.now())) {
        throw Exception('User already has an active competency for this item.');
      }
    }

    // QA e-signature
    final qaSig = await EsignatureService.sign(
      session,
      userId: qa!.id!,
      signatureMeaning: qaSignatureMeaning,
      entityType: 'oq_verification',
      entityId: '${userId}_$competencyId',
      passwordPlaintext: qaPasswordPlaintext,
    );

    // Award the competency
    final now = DateTime.now();
    final competency = UserCompetency(
      userId: userId,
      competencyId: competencyId,
      achievedAt: now,
      expiresAt: expiresAt ?? now.add(const Duration(days: 365)),
    );
    final saved = await UserCompetency.db.insertRow(session, competency);

    await AuditService.log(
      session,
      entityType: 'user_competency',
      entityId: saved.id.toString(),
      action: 'CompetencyAwarded',
      newValueJson:
          '{"userId":$userId,"competencyId":$competencyId,"qaUserId":${qa.id},"qaEsignatureId":${qaSig.id}}',
      userId: qa.id,
    );

    // Notify the user
    try {
      final comp = await Competency.db.findById(session, competencyId);
      await Notification.db.insertRow(
        session,
        Notification(
          userId: userId,
          type: 'competency_awarded',
          body: 'Competency "${comp?.name ?? 'OQ'}" has been awarded. Verified by QA.',
          channel: 'in_app',
          createdAt: now,
        ),
      );
    } catch (_) {}

    return saved;
  }

  /// List user competencies (active and expired).
  Future<List<UserCompetency>> listUserCompetencies(
    Session session, {
    required int userId,
    bool activeOnly = false,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];

    var results = await UserCompetency.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      include: UserCompetency.include(
        user: PharmaUser.include(),
        competency: Competency.include(),
      ),
    );

    if (activeOnly) {
      final now = DateTime.now();
      results = results.where((uc) {
        if (uc.expiresAt == null) return true;
        return uc.expiresAt!.isAfter(now);
      }).toList();
    }

    return results;
  }

  /// Check if a user is qualified for a specific competency.
  Future<bool> isUserQualified(
    Session session, {
    required int userId,
    required int competencyId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return false;

    final uc = await UserCompetency.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.competencyId.equals(competencyId),
    );
    if (uc == null) return false;
    if (uc.expiresAt != null && uc.expiresAt!.isBefore(DateTime.now())) {
      return false;
    }
    return true;
  }

  // ─── Competency Management ────────────────────────────────────────

  /// Create a new competency definition.
  Future<Competency?> createCompetency(
    Session session, {
    required String name,
    required String code,
    int? level,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'create');

    final existing = await Competency.db.findFirstRow(
      session,
      where: (t) => t.code.equals(code),
    );
    if (existing != null) {
      throw Exception('Competency with code "$code" already exists.');
    }

    final result = await Competency.db.insertRow(
      session,
      Competency(name: name, code: code, level: level),
    );

    await AuditService.log(
      session,
      entityType: 'competency',
      entityId: result.id.toString(),
      action: 'CompetencyCreated',
      newValueJson: '{"name":"$name","code":"$code","level":$level}',
    );

    return result;
  }

  /// List all competency definitions.
  Future<List<Competency>> listCompetencies(Session session) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];
    return Competency.db.find(session);
  }
}
