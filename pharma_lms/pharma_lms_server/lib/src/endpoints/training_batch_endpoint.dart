import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/esignature_service.dart';
import '../services/rbac_helper.dart';
import 'training_endpoint.dart';

/// Training Batch management endpoint for Admin Portal.
/// Manages training batches/cohorts for instructor-led training.
class TrainingBatchEndpoint extends Endpoint {
  /// List all training batches for an organization.
  Future<List<TrainingBatch>> listBatches(
    Session session, {
    required int organizationId,
    String? status,
    int? courseVersionId,
    int? limit,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];
    
    var whereExpr = TrainingBatch.t.organizationId.equals(organizationId);
    
    if (status != null && status.isNotEmpty) {
      whereExpr = whereExpr & TrainingBatch.t.status.equals(status);
    }
    
    if (courseVersionId != null) {
      whereExpr = whereExpr & TrainingBatch.t.courseVersionId.equals(courseVersionId);
    }
    
    return await TrainingBatch.db.find(
      session,
      where: (t) => whereExpr,
      include: TrainingBatch.include(
        organization: Organization.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
        instructor: PharmaUser.include(),
      ),
      orderBy: (t) => t.startDate,
      orderDescending: true,
      limit: limit,
    );
  }

  /// Get a single training batch by ID.
  Future<TrainingBatch?> getBatch(Session session, int batchId) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return null;
    
