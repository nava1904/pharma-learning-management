import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/esignature_service.dart';
import '../services/rbac_helper.dart';

/// Inspection and auditor access endpoint.
class InspectionEndpoint extends Endpoint {
  /// List inspection records (for Admin/QA).
  Future<List<InspectionRecord>> listInspectionRecords(
    Session session, {
    int limit = 50,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'inspection', action: 'read');
    return InspectionRecord.db.find(
      session,
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
      include: InspectionRecord.include(site: Site.include()),
    );
  }

  /// Create inspection record and generate time-limited access token.
  Future<Map<String, dynamic>> createInspectionRecord(
    Session session, {
    required String inspectionType,
    required int siteId,
    String? scopeDescription,
    DateTime? scheduledDate,
    String? inspectorNames,
    int tokenHoursValid = 48,
    int? createdById,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'inspection', action: 'write');
    final token = _generateSecureToken();
    final expiresAt = DateTime.now().add(Duration(hours: tokenHoursValid));

    final record = InspectionRecord(
      inspectionType: inspectionType,
      siteId: siteId > 0 ? siteId : null,
      scopeDescription: scopeDescription,
      scheduledDate: scheduledDate,
      inspectorNames: inspectorNames,
      status: 'scheduled',
      inspectionAccessToken: token,
      tokenExpiresAt: expiresAt,
      createdById: createdById,
    );
    final inserted = await InspectionRecord.db.insertRow(session, record);

    await AuditService.log(
      session,
      entityType: 'inspection_record',
      entityId: inserted.id.toString(),
      action: 'InspectionRecordCreated',
      newValueJson: '{"tokenExpiresAt":"${expiresAt.toIso8601String()}"}',
      userId: createdById,
    );

    return {
      'inspectionRecordId': inserted.id,
      'accessToken': token,
      'expiresAt': expiresAt.toIso8601String(),
      'inviteUrl': '/auditor?token=$token',
    };
  }

  /// Validate auditor token and return session scope.
  Future<Map<String, dynamic>?> validateAuditorToken(
    Session session, {
    required String token,
  }) async {
    final records = await InspectionRecord.db.find(
      session,
      where: (t) =>
          t.inspectionAccessToken.equals(token) &
          (t.tokenExpiresAt > DateTime.now()),
      include: InspectionRecord.include(site: Site.include()),
    );
    if (records.isEmpty) return null;
    final r = records.first;
    return {
      'inspectionRecordId': r.id,
      'scopeDescription': r.scopeDescription,
      'expiresAt': r.tokenExpiresAt?.toIso8601String(),
      'siteName': r.site?.name,
      'inspectorNames': r.inspectorNames,
    };
  }

  /// List page logs for an inspection record (for auditor session widget).
  Future<List<AuditorPageLog>> listAuditorPageLogs(
    Session session, {
    required int inspectionRecordId,
    int limit = 50,
  }) async {
    final sessions = await AuditorSession.db.find(
      session,
      where: (t) => t.inspectionRecordId.equals(inspectionRecordId),
    );
    if (sessions.isEmpty) return [];
    final sessionIds = sessions.map((s) => s.id).whereType<int>().toList();
    return AuditorPageLog.db.find(
      session,
      where: (t) => t.auditorSessionId.inSet(sessionIds.toSet()),
      orderBy: (t) => t.viewedAt,
      orderDescending: true,
      limit: limit,
    );
  }

  /// Log auditor page view.
  Future<void> logAuditorPageView(
    Session session, {
    required int inspectionRecordId,
    required String pageUrl,
    String? pageTitle,
    String? entityType,
    String? entityId,
    int? timeOnPageSeconds,
  }) async {
    final sessions = await AuditorSession.db.find(
      session,
      where: (t) =>
          t.inspectionRecordId.equals(inspectionRecordId) &
          t.isActive.equals(true),
    );
    AuditorSession? auditorSession;
    if (sessions.isEmpty) {
      auditorSession = AuditorSession(
        inspectionRecordId: inspectionRecordId,
        accessType: 'internal',
        accessToken: null,
        tokenIssuedAt: DateTime.now(),
        tokenExpiresAt: DateTime.now().add(const Duration(hours: 48)),
        isActive: true,
        pagesViewedCount: 1,
        lastActivityAt: DateTime.now(),
      );
      auditorSession = await AuditorSession.db.insertRow(session, auditorSession);
    } else {
      auditorSession = sessions.first;
      await AuditorSession.db.updateRow(
        session,
        auditorSession.copyWith(
          pagesViewedCount: (auditorSession.pagesViewedCount) + 1,
          lastActivityAt: DateTime.now(),
        ),
      );
    }
    final sessionId = auditorSession.id;
    if (sessionId == null) return;
    await AuditorPageLog.db.insertRow(
      session,
      AuditorPageLog(
        auditorSessionId: sessionId,
        pageUrl: pageUrl,
        pageTitle: pageTitle,
        entityType: entityType,
        entityId: entityId,
        timeOnPageSeconds: timeOnPageSeconds,
      ),
    );
  }

