import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../audit_event_types.dart';
import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/email_service.dart';
import '../services/event_service.dart';
import '../services/password_policy_service.dart';
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

  /// Real admin "creates trainer" flow (US-ADM-USR-001).
  ///
  /// Creates the `pharma_user`, assigns a portal `role` via `user_role`,
  /// provisions Serverpod auth (email + temporary password) and sends the welcome email,
  /// logs an immutable audit trail entry, and creates onboarding enrollments from the
  /// selected training-matrix `jobRoleId`.
  Future<PharmaUser> createUserWithRole(
    Session session, {
    required String employeeId,
    required String email,
    required String firstName,
    required String lastName,
    required int departmentId,
    required int siteId,
    required int organizationId,
    required int jobRoleId,
    required String roleCode,
    required int assignedById,
    int? managerId,
    DateTime? dueDate,
  }) async {
    await RbacHelper.requirePermission(
      session,
      resource: 'training',
      action: 'assign',
    );

    final normalizedEmail = email.trim().toLowerCase();
    final normalizedRoleCode = roleCode.trim().toLowerCase();
    final normalizedEmployeeId = employeeId.trim();

    if (normalizedEmployeeId.isEmpty) {
      throw Exception('employeeId is required');
    }
    if (normalizedEmail.isEmpty) {
      throw Exception('email is required');
    }

    final existing = await PharmaUser.db.findFirstRow(
      session,
      where: (t) => t.employeeId.equals(normalizedEmployeeId),
    );
    if (existing != null) {
      throw Exception('User with employeeId=$normalizedEmployeeId already exists');
    }

    final role = await Role.db.findFirstRow(
      session,
      where: (t) => t.code.equals(normalizedRoleCode),
    );
    if (role == null) {
      throw Exception('Role not found for code="$normalizedRoleCode"');
    }

    final fullName = '${firstName.trim()} ${lastName.trim()}'.trim();

    final user = await PharmaUser.db.insertRow(
      session,
      PharmaUser(
        email: normalizedEmail,
        firstName: firstName.trim(),
        lastName: lastName.trim(),
        employeeId: normalizedEmployeeId,
        managerId: managerId,
        departmentId: departmentId,
        jobRoleId: jobRoleId,
        siteId: siteId,
        organizationId: organizationId,
        status: 'active',
        hireDate: DateTime.now(),
      ),
    );

    if (user.id == null) {
      throw Exception('Failed to create user');
    }

    // Assign portal access role.
    await UserRole.db.insertRow(
      session,
      UserRole(userId: user.id!, roleId: role.id!),
    );

    // Provision auth + send welcome email with random temp credentials.
    final tempPassword = _generateTemporaryPassword();
    await _provisionAuthAndSendWelcome(
      session,
      email: normalizedEmail,
      fullName: fullName,
      tempPassword: tempPassword,
    );

    // In-app onboarding entry (used by trainer/employee notification center).
    await Notification.db.insertRow(
      session,
      Notification(
        userId: user.id!,
        type: 'onboarding_welcome',
        channel: 'in_app',
      ),
    );

    // Create onboarding enrollments from the jobRole training matrix.
    final curriculum = await getRoleBasedCurriculum(session, jobRoleId);
    final due = dueDate ?? DateTime.now().add(const Duration(days: 30));
    for (final courseVersionId in curriculum) {
      final hasActive = await TrainingAssignmentService.hasActiveEnrollment(
        session,
        userId: user.id!,
        courseVersionId: courseVersionId,
      );
      if (hasActive) continue;

      final assignment = await TrainingAssignmentService.assign(
        session,
        userId: user.id!,
        courseVersionId: courseVersionId,
        assignedById: assignedById,
        dueDate: due,
        reason: 'onboarding',
        source: 'onboarding',
      );
      await TrainingAssignmentService.createEnrollment(
        session,
        userId: user.id!,
        courseVersionId: courseVersionId,
        assignmentId: assignment.id!,
      );
    }

    // Immutable audit record (21 CFR Part 11).
    await AuditService.log(
      session,
      entityType: 'pharma_user',
      entityId: user.id!.toString(),
      action: AuditEventType.userCreated,
      newValueJson: jsonEncode({
        'employeeId': normalizedEmployeeId,
        'email': normalizedEmail,
        'fullName': fullName,
        'departmentId': departmentId,
        'siteId': siteId,
        'organizationId': organizationId,
        'jobRoleId': jobRoleId,
        'roleCode': normalizedRoleCode,
      }),
      userId: assignedById,
      reason: 'Admin created user account',
      ipAddress: null,
    );

    return user;
  }

  /// Generates a PBKDF2/argonsafe temporary password that satisfies PasswordPolicyService.
  /// In production, admins typically send a one-time link instead of passwords.
  String _generateTemporaryPassword() {
    final rnd = Random.secure();
    const lower = 'abcdefghijklmnopqrstuvwxyz';
    const upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const digits = '0123456789';
    const special = PasswordPolicyService.specialChars;

    // Start with one char of each required category.
    final required = <String>[
      lower[rnd.nextInt(lower.length)],
      upper[rnd.nextInt(upper.length)],
      digits[rnd.nextInt(digits.length)],
      special[rnd.nextInt(special.length)],
    ];

    final all = '$lower$upper$digits$special';
    while (required.length < PasswordPolicyService.defaultMinLength) {
      required.add(all[rnd.nextInt(all.length)]);
    }

    required.shuffle(rnd);
    final password = required.join();

    // Safety net: if policy ever changes, regenerate until valid.
    if (!PasswordPolicyService.validate(password)) {
      return _generateTemporaryPassword();
    }
    return password;
  }

  Future<void> _provisionAuthAndSendWelcome(
    Session session, {
    required String email,
    required String fullName,
    required String tempPassword,
  }) async {
    final emailIdp = AuthServices.instance.emailIdp;
    final admin = emailIdp.admin;

    final existing = await admin.findAccount(session, email: email);
    if (existing != null) {
      // Auth already exists; do not overwrite credentials or re-email.
      return;
    }

    final authUser = await AuthServices.instance.authUsers.create(session);

    await admin.createEmailAuthentication(
      session,
      authUserId: authUser.id,
      email: email,
      password: tempPassword,
    );

    // Ensure `serverpod_auth_core_profile` exists so RbacHelper can map authUserId -> email.
    await session.db.unsafeQuery(
      r'''INSERT INTO serverpod_auth_core_profile ("authUserId", email, "userName", "fullName")
              VALUES (@authUserId::uuid, @email, @userName, @fullName)
              ON CONFLICT ("authUserId") DO NOTHING''',
      parameters: QueryParameters.named({
        'authUserId': authUser.id.toString(),
        'email': email,
        'userName': email.split('@').first,
        'fullName': fullName,
      }),
    );

    // Direct email delivery (pragmatic mapping to US-ADM-USR-001).
    final subject = 'Pharma LMS - Temporary Login Credentials';
    final body = '''
Hello $fullName,

An administrator created your Pharma LMS account.

Temporary password: $tempPassword

Next step: Please log in and change your password immediately.

Regards,
Pharma LMS Admin
''';

    unawaited(
      EmailService.sendNotificationEmail(
        session,
        email: email,
        subject: subject,
        body: body,
      ),
    );
  }

  /// Bulk import users from CSV (base64).
  ///
  /// Pragmatic production mapping aligned to US-ADM-USR-001/002:
  /// - employeeId (conflict key)
  /// - role (portal role code; e.g. trainer)
  /// - email/firstName/lastName
  /// - departmentId/siteId/organizationId/jobRoleId (training matrix scoping)
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
    final employeeIdx = _colIndex(headerParts, 'employeeid');
    final emailIdx = _colIndex(headerParts, 'email');
    final firstIdx = _colIndex(headerParts, 'firstname');
    final lastIdx = _colIndex(headerParts, 'lastname');
    final deptIdx = _colIndex(headerParts, 'departmentid');
    final siteIdx = _colIndex(headerParts, 'siteid');
    final orgIdx = _colIndex(headerParts, 'organizationid');
    final jobIdx = _colIndex(headerParts, 'jobroleid');
    final roleIdx = _colIndex(headerParts, 'role');

    var imported = 0;
    final errors = <String>[];
    final due = dueDate ?? DateTime.now().add(const Duration(days: 30));

    for (var i = 1; i < lines.length; i++) {
      final cols = _parseCsvLine(lines[i]);
      if (cols.isEmpty) continue;

      final employeeId = employeeIdx != null && employeeIdx < cols.length ? cols[employeeIdx].trim() : '';
      if (employeeId.isEmpty) {
        errors.add('Row ${i + 1}: missing employeeId');
        continue;
      }

      final email = emailIdx != null && emailIdx < cols.length ? cols[emailIdx].trim() : '';
      if (email.isEmpty) {
        errors.add('Row ${i + 1}: missing email');
        continue;
      }

      final roleCodeRaw = roleIdx != null && roleIdx < cols.length ? cols[roleIdx].trim() : '';
      final roleCode = roleCodeRaw.toLowerCase();
      if (roleCode.isEmpty) {
        errors.add('Row ${i + 1}: missing role');
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
        where: (t) => t.employeeId.equals(employeeId),
      );

      try {
        final firstName =
            firstIdx != null && firstIdx < cols.length ? cols[firstIdx].trim() : 'User';
        final lastName =
            lastIdx != null && lastIdx < cols.length ? cols[lastIdx].trim() : '';
        final fullName = '${firstName.trim()} ${lastName.trim()}'.trim();

        final role = await Role.db.findFirstRow(
          session,
          where: (t) => t.code.equals(roleCode),
        );
        if (role == null) {
          errors.add('Row ${i + 1}: role "$roleCode" not found');
          continue;
        }

        if (existing == null) {
          await createUserWithRole(
            session,
            employeeId: employeeId,
            email: email,
            firstName: firstName,
            lastName: lastName,
            departmentId: deptId,
            siteId: siteId,
            organizationId: orgId,
            jobRoleId: jobRoleId,
            roleCode: roleCode,
            assignedById: assignedById,
            dueDate: due,
          );
        } else {
          // UPDATE existing user (conflict resolution).
          final normalizedEmail = email.trim().toLowerCase();
          final existingEmail = existing.email.trim().toLowerCase();
          if (existingEmail.isNotEmpty && existingEmail != normalizedEmail) {
            errors.add('Row ${i + 1}: employeeId exists but email differs (existing=$existingEmail, incoming=$normalizedEmail)');
            continue;
          }

          final updated = existing.copyWith(
            firstName: firstName,
            lastName: lastName,
            departmentId: deptId,
            jobRoleId: jobRoleId,
            siteId: siteId,
            organizationId: orgId,
            status: 'active',
          );
          await PharmaUser.db.updateRow(session, updated);

          // Replace role(s) for now (single role in CSV).
          await UserRole.db.deleteWhere(
            session,
            where: (t) => t.userId.equals(existing.id!),
          );
          await UserRole.db.insertRow(
            session,
            UserRole(userId: existing.id!, roleId: role.id!),
          );

          // Ensure auth exists; if missing, provision + email new temp password.
          final tempPassword = _generateTemporaryPassword();
          await _provisionAuthAndSendWelcome(
            session,
            email: existing.email,
            fullName: fullName,
            tempPassword: tempPassword,
          );

          // Ensure onboarding enrollments exist for the chosen jobRoleId.
          final curriculum = await getRoleBasedCurriculum(session, jobRoleId);
          for (final courseVersionId in curriculum) {
            final hasActive = await TrainingAssignmentService.hasActiveEnrollment(
              session,
              userId: existing.id!,
              courseVersionId: courseVersionId,
            );
            if (hasActive) continue;

            final assignment = await TrainingAssignmentService.assign(
              session,
              userId: existing.id!,
              courseVersionId: courseVersionId,
              assignedById: assignedById,
              dueDate: due,
              reason: 'onboarding',
              source: 'onboarding',
            );
            await TrainingAssignmentService.createEnrollment(
              session,
              userId: existing.id!,
              courseVersionId: courseVersionId,
              assignmentId: assignment.id!,
            );
          }
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
    await EventService.emitWaiverApproved(
      session,
      waiverId: waiverId,
      userId: waiver.userId,
      courseId: waiver.courseId,
    );
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

  /// List all users with optional filtering and pagination
  Future<List<PharmaUser>> listUsers(
    Session session, {
    int page = 1,
    int perPage = 10,
    String? roleCode,
    String? status,
    String? searchQuery,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'read');
    
    final offset = (page - 1) * perPage;
    
    // Start with base query
    final users = await PharmaUser.db.find(
      session,
      limit: perPage,
      offset: offset,
      orderBy: (t) => t.createdAt,
    );
    
    // If we have filters, apply them in-memory for now
    // TODO: Optimize with SQL WHERE clauses
    var filtered = users;
    
    if (status != null && status.isNotEmpty) {
      filtered = filtered.where((u) => u.status == status).toList();
    }
    
    if (searchQuery != null && searchQuery.isNotEmpty) {
      final lowerSearch = searchQuery.toLowerCase();
      filtered = filtered.where((u) =>
        u.email.toLowerCase().contains(lowerSearch) ||
        u.firstName.toLowerCase().contains(lowerSearch) ||
        u.lastName.toLowerCase().contains(lowerSearch) ||
        (u.employeeId?.toLowerCase().contains(lowerSearch) ?? false)
      ).toList();
    }
    
    if (roleCode != null && roleCode.isNotEmpty) {
      // TODO: Load roles and filter by role
      // For now, return all
    }
    
    return filtered.take(perPage).toList();
  }
  
  /// Get total count of users with optional filtering
  Future<int> getUserCount(
    Session session, {
    String? roleCode,
    String? status,
    String? searchQuery,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'read');
    
    final allUsers = await PharmaUser.db.find(session);
    
    var filtered = allUsers;
    
    if (status != null && status.isNotEmpty) {
      filtered = filtered.where((u) => u.status == status).toList();
    }
    
    if (searchQuery != null && searchQuery.isNotEmpty) {
      final lowerSearch = searchQuery.toLowerCase();
      filtered = filtered.where((u) =>
        u.email.toLowerCase().contains(lowerSearch) ||
        u.firstName.toLowerCase().contains(lowerSearch) ||
        u.lastName.toLowerCase().contains(lowerSearch) ||
        (u.employeeId?.toLowerCase().contains(lowerSearch) ?? false)
      ).toList();
    }
    
    if (roleCode != null && roleCode.isNotEmpty) {
      // TODO: Load roles and filter by role
      // For now, return all
    }
    
    return filtered.length;
  }
  
  /// Get a single user by ID
  Future<PharmaUser?> getUser(Session session, int userId) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'read');
    return await PharmaUser.db.findById(session, userId);
  }
  
  /// Update a user's information
  Future<PharmaUser?> updateUser(
    Session session, {
    required int userId,
    String? firstName,
    String? lastName,
    int? departmentId,
    int? jobRoleId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'write');
    
    final user = await PharmaUser.db.findById(session, userId);
    if (user == null) {
      throw Exception('User not found');
    }
    
    final updated = user.copyWith(
      firstName: firstName ?? user.firstName,
      lastName: lastName ?? user.lastName,
      departmentId: departmentId ?? user.departmentId,
      jobRoleId: jobRoleId ?? user.jobRoleId,
    );
    
    final result = await PharmaUser.db.updateRow(session, updated);
    
    await AuditService.log(
      session,
      entityType: 'pharma_user',
      entityId: userId.toString(),
      action: AuditEventType.assignmentUpdated,
      oldValueJson: jsonEncode({
        'firstName': user.firstName,
        'lastName': user.lastName,
      }),
      newValueJson: jsonEncode({
        'firstName': updated.firstName,
        'lastName': updated.lastName,
      }),
    );
    
    return result;
  }
  
  /// Deactivate a user (soft delete)
  Future<bool> deactivateUser(
    Session session, {
    required int userId,
    required int deactivatedById,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'write');
    
    final user = await PharmaUser.db.findById(session, userId);
    if (user == null) {
      throw Exception('User not found');
    }
    
    final updated = user.copyWith(status: 'inactive');
    await PharmaUser.db.updateRow(session, updated);
    
    // Log audit event
    await AuditService.log(
      session,
      entityType: 'pharma_user',
      entityId: userId.toString(),
      action: AuditEventType.userTerminated,
      oldValueJson: jsonEncode({'status': user.status}),
      newValueJson: jsonEncode({'status': 'inactive'}),
      userId: deactivatedById,
    );
    
    // Lock the auth user
    if (user.email.isNotEmpty) {
      try {
        await lockUserByEmail(session, user.email);
      } catch (_) {
        // Auth user may not exist - continue
      }
    }
    
    return true;
  }

  /// ADM-WF-07: Terminate a user - HR workflow for employee offboarding.
  /// - Updates PharmaUser status to 'terminated'
  /// - Revokes all active UserSessions
  /// - Supersedes all open TrainingAssignments
  /// - Cancels all not_started/in_progress Enrollments
  /// - Writes UserTerminated audit event
  /// Training records, certificates, e-signatures are RETAINED for compliance.
  Future<bool> terminateUser(
    Session session, {
    required int userId,
    required DateTime terminationDate,
    required String reason,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'user', action: 'write');

    if (reason.trim().isEmpty) {
      throw Exception('Termination reason is required (ADM-WF-07)');
    }

    // 1. Fetch the user
    final user = await PharmaUser.db.findById(session, userId);
    if (user == null) throw Exception('User not found');
    if (user.status == 'terminated') {
      throw Exception('User is already terminated');
    }

    final now = DateTime.now();
    final oldStatus = user.status;
    final terminatedById = (await RbacHelper.getCurrentPharmaUser(session))?.id;

    // 2. Update PharmaUser status to 'terminated'
    final updatedUser = user.copyWith(status: 'terminated');
    await PharmaUser.db.updateRow(session, updatedUser);

    // 3. Revoke all active UserSessions for this user
    final activeSessions = await UserSession.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.endedAt.equals(null),
    );
    var revokedSessionCount = 0;
    for (final userSession in activeSessions) {
      final revokedSession = userSession.copyWith(
        endedAt: now,
        endReason: 'admin_revoke',
      );
      await UserSession.db.updateRow(session, revokedSession);
      revokedSessionCount++;
    }

    // 4. Supersede all open TrainingAssignments
    final openAssignments = await TrainingAssignment.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.status.equals('active'),
    );
    var supersededAssignmentCount = 0;
    for (final assignment in openAssignments) {
      final superseded = assignment.copyWith(
        status: 'superseded',
        cancelledAt: now,
        cancelledById: terminatedById,
        cancellationReason: 'Employee terminated: $reason',
      );
      await TrainingAssignment.db.updateRow(session, superseded);

      await AuditService.log(
        session,
        entityType: 'training_assignment',
        entityId: assignment.id.toString(),
        action: AuditEventType.assignmentSuperseded,
        oldValueJson: '{"status":"${assignment.status}"}',
        newValueJson: '{"status":"superseded","reason":"employee_terminated"}',
        userId: terminatedById,
      );
      supersededAssignmentCount++;
    }

    // 5. Cancel all not_started/in_progress Enrollments
    final activeEnrollments = await Enrollment.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          (t.status.equals('not_started') | t.status.equals('in_progress')),
    );
    var cancelledEnrollmentCount = 0;
    for (final enrollment in activeEnrollments) {
      final oldEnrollmentStatus = enrollment.status;
      final cancelled = enrollment.copyWith(status: 'cancelled');
      await Enrollment.db.updateRow(session, cancelled);

      await AuditService.log(
        session,
        entityType: 'enrollment',
        entityId: enrollment.id.toString(),
        action: AuditEventType.enrollmentCancelled,
        oldValueJson: '{"status":"$oldEnrollmentStatus"}',
        newValueJson: '{"status":"cancelled","reason":"employee_terminated"}',
        userId: terminatedById,
      );
      cancelledEnrollmentCount++;
    }

    // 6. Block the auth user to prevent login
    if (user.email.isNotEmpty) {
      try {
        await lockUserByEmail(session, user.email);
      } catch (_) {
        // Auth user may not exist - continue
      }
    }

    // 7. Write UserTerminated audit event
    await AuditService.log(
      session,
      entityType: 'pharma_user',
      entityId: userId.toString(),
      action: AuditEventType.userTerminated,
      oldValueJson: '{"status":"$oldStatus"}',
      newValueJson: jsonEncode({
        'status': 'terminated',
        'terminationDate': terminationDate.toIso8601String(),
        'reason': reason,
        'terminatedById': terminatedById,
        'revokedSessions': revokedSessionCount,
        'supersededAssignments': supersededAssignmentCount,
        'cancelledEnrollments': cancelledEnrollmentCount,
      }),
      userId: terminatedById,
    );

    return true;
  }
}
