import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

import '../audit_event_types.dart';
import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/event_service.dart';
import '../services/rbac_helper.dart';
import '../services/training_assignment_service.dart';

/// Training Administrator domain endpoint.
class AdminEndpoint extends Endpoint {
  /// List all signature meanings (admin - includes inactive).
  Future<List<SignatureMeaning>> listSignatureMeanings(Session session) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'read');
    return await SignatureMeaning.db.find(
      session,
      orderBy: (t) => t.orderIndex,
    );
  }

  /// Create a signature meaning.
  Future<SignatureMeaning> createSignatureMeaning(
    Session session, {
    required String meaning,
    bool isActive = true,
    int orderIndex = 0,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'write');
    final result = await SignatureMeaning.db.insertRow(
      session,
      SignatureMeaning(
        meaning: meaning,
        isActive: isActive,
        orderIndex: orderIndex,
      ),
    );
    await AuditService.log(
      session,
      entityType: 'signature_meaning',
      entityId: (result.id ?? 0).toString(),
      action: AuditEventType.configChanged,
      newValueJson: '{"meaning":"$meaning","isActive":$isActive,"orderIndex":$orderIndex}',
    );
    return result;
  }

  /// Update a signature meaning.
  Future<SignatureMeaning> updateSignatureMeaning(
    Session session, {
    required int id,
    String? meaning,
    bool? isActive,
    int? orderIndex,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'write');
    final existing = await SignatureMeaning.db.findById(session, id);
    if (existing == null) throw Exception('Signature meaning not found');
    final updated = existing.copyWith(
      meaning: meaning ?? existing.meaning,
      isActive: isActive ?? existing.isActive,
      orderIndex: orderIndex ?? existing.orderIndex,
    );
    final result = await SignatureMeaning.db.updateRow(session, updated);
    await AuditService.log(
      session,
      entityType: 'signature_meaning',
      entityId: id.toString(),
      action: AuditEventType.configChanged,
      oldValueJson: '{"meaning":"${existing.meaning}","isActive":${existing.isActive}}',
      newValueJson: '{"meaning":"${result.meaning}","isActive":${result.isActive}}',
    );
    return result;
  }

  /// Assign training to all users in a department.
  Future<List<TrainingAssignment>> assignTrainingToDepartment(
    Session session, {
    required int departmentId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
    String? reason,
    String source = 'manual',
  }) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'assign');
    final assignments = await TrainingAssignmentService.assignToDepartment(
      session,
      departmentId: departmentId,
      courseVersionId: courseVersionId,
      assignedById: assignedById,
      dueDate: dueDate,
      reason: reason,
      source: source,
    );
    return assignments;
  }

  /// Bulk import users from CSV (base64). Columns: email,firstName,lastName,departmentId,siteId,organizationId,jobRoleId
  Future<BulkImportResult> bulkImportUsers(
    Session session, {
    required String csvBase64,
    required int assignedById,
    DateTime? dueDate,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'assign');
    final bytes = base64Decode(csvBase64);
    final csv = utf8.decode(bytes);
    final lines = csv.split('\n').where((l) => l.trim().isNotEmpty).toList();
    if (lines.isEmpty) return BulkImportResult(imported: 0, errors: []);

    final headerParts = lines.first.split(',').map((s) => s.trim().toLowerCase()).toList();
    final emailIdx = _colIndex(headerParts, 'email');
    final firstIdx = _colIndex(headerParts, 'firstname');
    final lastIdx = _colIndex(headerParts, 'lastname');
    final deptIdx = _colIndex(headerParts, 'departmentid');
    final siteIdx = _colIndex(headerParts, 'siteid');
    final orgIdx = _colIndex(headerParts, 'organizationid');
    final jobIdx = _colIndex(headerParts, 'jobroleid');

    var imported = 0;
    final errors = <String>[];
    final due = dueDate ?? DateTime.now().add(const Duration(days: 30));

    for (var i = 1; i < lines.length; i++) {
      final cols = _parseCsvLine(lines[i]);
      if (cols.isEmpty) continue;

      final email = emailIdx != null && emailIdx < cols.length ? cols[emailIdx].trim() : '';
      if (email.isEmpty) {
        errors.add('Row ${i + 1}: missing email');
        continue;
      }

      final orgId = orgIdx != null && orgIdx < cols.length ? int.tryParse(cols[orgIdx]) : null;
      final siteId = siteIdx != null && siteIdx < cols.length ? int.tryParse(cols[siteIdx]) : null;
      final deptId = deptIdx != null && deptIdx < cols.length ? int.tryParse(cols[deptIdx]) : null;
      final jobRoleId = jobIdx != null && jobIdx < cols.length ? int.tryParse(cols[jobIdx]) : null;

      if (orgId == null || siteId == null || deptId == null || jobRoleId == null) {
        errors.add('Row ${i + 1}: invalid org/site/dept/jobRole ids');
        continue;
      }

      final existing = await PharmaUser.db.findFirstRow(
        session,
        where: (t) => t.email.equals(email),
      );
      if (existing != null) {
        errors.add('Row ${i + 1}: user $email already exists');
        continue;
      }

      try {
        final user = await PharmaUser.db.insertRow(
          session,
          PharmaUser(
            email: email,
            firstName: firstIdx != null && firstIdx < cols.length ? cols[firstIdx].trim() : 'User',
            lastName: lastIdx != null && lastIdx < cols.length ? cols[lastIdx].trim() : '',
            departmentId: deptId,
            jobRoleId: jobRoleId,
            siteId: siteId,
            organizationId: orgId,
          ),
        );

        final curriculum = await getRoleBasedCurriculum(session, jobRoleId);
        for (final courseVersionId in curriculum) {
          final assignment = await TrainingAssignmentService.assign(
            session,
            userId: user.id!,
            courseVersionId: courseVersionId,
            assignedById: assignedById,
            dueDate: due,
            source: 'onboarding',
          );
          await TrainingAssignmentService.createEnrollment(
            session,
            userId: user.id!,
            courseVersionId: courseVersionId,
            assignmentId: assignment.id!,
          );
        }
        imported++;
      } catch (e) {
        errors.add('Row ${i + 1}: $e');
      }
    }

    return BulkImportResult(imported: imported, errors: errors);
  }

  int? _colIndex(List<String> headers, String name) {
    for (var i = 0; i < headers.length; i++) {
      if (headers[i].contains(name) || headers[i] == name) return i;
    }
    return null;
  }

  List<String> _parseCsvLine(String line) {
    return line.split(',').map((s) => s.trim().replaceAll('"', '')).toList();
  }

  /// Bulk import training matrix from CSV. Columns: job_role_code, course_id.
  /// One row per role-course pair. Merges with existing matrix per role.
  Future<BulkImportResult> bulkImportTrainingMatrix(
    Session session, {
    required String csvBase64,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'assign');
    final bytes = base64Decode(csvBase64);
    final csv = utf8.decode(bytes);
    final lines = csv.split('\n').where((l) => l.trim().isNotEmpty).toList();
    if (lines.isEmpty) return BulkImportResult(imported: 0, errors: []);

    final headerParts = lines.first.split(',').map((s) => s.trim().toLowerCase()).toList();
    final codeIdx = _colIndex(headerParts, 'job_role_code') ?? _colIndex(headerParts, 'jobrolecode') ?? _colIndex(headerParts, 'code');
    final courseIdx = _colIndex(headerParts, 'course_id') ?? _colIndex(headerParts, 'courseid');

    if (codeIdx == null || courseIdx == null) {
      return BulkImportResult(imported: 0, errors: ['CSV must have job_role_code and course_id columns']);
    }

    final roleToCourses = <String, Set<int>>{};
    final errors = <String>[];

    for (var i = 1; i < lines.length; i++) {
      final cols = _parseCsvLine(lines[i]);
      if (cols.length <= codeIdx || cols.length <= courseIdx) continue;

      final code = cols[codeIdx].trim();
      final courseId = int.tryParse(cols[courseIdx].trim());
      if (code.isEmpty || courseId == null || courseId <= 0) {
        errors.add('Row ${i + 1}: invalid job_role_code or course_id');
        continue;
      }

      roleToCourses.putIfAbsent(code, () => {}).add(courseId);
    }

    var imported = 0;
    for (final entry in roleToCourses.entries) {
      try {
        final role = await JobRole.db.findFirstRow(
          session,
          where: (t) => t.code.equals(entry.key),
        );
        if (role == null) {
          errors.add('Job role "${entry.key}" not found');
          continue;
        }

        final existing = role.trainingMatrixJson != null
            ? (jsonDecode(role.trainingMatrixJson!) as List<dynamic>?)
                ?.map((e) => (e is int) ? e : int.tryParse(e.toString()) ?? 0)
                .where((id) => id > 0)
                .toSet()
                ?? <int>{}
            : <int>{};
        final merged = {...existing, ...entry.value};
        final json = jsonEncode(merged.toList());
        await updateJobRoleTrainingMatrix(session, jobRoleId: role.id!, trainingMatrixJson: json);
        imported++;
      } catch (e) {
        errors.add('${entry.key}: $e');
      }
    }

    return BulkImportResult(imported: imported, errors: errors);
  }

  /// Update job role training matrix (JSON array of course IDs).
  Future<JobRole> updateJobRoleTrainingMatrix(
    Session session, {
    required int jobRoleId,
    required String trainingMatrixJson,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'assign');
    final role = await JobRole.db.findById(session, jobRoleId);
    if (role == null) throw Exception('Job role not found');
    final updated = role.copyWith(trainingMatrixJson: trainingMatrixJson);
    final result = await JobRole.db.updateRow(session, updated);
    await AuditService.log(
      session,
      entityType: 'job_role',
      entityId: jobRoleId.toString(),
      action: AuditEventType.configChanged,
      newValueJson: '{"jobRoleId":$jobRoleId,"trainingMatrixJson":"$trainingMatrixJson"}',
    );
    return result;
  }

  /// Get course version IDs from JobRole training matrix (course IDs -> latest approved version).
  Future<List<int>> getRoleBasedCurriculum(
    Session session,
    int jobRoleId,
  ) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'read');
    final role = await JobRole.db.findById(session, jobRoleId);
    if (role == null || role.trainingMatrixJson == null) return [];

    try {
      final list = jsonDecode(role.trainingMatrixJson!) as List<dynamic>?;
      if (list == null) return [];
      final courseIds = list.map((e) => (e is int) ? e : int.tryParse(e.toString()) ?? 0).where((id) => id > 0).toSet().toList();
      final versions = <int>[];
      for (final courseId in courseIds) {
        final vers = await CourseVersion.db.find(
          session,
          where: (t) => t.courseId.equals(courseId) & t.status.equals('effective'),
          orderBy: (t) => t.id,
          orderDescending: true,
          limit: 1,
        );
        if (vers.isNotEmpty && vers.first.id != null) versions.add(vers.first.id!);
      }
      return versions;
    } catch (_) {
      return [];
    }
  }

  /// Assign role-based training (curriculum from JobRole) to a user.
  Future<List<TrainingAssignment>> assignRoleBasedTraining(
    Session session, {
    required int userId,
    required int jobRoleId,
    required int assignedById,
    required DateTime dueDate,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'assign');
    final curriculum = await getRoleBasedCurriculum(session, jobRoleId);
    final assignments = <TrainingAssignment>[];

    for (final courseVersionId in curriculum) {
      final hasActive = await TrainingAssignmentService.hasActiveEnrollment(
        session,
        userId: userId,
        courseVersionId: courseVersionId,
      );
      if (hasActive) continue;

      final assignment = await TrainingAssignmentService.assign(
        session,
        userId: userId,
        courseVersionId: courseVersionId,
        assignedById: assignedById,
        dueDate: dueDate,
        source: 'role_based',
      );
      assignments.add(assignment);
      await TrainingAssignmentService.createEnrollment(
        session,
        userId: userId,
        courseVersionId: courseVersionId,
        assignmentId: assignment.id!,
      );
    }
    return assignments;
  }

  /// Lock (block) a user by email - prevents sign-in. Account lockout.
  Future<bool> lockUserByEmail(Session session, String email) async {
    await RbacHelper.requirePermission(session, resource: 'user', action: 'write');
    final result = await session.db.unsafeQuery(
      r'SELECT "authUserId" FROM serverpod_auth_core_profile WHERE email = @email LIMIT 1',
      parameters: QueryParameters.named({'email': email}),
    );
    if (result.isEmpty) return false;
    final authUserIdStr = result.first[0]?.toString() ?? '';
    if (authUserIdStr.isEmpty) return false;
    final authUserId = UuidValue.fromString(authUserIdStr);
    await AuthServices.instance.authUsers.update(
      session,
      authUserId: authUserId,
      blocked: true,
    );
    await AuditService.log(
      session,
      entityType: 'auth_user',
      entityId: authUserId.toString(),
      action: 'UserLocked',
      newValueJson: '{"email":"$email"}',
    );
    return true;
  }

  /// ADM-07: Request a training waiver (admin creates request for user).
  Future<TrainingWaiver> requestTrainingWaiver(
    Session session, {
    required int userId,
    required int courseId,
    required int requestedById,
    required String requestReason,
    String? evidenceStoragePath,
    DateTime? expiresAt,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'write');
    final existing = await TrainingWaiver.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.courseId.equals(courseId) &
          t.status.equals('approved'),
    );
    if (existing != null) {
      throw Exception('User already has an approved waiver for this course');
    }
    final waiver = await TrainingWaiver.db.insertRow(
      session,
      TrainingWaiver(
        userId: userId,
        courseId: courseId,
        requestedById: requestedById,
        requestReason: requestReason,
        evidenceStoragePath: evidenceStoragePath,
        expiresAt: expiresAt,
      ),
    );
    await AuditService.log(
      session,
      entityType: 'training_waiver',
      entityId: waiver.id.toString(),
      action: 'WaiverRequested',
      newValueJson: '{"userId":$userId,"courseId":$courseId}',
    );
    return waiver;
  }

  /// ADM-07: List training waivers with optional filters.
  Future<List<TrainingWaiver>> listTrainingWaivers(
    Session session, {
    int? userId,
    String? status,
    int? courseId,
    int limit = 100,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'read');
    return await TrainingWaiver.db.find(
      session,
      where: (t) {
        var w = t.id.notEquals(0);
        if (userId != null) w = w & t.userId.equals(userId);
        if (status != null) w = w & t.status.equals(status);
        if (courseId != null) w = w & t.courseId.equals(courseId);
        return w;
      },
      orderBy: (t) => t.requestedAt,
      orderDescending: true,
      limit: limit,
      include: TrainingWaiver.include(
        user: PharmaUser.include(),
        course: Course.include(),
        requestedBy: PharmaUser.include(),
        approvedBy: PharmaUser.include(),
      ),
    );
  }

  /// ADM-07: QA approve a training waiver. Separation of duties: requester cannot approve.
  Future<TrainingWaiver> approveTrainingWaiver(
    Session session, {
    required int waiverId,
    required int approvedById,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'write');
    final waiver = await TrainingWaiver.db.findById(session, waiverId);
    if (waiver == null) throw Exception('Waiver not found');
    if (waiver.status != 'pending') {
      throw Exception('Waiver is not pending (status: ${waiver.status})');
    }
    if (waiver.requestedById == approvedById) {
      throw Exception('Requester cannot approve their own waiver (separation of duties)');
    }
    final updated = await TrainingWaiver.db.updateRow(
      session,
      waiver.copyWith(
        status: 'approved',
        approvedById: approvedById,
        approvedAt: DateTime.now(),
      ),
    );
    await AuditService.log(
      session,
      entityType: 'training_waiver',
      entityId: waiverId.toString(),
      action: 'WaiverApproved',
      newValueJson: '{"approvedById":$approvedById}',
    );
    if (waiver.userId != null && waiver.courseId != null) {
      await EventService.emitWaiverApproved(
        session,
        waiverId: waiverId,
        userId: waiver.userId!,
        courseId: waiver.courseId!,
      );
    }
    return updated;
  }

  /// ADM-07: QA reject a training waiver.
  Future<TrainingWaiver> rejectTrainingWaiver(
    Session session, {
    required int waiverId,
    required int approvedById,
    required String rejectionReason,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'write');
    final waiver = await TrainingWaiver.db.findById(session, waiverId);
    if (waiver == null) throw Exception('Waiver not found');
    if (waiver.status != 'pending') {
      throw Exception('Waiver is not pending (status: ${waiver.status})');
    }
    final updated = await TrainingWaiver.db.updateRow(
      session,
      waiver.copyWith(
        status: 'rejected',
        approvedById: approvedById,
        approvedAt: DateTime.now(),
        rejectionReason: rejectionReason,
      ),
    );
    await AuditService.log(
      session,
      entityType: 'training_waiver',
      entityId: waiverId.toString(),
      action: 'WaiverRejected',
      newValueJson: '{"rejectionReason":"$rejectionReason"}',
    );
    return updated;
  }

  /// Unlock (unblock) a user by email.
  Future<bool> unlockUserByEmail(Session session, String email) async {
    await RbacHelper.requirePermission(session, resource: 'user', action: 'write');
    final result = await session.db.unsafeQuery(
      r'SELECT "authUserId" FROM serverpod_auth_core_profile WHERE email = @email LIMIT 1',
      parameters: QueryParameters.named({'email': email}),
    );
    if (result.isEmpty) return false;
    final authUserIdStr = result.first[0]?.toString() ?? '';
    if (authUserIdStr.isEmpty) return false;
    final authUserId = UuidValue.fromString(authUserIdStr);
    await AuthServices.instance.authUsers.update(
      session,
      authUserId: authUserId,
      blocked: false,
    );
    await AuditService.log(
      session,
      entityType: 'auth_user',
      entityId: authUserId.toString(),
      action: 'UserUnlocked',
      newValueJson: '{"email":"$email"}',
    );
    return true;
  }
}