  /// List inspection packages for a record (for Admin/QA).
  Future<List<InspectionPackage>> listInspectionPackages(
    Session session, {
    required int inspectionRecordId,
    int limit = 20,
  }) async {
    return InspectionPackage.db.find(
      session,
      where: (t) => t.inspectionRecordId.equals(inspectionRecordId),
      orderBy: (t) => t.generatedAt,
      orderDescending: true,
      limit: limit,
      include: InspectionPackage.include(
        generatedBy: PharmaUser.include(),
        officialEsignature: ElectronicSignature.include(),
      ),
    );
  }

  /// Generate evidence package for auditor (token-based). One-click from auditor portal.
  Future<Map<String, dynamic>> generateEvidencePackageForAuditor(
    Session session, {
    required String token,
  }) async {
    final validation = await validateAuditorToken(session, token: token);
    if (validation == null) throw Exception('Invalid or expired token');
    final inspectionRecordId = validation['inspectionRecordId'] as int?;
    if (inspectionRecordId == null) throw Exception('Invalid token response');
    final record = await InspectionRecord.db.findById(session, inspectionRecordId);
    if (record == null) throw Exception('Inspection record not found');
    var generatedById = record.createdById;
    if (generatedById == null || generatedById <= 0) {
      final users = await PharmaUser.db.find(session, limit: 1);
      if (users.isEmpty || users.first.id == null) {
        throw Exception('No user for package attribution');
      }
      generatedById = users.first.id!;
    }
    return generateInspectionPackage(
      session,
      inspectionRecordId: inspectionRecordId,
      generatedById: generatedById!,
    );
  }

  /// Generate inspection package (summary of in-scope records).
  /// Creates package with isOfficial: false; QA Director must sign to make official.
  Future<Map<String, dynamic>> generateInspectionPackage(
    Session session, {
    required int inspectionRecordId,
    required int generatedById,
  }) async {
    final record = await InspectionRecord.db.findById(
      session,
      inspectionRecordId,
      include: InspectionRecord.include(site: Site.include()),
    );
    if (record == null) throw Exception('Inspection record not found');

    final trainingRecords = await TrainingRecord.db.count(session);
    final certificates = await Certificate.db.count(session);
    final auditTrailCount = await AuditTrail.db.count(session);
    final capas = await Capa.db.count(session);

    final content = 'Inspection Package\n'
        'Generated: ${DateTime.now().toIso8601String()}\n'
        'Scope: ${record.scopeDescription ?? "All"}\n'
        'Training Records: $trainingRecords\n'
        'Certificates: $certificates\n'
        'Audit Trail Entries: $auditTrailCount\n'
        'CAPAs: $capas\n';
    final hash = sha256.convert(utf8.encode(content)).toString();

    final pkg = InspectionPackage(
      inspectionRecordId: inspectionRecordId,
      generatedById: generatedById,
      isOfficial: false,
      scopeDescription: record.scopeDescription,
      includedRecordsCount: trainingRecords + certificates + auditTrailCount + capas,
      fileHash: hash,
      storageUrl: null,
      watermarkText: 'AUDIT COPY - Generated ${DateTime.now().toIso8601String()}',
    );
    final inserted = await InspectionPackage.db.insertRow(session, pkg);

    return {
      'packageId': inserted.id,
      'fileHash': hash,
      'watermarkText': pkg.watermarkText,
      'includedRecordsCount': pkg.includedRecordsCount,
      'isOfficial': pkg.isOfficial,
    };
  }

  /// Sign inspection package as official (QA Director e-sign). ADM-10.
  /// Requires QA Director, Admin, or QA role.
  Future<InspectionPackage> signInspectionPackageAsOfficial(
    Session session, {
    required int packageId,
    required int userId,
    required String signatureMeaning,
    String? passwordReauth,
    String? ipAddress,
  }) async {
    final userRoles = await UserRole.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      include: UserRole.include(role: Role.include()),
    );
    final allowedCodes = {'qa_director', 'admin', 'qa'};
    final hasPermission = userRoles.any(
      (ur) => ur.role != null && allowedCodes.contains(ur.role!.code.toLowerCase()),
    );
    if (!hasPermission) {
      throw Exception('QA Director, Admin, or QA role required to sign as official');
    }