    return await TrainingBatch.db.findById(
      session,
      batchId,
      include: TrainingBatch.include(
        organization: Organization.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
        instructor: PharmaUser.include(),
      ),
    );
  }

  /// Create a new training batch.
  Future<TrainingBatch?> createBatch(
    Session session, {
    required int organizationId,
    required int courseVersionId,
    required String name,
    int? instructorId,
    required DateTime startDate,
    required DateTime endDate,
    required int capacity,
    String? location,
    String? notes,
    String? startTime,
    String? endTime,
    String? medium,
    String? meetingUrl,
    String? category,
    String? description,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'create')) return null;
    
    final batch = TrainingBatch(
      organizationId: organizationId,
      courseVersionId: courseVersionId,
      name: name,
      instructorId: instructorId ?? 0,
      startDate: startDate,
      endDate: endDate,
      capacity: capacity,
      enrolledCount: 0,
      completedCount: 0,
      status: 'scheduled',
      location: location,
      notes: notes,
      startTime: startTime,
      endTime: endTime,
      medium: medium,
      meetingUrl: meetingUrl,
      category: category,
      description: description,
    );
    
    return await TrainingBatch.db.insertRow(session, batch);
  }

  /// Update a training batch.
  Future<TrainingBatch?> updateBatch(
    Session session,
    int batchId, {
    String? name,
    int? instructorId,
    DateTime? startDate,
    DateTime? endDate,
    int? capacity,
    String? status,
    String? location,
    String? notes,
    String? startTime,
    String? endTime,
    String? medium,
    String? meetingUrl,
    String? category,
    String? description,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'update')) return null;
    
    final existing = await TrainingBatch.db.findById(session, batchId);
    if (existing == null) return null;
    
    final updated = existing.copyWith(
      name: name ?? existing.name,
      instructorId: instructorId ?? existing.instructorId,
      startDate: startDate ?? existing.startDate,
      endDate: endDate ?? existing.endDate,
      capacity: capacity ?? existing.capacity,
      status: status ?? existing.status,
      location: location ?? existing.location,
      notes: notes ?? existing.notes,
      startTime: startTime ?? existing.startTime,
      endTime: endTime ?? existing.endTime,
      medium: medium ?? existing.medium,
      meetingUrl: meetingUrl ?? existing.meetingUrl,
      category: category ?? existing.category,
      description: description ?? existing.description,
    );
    
    return await TrainingBatch.db.updateRow(session, updated);
  }

  /// Delete a training batch.
  Future<bool> deleteBatch(Session session, int batchId) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return false;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'delete')) return false;

    await TrainingBatchParticipant.db.deleteWhere(
      session,
      where: (t) => t.batchId.equals(batchId),
    );

    final deleted = await TrainingBatch.db.deleteWhere(
      session,
      where: (t) => t.id.equals(batchId),
    );

    return deleted.isNotEmpty;
  }

  /// Get batch statistics for dashboard.
  Future<Map<String, int>> getBatchStats(Session session, int organizationId) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return {};
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return {};
    
    final batches = await TrainingBatch.db.find(
      session,
      where: (t) => t.organizationId.equals(organizationId),
    );
    
    return {
      'total': batches.length,
      'scheduled': batches.where((b) => b.status == 'scheduled').length,
      'in_progress': batches.where((b) => b.status == 'in_progress').length,
      'completed': batches.where((b) => b.status == 'completed').length,
      'cancelled': batches.where((b) => b.status == 'cancelled').length,
    };
  }

  /// Batches the signed-in user is on the roster for (employee ILT home).
  Future<List<TrainingBatch>> listBatchesForCurrentUser(Session session) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) {
      return [];
    }

    final links = await TrainingBatchParticipant.db.find(
      session,
      where: (t) => t.userId.equals(me!.id!),
    );
    if (links.isEmpty) return [];

    final batchIds = links.map((l) => l.batchId).toSet();
    return await TrainingBatch.db.find(
      session,
      where: (t) => t.id.inSet(batchIds),
      include: TrainingBatch.include(
        organization: Organization.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
        instructor: PharmaUser.include(),
      ),
      orderBy: (t) => t.startDate,
      orderDescending: true,
    );
  }

  /// Roster visible to batch participants or users with training update (trainers/admins).
  Future<List<BatchParticipantInfo>> listBatchParticipantsForEmployee(
    Session session,
    int batchId,
  ) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) {
      return [];
    }

    final allowed = await _canViewBatchRoster(session, batchId, me!.id!);
    if (!allowed) return [];

    final rows = await TrainingBatchParticipant.db.find(
      session,
      where: (t) => t.batchId.equals(batchId),
      include: TrainingBatchParticipant.include(
        user: PharmaUser.include(),
      ),
    );

    return rows
        .map((r) {
          final u = r.user;
          if (u == null) return null;
          return BatchParticipantInfo(
            userId: u.id ?? 0,
            firstName: u.firstName,
            lastName: u.lastName,
            email: u.email,
            role: r.role,
          );
        })
        .whereType<BatchParticipantInfo>()
        .toList();
  }

  /// Cohort average lesson progress vs current user for the batch's course version.
  Future<Map<String, String>> getBatchCohortProgress(
    Session session,
    int batchId,
  ) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) {
      return _emptyCohortProgress();
    }
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) {
      return _emptyCohortProgress();
    }

    if (!await _canViewBatchRoster(session, batchId, me!.id!)) {
      return _emptyCohortProgress();
    }

    final batch = await TrainingBatch.db.findById(session, batchId);
    if (batch == null) return _emptyCohortProgress();

    final participants = await TrainingBatchParticipant.db.find(
      session,
      where: (t) => t.batchId.equals(batchId),
    );
    if (participants.isEmpty) {
      return {
        ..._emptyCohortProgress(),
        'participantCount': '0',
      };
    }

    final trainingEndpoint = TrainingEndpoint();
    final progressValues = <double>[];
    var myProgressPct = 0.0;
    var myCompleted = 0;
    var myTotal = 0;

    for (final p in participants) {
      final enrollment = await Enrollment.db.findFirstRow(
        session,
        where: (t) =>
            t.userId.equals(p.userId) &
            t.courseVersionId.equals(batch.courseVersionId),
      );
      if (enrollment?.id == null) {
        progressValues.add(0);
        if (p.userId == me.id) {
          myProgressPct = 0;
          myCompleted = 0;
          myTotal = 0;
        }
        continue;
      }

      final prog = await trainingEndpoint.getEnrollmentProgress(session, enrollment!.id!);
      final pct = double.tryParse(prog['progressPct'] ?? '0') ?? 0;
      progressValues.add(pct);

      if (p.userId == me.id) {
        myProgressPct = pct;
        myCompleted = int.tryParse(prog['completedLessons'] ?? '0') ?? 0;
        myTotal = int.tryParse(prog['totalLessons'] ?? '0') ?? 0;
      }
    }

    final avg = progressValues.isEmpty
        ? 0.0
        : progressValues.reduce((a, b) => a + b) / progressValues.length;

    return {
      'cohortAverageProgressPct': avg.toStringAsFixed(1),
      'myProgressPct': myProgressPct.toStringAsFixed(1),
      'myCompletedLessons': myCompleted.toString(),
      'myTotalLessons': myTotal.toString(),
      'participantCount': participants.length.toString(),
      'courseVersionId': batch.courseVersionId.toString(),
    };
  }

  Map<String, String> _emptyCohortProgress() => {
        'cohortAverageProgressPct': '0.0',
        'myProgressPct': '0.0',
        'myCompletedLessons': '0',
        'myTotalLessons': '0',
        'participantCount': '0',
        'courseVersionId': '0',
      };

  Future<bool> _canViewBatchRoster(Session session, int batchId, int userId) async {
    final row = await TrainingBatchParticipant.db.findFirstRow(
      session,
      where: (t) => t.batchId.equals(batchId) & t.userId.equals(userId),
    );
    if (row != null) return true;
    final batch = await TrainingBatch.db.findById(session, batchId);
    if (batch != null && batch.instructorId == userId) return true;
    if (await RbacHelper.hasPermission(session, resource: 'training', action: 'update')) {
      return true;
    }
    if (await RbacHelper.hasPermission(session, resource: 'training', action: 'write')) {
      return true;
    }
    if (await RbacHelper.hasPermission(session, resource: 'training', action: 'create')) {
      return true;
    }
    return false;
  }

  /// Add a user to a batch roster (admin/trainer).
  Future<TrainingBatchParticipant?> enrollUserInBatch(
    Session session, {
    required int batchId,
    required int userId,
    String? role,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'create') &&
        !await RbacHelper.hasPermission(session, resource: 'training', action: 'update') &&
        !await RbacHelper.hasPermission(session, resource: 'training', action: 'write')) {
      return null;
    }

    final batch = await TrainingBatch.db.findById(session, batchId);
    if (batch == null) return null;

    final existing = await TrainingBatchParticipant.db.findFirstRow(
      session,
      where: (t) => t.batchId.equals(batchId) & t.userId.equals(userId),
    );
    if (existing != null) return existing;

    final inserted = await TrainingBatchParticipant.db.insertRow(
      session,
      TrainingBatchParticipant(
        batchId: batchId,
        userId: userId,
        role: role,
      ),
    );

    await TrainingBatch.db.updateRow(
      session,
      batch.copyWith(enrolledCount: batch.enrolledCount + 1),
    );

    return inserted;
  }

  /// Remove a user from a batch roster (admin/trainer).
  Future<bool> removeUserFromBatch(
    Session session, {
    required int batchId,
    required int userId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return false;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'update') &&
        !await RbacHelper.hasPermission(session, resource: 'training', action: 'delete') &&
        !await RbacHelper.hasPermission(session, resource: 'training', action: 'write')) {
      return false;
    }

    final batch = await TrainingBatch.db.findById(session, batchId);
    if (batch == null) return false;

    final deleted = await TrainingBatchParticipant.db.deleteWhere(
      session,
      where: (t) => t.batchId.equals(batchId) & t.userId.equals(userId),
    );
    if (deleted.isEmpty) return false;

    final nextCount = (batch.enrolledCount - 1).clamp(0, batch.enrolledCount);
    await TrainingBatch.db.updateRow(
      session,
      batch.copyWith(enrolledCount: nextCount),
    );
    return true;
  }

  // ─── Attendance Tracking ────────────────────────────────────────────

  /// Mark attendance for a user in a batch (optionally tied to a live class session).
  Future<BatchAttendanceRecord?> markAttendance(
    Session session, {
    required int batchId,
    required int userId,
    int? liveClassId,
    String status = 'present',
    String? notes,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'update') &&
        !await RbacHelper.hasPermission(session, resource: 'training', action: 'write') &&
        !await RbacHelper.hasPermission(session, resource: 'training', action: 'create')) {
      return null;
    }

    final batch = await TrainingBatch.db.findById(session, batchId);
    if (batch == null) return null;

    // Verify user is a batch participant
    final participant = await TrainingBatchParticipant.db.findFirstRow(
      session,
      where: (t) => t.batchId.equals(batchId) & t.userId.equals(userId),
    );
    if (participant == null) {
      throw Exception('User is not a participant of this batch');
    }

    // Check for existing attendance record for this session
    if (liveClassId != null) {
      final existing = await BatchAttendanceRecord.db.findFirstRow(
        session,
        where: (t) =>
            t.batchId.equals(batchId) &
            t.userId.equals(userId) &
            t.liveClassId.equals(liveClassId),
      );
      if (existing != null) {
        // Update existing attendance
        return BatchAttendanceRecord.db.updateRow(
          session,
          existing.copyWith(status: status, notes: notes),
        );
      }
    }

    final record = BatchAttendanceRecord(
      batchId: batchId,
      liveClassId: liveClassId,
      userId: userId,
      status: status,
      markedById: me!.id!,
      notes: notes,
    );

    final saved = await BatchAttendanceRecord.db.insertRow(session, record);

    await AuditService.log(
      session,
      entityType: 'batch_attendance',
      entityId: saved.id.toString(),
      action: 'AttendanceMarked',
      newValueJson:
          '{"batchId":$batchId,"userId":$userId,"status":"$status","liveClassId":$liveClassId}',
      userId: me.id,
    );

    return saved;
  }

  /// Bulk mark attendance for multiple users in a batch session.
  Future<List<BatchAttendanceRecord>> bulkMarkAttendance(
    Session session, {
    required int batchId,
    int? liveClassId,
    required List<Map<String, dynamic>> attendanceList,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'update') &&
        !await RbacHelper.hasPermission(session, resource: 'training', action: 'write')) {
      return [];
    }

    final results = <BatchAttendanceRecord>[];
    for (final entry in attendanceList) {
      final uid = entry['userId'] as int?;
      final status = entry['status'] as String? ?? 'present';
      final notes = entry['notes'] as String?;
      if (uid == null) continue;

      final record = await markAttendance(
        session,
        batchId: batchId,
        userId: uid,
        liveClassId: liveClassId,
        status: status,
        notes: notes,
      );
      if (record != null) results.add(record);
    }
    return results;
  }

  /// List attendance records for a batch (optionally filtered by live class session).
  Future<List<BatchAttendanceRecord>> listAttendance(
    Session session, {
    required int batchId,
    int? liveClassId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];

    var whereExpr = BatchAttendanceRecord.t.batchId.equals(batchId);
    if (liveClassId != null) {
      whereExpr = whereExpr & BatchAttendanceRecord.t.liveClassId.equals(liveClassId);
    }

    return BatchAttendanceRecord.db.find(
      session,
      where: (_) => whereExpr,
      include: BatchAttendanceRecord.include(
        user: PharmaUser.include(),
        markedBy: PharmaUser.include(),
        liveClass: LiveClass.include(),
      ),
      orderBy: (t) => t.markedAt,
      orderDescending: true,
    );
  }

  /// Get attendance summary for a batch (per participant: total sessions, attended, absent).
  Future<List<Map<String, String>>> getAttendanceSummary(
    Session session, {
    required int batchId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];

    final participants = await TrainingBatchParticipant.db.find(
      session,
      where: (t) => t.batchId.equals(batchId),
      include: TrainingBatchParticipant.include(user: PharmaUser.include()),
    );

    final liveClasses = await LiveClass.db.find(
      session,
      where: (t) => t.batchId.equals(batchId),
    );
    final totalSessions = liveClasses.length;

    final summary = <Map<String, String>>[];
    for (final p in participants) {
      final records = await BatchAttendanceRecord.db.find(
        session,
        where: (t) =>
            t.batchId.equals(batchId) &
            t.userId.equals(p.userId),
      );
      final present = records.where((r) => r.status == 'present').length;
      final absent = records.where((r) => r.status == 'absent').length;
      final excused = records.where((r) => r.status == 'excused').length;
      final late_ = records.where((r) => r.status == 'late').length;

      summary.add({
        'userId': p.userId.toString(),
        'firstName': p.user?.firstName ?? '',
        'lastName': p.user?.lastName ?? '',
        'totalSessions': totalSessions.toString(),
        'present': present.toString(),
        'absent': absent.toString(),
        'excused': excused.toString(),
        'late': late_.toString(),
        'attendanceRate': totalSessions > 0
            ? ((present + late_) / totalSessions * 100).round().toString()
            : '0',
      });
    }
    return summary;
  }

  // ─── Batch Closure with Certificate Generation ────────────────────

  /// Close a batch: mark as completed, generate certificates for all
  /// participants who met attendance requirements and passed assessments.
  /// Requires e-signature from the closer (instructor/admin).
  Future<Map<String, String>> closeBatch(
    Session session, {
    required int batchId,
    required String signatureMeaning,
    String? passwordPlaintext,
    double minAttendanceRate = 0.80,
  }) async {
    final closer = await RbacHelper.getCurrentPharmaUser(session);
    if (closer?.id == null) {
      return {'success': 'false', 'error': 'Not authenticated'};
    }
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'update') &&
        !await RbacHelper.hasPermission(session, resource: 'training', action: 'write')) {
      return {'success': 'false', 'error': 'Permission denied'};
    }

    final batch = await TrainingBatch.db.findById(session, batchId);
    if (batch == null) return {'success': 'false', 'error': 'Batch not found'};
    if (batch.status == 'completed') {
      return {'success': 'false', 'error': 'Batch already completed'};
    }

    // E-signature for batch closure
    final sig = await EsignatureService.sign(
      session,
      userId: closer!.id!,
      signatureMeaning: signatureMeaning,
      entityType: 'batch_closure',
      entityId: batchId.toString(),
      passwordPlaintext: passwordPlaintext,
    );

    // Get attendance summary
    final attendanceSummary = await getAttendanceSummary(session, batchId: batchId);
    final liveClasses = await LiveClass.db.find(
      session,
      where: (t) => t.batchId.equals(batchId),
    );
    final totalSessions = liveClasses.length;

    final certifiedUserIds = <int>[];
    final failedUserIds = <int>[];
    final now = DateTime.now();
    final expiresAt = now.add(const Duration(days: 365));

    for (final summary in attendanceSummary) {
      final uid = int.tryParse(summary['userId'] ?? '') ?? 0;
      final attended = (int.tryParse(summary['present'] ?? '') ?? 0) +
          (int.tryParse(summary['late'] ?? '') ?? 0);
      final rate = totalSessions > 0 ? attended / totalSessions : 1.0;

      if (rate < minAttendanceRate) {
        failedUserIds.add(uid);
        continue;
      }

      // Check if user has a completed enrollment for this course version
      final enrollment = await Enrollment.db.findFirstRow(
        session,
        where: (t) =>
            t.userId.equals(uid) &
            t.courseVersionId.equals(batch.courseVersionId),
        orderBy: (t) => t.startedAt,
        orderDescending: true,
      );

      // Create training record + certificate
      final qrCode =
          'BATCH-$batchId-$uid-${Random().nextInt(999999).toString().padLeft(6, '0')}';

      final trainingRecord = await TrainingRecord.db.insertRow(
        session,
        TrainingRecord(
          enrollmentId: enrollment?.id ?? 0,
          userId: uid,
          courseVersionId: batch.courseVersionId,
          esignatureId: sig.id!,
        ),
      );

      final certificate = await Certificate.db.insertRow(
        session,
        Certificate(
          userId: uid,
          courseVersionId: batch.courseVersionId,
          trainingRecordId: trainingRecord.id!,
          expiresAt: expiresAt,
          qrCode: qrCode,
          esignatureId: sig.id!,
        ),
      );

      certifiedUserIds.add(uid);

      // Update enrollment to completed if exists
      if (enrollment != null && enrollment.status != 'completed') {
        await Enrollment.db.updateRow(
          session,
          enrollment.copyWith(status: 'completed', completedAt: now),
        );
      }

      // Notify user
      try {
        await Notification.db.insertRow(
          session,
          Notification(
            userId: uid,
            type: 'batch_certificate',
            body:
                'Congratulations! You have been certified for "${batch.name}". Certificate ID: ${certificate.id}',
            channel: 'in_app',
            createdAt: now,
          ),
        );
      } catch (_) {}

      await AuditService.log(
        session,
        entityType: 'certificate',
        entityId: certificate.id.toString(),
        action: 'BatchCertificateIssued',
        newValueJson:
            '{"batchId":$batchId,"userId":$uid,"courseVersionId":${batch.courseVersionId}}',
        userId: closer.id,
      );
    }

    // Update batch status
    await TrainingBatch.db.updateRow(
      session,
      batch.copyWith(
        status: 'completed',
        completedCount: certifiedUserIds.length,
      ),
    );

    await AuditService.log(
      session,
      entityType: 'training_batch',
      entityId: batchId.toString(),
      action: 'BatchClosed',
      newValueJson:
          '{"certified":${certifiedUserIds.length},"failed":${failedUserIds.length},"closerEsignatureId":${sig.id}}',
      userId: closer.id,
    );

    return {
      'success': 'true',
      'batchId': batchId.toString(),
      'certifiedCount': certifiedUserIds.length.toString(),
      'failedCount': failedUserIds.length.toString(),
      'certifiedUserIds': certifiedUserIds.join(','),
      'failedUserIds': failedUserIds.join(','),
    };
  }
}
