import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

import '../generated/protocol.dart';
import '../services/training_assignment_service.dart';

/// Training Administrator domain endpoint.
class AdminEndpoint extends Endpoint {
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

  /// Update job role training matrix (JSON array of course IDs).
  Future<JobRole> updateJobRoleTrainingMatrix(
    Session session, {
    required int jobRoleId,
    required String trainingMatrixJson,
  }) async {
    final role = await JobRole.db.findById(session, jobRoleId);
    if (role == null) throw Exception('Job role not found');
    final updated = role.copyWith(trainingMatrixJson: trainingMatrixJson);
    return await JobRole.db.updateRow(session, updated);
  }

  /// Get course version IDs from JobRole training matrix (course IDs -> latest approved version).
  Future<List<int>> getRoleBasedCurriculum(
    Session session,
    int jobRoleId,
  ) async {
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
          where: (t) => t.courseId.equals(courseId) & (t.status.equals('approved') | t.status.equals('effective')),
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
    final curriculum = await getRoleBasedCurriculum(session, jobRoleId);
    final assignments = <TrainingAssignment>[];

    for (final courseVersionId in curriculum) {
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
    return true;
  }

  /// Unlock (unblock) a user by email.
  Future<bool> unlockUserByEmail(Session session, String email) async {
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
    return true;
  }
}