    final pkg = await InspectionPackage.db.findById(session, packageId);
    if (pkg == null) throw Exception('Inspection package not found');
    if (pkg.isOfficial) throw Exception('Package already signed as official');

    final signature = await EsignatureService.sign(
      session,
      userId: userId,
      signatureMeaning: signatureMeaning,
      entityType: 'inspection_package',
      entityId: packageId.toString(),
      passwordReauth: passwordReauth,
      ipAddress: ipAddress,
    );

    final updated = pkg.copyWith(
      isOfficial: true,
      officialEsignatureId: signature.id,
    );
    final result = await InspectionPackage.db.updateRow(session, updated);

    await AuditService.log(
      session,
      entityType: 'inspection_package',
      entityId: packageId.toString(),
      action: 'InspectionPackageOfficial',
      newValueJson: '{"officialEsignatureId":${signature.id},"signedById":$userId}',
      userId: userId,
    );

    return result;
  }

  /// AUD-02: Search employees for audit with full training chain.
  /// Returns users matching query (by name, email, or ID) with assignments,
  /// enrollments, training records, certificates.
  Future<List<Map<String, dynamic>>> searchEmployeesForAudit(
    Session session, {
    required String query,
    int? inspectionRecordId,
    int limit = 20,
  }) async {
    final q = query.trim();
    if (q.isEmpty) return [];

    final idMatch = int.tryParse(q);
    final pattern = '%$q%';

    List<PharmaUser> users;
    if (idMatch != null) {
      users = await PharmaUser.db.find(
        session,
        where: (t) =>
            t.id.equals(idMatch) |
            t.email.ilike(pattern) |
            t.firstName.ilike(pattern) |
            t.lastName.ilike(pattern),
        limit: limit,
      );
    } else {
      users = await PharmaUser.db.find(
        session,
        where: (t) =>
            t.email.ilike(pattern) |
            t.firstName.ilike(pattern) |
            t.lastName.ilike(pattern),
        limit: limit,
      );
    }

    final results = <Map<String, dynamic>>[];
    for (final user in users) {
      final userId = user.id!;
      final assignments = await TrainingAssignment.db.find(
        session,
        where: (t) => t.userId.equals(userId),
        include: TrainingAssignment.include(
          courseVersion: CourseVersion.include(course: Course.include()),
        ),
      );
      final enrollments = await Enrollment.db.find(
        session,
        where: (t) => t.userId.equals(userId),
        include: Enrollment.include(
          courseVersion: CourseVersion.include(course: Course.include()),
          assignment: TrainingAssignment.include(),
        ),
      );
      final records = await TrainingRecord.db.find(
        session,
        where: (t) => t.userId.equals(userId),
        include: TrainingRecord.include(
          courseVersion: CourseVersion.include(course: Course.include()),
          enrollment: Enrollment.include(),
        ),
      );
      final certificates = await Certificate.db.find(
        session,
        where: (t) => t.userId.equals(userId),
        include: Certificate.include(
          courseVersion: CourseVersion.include(course: Course.include()),
          trainingRecord: TrainingRecord.include(),
        ),
      );

      results.add({
        'userId': userId,
        'user': {
          'id': user.id,
          'firstName': user.firstName,
          'lastName': user.lastName,
          'email': user.email,
        },
        'assignments': assignments
            .map((a) => {
                  'id': a.id,
                  'courseVersionId': a.courseVersionId,
                  'dueDate': a.dueDate.toIso8601String(),
                  'status': a.status,
                  'priority': a.priority,
                  'source': a.source,
                  'courseTitle': a.courseVersion?.course?.title,
                })
            .toList(),
        'enrollments': enrollments
            .map((e) => {
                  'id': e.id,
                  'status': e.status,
                  'courseVersionId': e.courseVersionId,
                  'startedAt': e.startedAt?.toIso8601String(),
                  'completedAt': e.completedAt?.toIso8601String(),
                  'assignmentId': e.assignmentId,
                  'courseTitle': e.courseVersion?.course?.title,
                })
            .toList(),
        'records': records
            .map((r) => {
                  'id': r.id,
                  'score': r.score,
                  'passedAt': r.completedAt.toIso8601String(),
                  'courseVersionId': r.courseVersionId,
                  'enrollmentId': r.enrollmentId,
                  'courseTitle': r.courseVersion?.course?.title,
                })
            .toList(),
        'certificates': certificates
            .map((c) => {
                  'id': c.id,
                  'status': c.status,
                  'issuedAt': c.issuedAt.toIso8601String(),
                  'expiresAt': c.expiresAt?.toIso8601String(),
                  'courseVersionId': c.courseVersionId,
                  'courseTitle': c.courseVersion?.course?.title,
                })
            .toList(),
      });
    }
    return results;
  }

  /// AUD-03: SOP training coverage - qualified vs non-qualified users.
  /// qualified = completed training for that SOP/course version.
  /// nonQualified = users in affected depts/roles who haven't completed.
  Future<Map<String, dynamic>> getSopTrainingCoverage(
    Session session, {
    required int sopDocumentId,
    required int versionId,
  }) async {
    final doc = await Document.db.findById(session, sopDocumentId);
    if (doc == null) throw Exception('SOP document not found');

    final courseVersion =
        await CourseVersion.db.findById(session, versionId);
    if (courseVersion == null) throw Exception('Course version not found');

    final course = await Course.db.findById(session, courseVersion.courseId);
    if (course == null ||
        course.sopNumber != doc.documentNumber) {
      throw Exception('Course version does not match SOP document');
    }

    final qualified = <Map<String, dynamic>>[];
    final records = await TrainingRecord.db.find(
      session,
      where: (t) => t.courseVersionId.equals(versionId),
      include: TrainingRecord.include(user: PharmaUser.include()),
    );
    for (final r in records) {
      if (r.user != null) {
        qualified.add({
          'userId': r.user!.id,
          'userName': '${r.user!.firstName} ${r.user!.lastName}'.trim(),
          'completedAt': r.completedAt.toIso8601String(),
        });
      }
    }

    List<int> deptIds = [];
    List<int> roleIds = [];
    if (doc.affectedDepartmentIdsJson != null) {
      try {
        final list = jsonDecode(doc.affectedDepartmentIdsJson!) as List<dynamic>?;
        deptIds = list
                ?.map((e) => (e is int) ? e : int.tryParse(e.toString()) ?? 0)
                .where((x) => x > 0)
                .toList() ??
            [];
      } catch (_) {}
    }
    if (doc.affectedRoleIdsJson != null) {
      try {
        final list = jsonDecode(doc.affectedRoleIdsJson!) as List<dynamic>?;
        roleIds = list
                ?.map((e) => (e is int) ? e : int.tryParse(e.toString()) ?? 0)
                .where((x) => x > 0)
                .toList() ??
            [];
      } catch (_) {}
    }

    final qualifiedUserIds = qualified.map((e) => e['userId'] as int).toSet();
    final nonQualified = <Map<String, dynamic>>[];

    if (deptIds.isNotEmpty) {
      final users = await PharmaUser.db.find(
        session,
        where: (t) => t.departmentId.inSet(deptIds.toSet()),
      );
      for (final u in users) {
        if (u.id != null && !qualifiedUserIds.contains(u.id)) {
          nonQualified.add({
            'userId': u.id,
            'userName': '${u.firstName} ${u.lastName}'.trim(),
          });
        }
      }
    }
    if (roleIds.isNotEmpty) {
      final userRoles = await UserRole.db.find(
        session,
        where: (t) => t.roleId.inSet(roleIds.toSet()),
      );
      final roleUserIds =
          userRoles.map((ur) => ur.userId).whereType<int>().toSet();
      for (final uid in roleUserIds) {
        if (!qualifiedUserIds.contains(uid)) {
          final existing = nonQualified.any((m) => m['userId'] == uid);
          if (!existing) {
            final u = await PharmaUser.db.findById(session, uid);
            if (u != null) {
              nonQualified.add({
                'userId': u.id,
                'userName': '${u.firstName} ${u.lastName}'.trim(),
              });
            }
          }
        }
      }
    }

    if (deptIds.isEmpty && roleIds.isEmpty) {
      final allUsers = await PharmaUser.db.find(session);
      for (final u in allUsers) {
        if (u.id != null && !qualifiedUserIds.contains(u.id)) {
          nonQualified.add({
            'userId': u.id,
            'userName': '${u.firstName} ${u.lastName}'.trim(),
          });
        }
      }
    }

    return {
      'qualified': qualified,
      'nonQualified': nonQualified,
    };
  }

  String _generateSecureToken() {
    final bytes = utf8.encode(
      '${DateTime.now().millisecondsSinceEpoch}${DateTime.now().microsecond}',
    );
    return sha256.convert(bytes).toString().substring(0, 32);
  }
}
