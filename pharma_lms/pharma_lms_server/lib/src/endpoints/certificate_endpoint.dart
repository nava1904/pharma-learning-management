import 'dart:math';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/rbac_helper.dart';

/// Certificate management endpoint for Admin Portal.
/// Manages training certificates and their lifecycle.
class CertificateEndpoint extends Endpoint {
  /// List all certificates for an organization.
  Future<List<Certificate>> listCertificates(
    Session session, {
    required int organizationId,
    String? status,
    int? userId,
    int? courseVersionId,
    int? limit,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'certificate', action: 'read')) return [];
    
    // Get all users in the organization first
    final users = await PharmaUser.db.find(
      session,
      where: (t) => t.organizationId.equals(organizationId),
    );
    final userIds = users.map((u) => u.id!).toList();
    
    if (userIds.isEmpty) return [];
    
    // Build where expression
    var whereExpr = Certificate.t.userId.inSet(userIds.toSet());
    
    if (status != null && status.isNotEmpty) {
      whereExpr = whereExpr & Certificate.t.status.equals(status);
    }
    
    if (userId != null) {
      whereExpr = whereExpr & Certificate.t.userId.equals(userId);
    }
    
    if (courseVersionId != null) {
      whereExpr = whereExpr & Certificate.t.courseVersionId.equals(courseVersionId);
    }
    
    return await Certificate.db.find(
      session,
      where: (t) => whereExpr,
      include: Certificate.include(
        user: PharmaUser.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
        trainingRecord: TrainingRecord.include(),
        esignature: ElectronicSignature.include(),
      ),
      orderBy: (t) => t.issuedAt,
      orderDescending: true,
      limit: limit,
    );
  }

  /// Get a single certificate by ID.
  Future<Certificate?> getCertificate(Session session, int certificateId) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'certificate', action: 'read')) return null;
    
    return await Certificate.db.findById(
      session,
      certificateId,
      include: Certificate.include(
        user: PharmaUser.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
        trainingRecord: TrainingRecord.include(),
        esignature: ElectronicSignature.include(),
      ),
    );
  }

  /// Get certificates for a specific user.
  Future<List<Certificate>> getUserCertificates(Session session, int userId) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'certificate', action: 'read')) return [];
    
    return await Certificate.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      include: Certificate.include(
        user: PharmaUser.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
        trainingRecord: TrainingRecord.include(),
      ),
      orderBy: (t) => t.issuedAt,
      orderDescending: true,
    );
  }

  /// Revoke a certificate.
  Future<Certificate?> revokeCertificate(
    Session session,
    int certificateId, {
    String? reason,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'certificate', action: 'update')) return null;
    
    final existing = await Certificate.db.findById(session, certificateId);
    if (existing == null) return null;
    
    final updated = existing.copyWith(
      status: 'revoked',
    );
    
    return await Certificate.db.updateRow(session, updated);
  }

  /// Get certificate statistics for dashboard.
  Future<Map<String, int>> getCertificateStats(Session session, int organizationId) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return {};
    if (!await RbacHelper.hasPermission(session, resource: 'certificate', action: 'read')) return {};
    
    // Get all users in the organization first
    final users = await PharmaUser.db.find(
      session,
      where: (t) => t.organizationId.equals(organizationId),
    );
    final userIds = users.map((u) => u.id!).toList();
    
    if (userIds.isEmpty) {
      return {
        'total': 0,
        'active': 0,
        'expired': 0,
        'revoked': 0,
        'expiring_30_days': 0,
      };
    }
    
    final certificates = await Certificate.db.find(
      session,
      where: (t) => t.userId.inSet(userIds.toSet()),
    );
    
    final now = DateTime.now();
    final thirtyDaysFromNow = now.add(const Duration(days: 30));
    
    return {
      'total': certificates.length,
      'active': certificates.where((c) => c.status == 'active').length,
      'expired': certificates.where((c) => c.status == 'expired').length,
      'revoked': certificates.where((c) => c.status == 'revoked').length,
      'expiring_30_days': certificates.where((c) => 
        c.status == 'active' && 
        c.expiresAt != null && 
        c.expiresAt!.isAfter(now) && 
        c.expiresAt!.isBefore(thirtyDaysFromNow)
      ).length,
    };
  }

  /// Verify a certificate by QR code.
  Future<Certificate?> verifyCertificate(Session session, String qrCode) async {
    return await Certificate.db.findFirstRow(
      session,
      where: (t) => t.qrCode.equals(qrCode),
      include: Certificate.include(
        user: PharmaUser.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );
  }

  /// Manually issue a certificate to a user for a course version.
  Future<Certificate?> issueCertificate(
    Session session, {
    required int userId,
    required int courseVersionId,
    DateTime? expiresAt,
    int? templateId,
  }) async {
    final admin = await RbacHelper.getCurrentPharmaUser(session);
    if (admin == null) return null;
    await RbacHelper.requirePermission(session, resource: 'certificate', action: 'write');

    final qrCode = _generateQrCode();

    final cert = Certificate(
      userId: userId,
      courseVersionId: courseVersionId,
      issuedAt: DateTime.now(),
      expiresAt: expiresAt,
      qrCode: qrCode,
      status: 'active',
    );

    final result = await Certificate.db.insertRow(session, cert);

    await AuditService.log(
      session,
      entityType: 'certificate',
      entityId: result.id.toString(),
      action: 'CertificateIssued',
      newValueJson: '{"userId":$userId,"courseVersionId":$courseVersionId,"templateId":$templateId}',
      userId: admin.id,
    );

    return result;
  }

  /// Generate certificates for all eligible batch participants.
  Future<List<Certificate>> generateBatchCertificates(
    Session session, {
    required int batchId,
    int? templateId,
    DateTime? expiresAt,
  }) async {
    final admin = await RbacHelper.getCurrentPharmaUser(session);
    if (admin == null) return [];
    await RbacHelper.requirePermission(session, resource: 'certificate', action: 'write');

    final batch = await TrainingBatch.db.findById(session, batchId);
    if (batch == null) throw Exception('Batch not found');

    final participants = await TrainingBatchParticipant.db.find(
      session,
      where: (t) => t.batchId.equals(batchId),
    );

    final issued = <Certificate>[];
    for (final p in participants) {
      final existing = await Certificate.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(p.userId) & t.courseVersionId.equals(batch.courseVersionId),
      );
      if (existing != null) continue;

      final qrCode = _generateQrCode();
      final cert = Certificate(
        userId: p.userId,
        courseVersionId: batch.courseVersionId,
        issuedAt: DateTime.now(),
        expiresAt: expiresAt,
        qrCode: qrCode,
        status: 'active',
      );
      final result = await Certificate.db.insertRow(session, cert);
      issued.add(result);
    }

    await AuditService.log(
      session,
      entityType: 'certificate',
      entityId: 'batch_$batchId',
      action: 'BatchCertificatesGenerated',
      newValueJson: '{"batchId":$batchId,"count":${issued.length},"templateId":$templateId}',
      userId: admin.id,
    );

    return issued;
  }

  /// Render certificate as merged HTML by applying template merge fields.
  Future<String> renderCertificateHtml(
    Session session, {
    required int certificateId,
    int? templateId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return '';
    await RbacHelper.requirePermission(session, resource: 'certificate', action: 'read');

    final cert = await Certificate.db.findById(
      session,
      certificateId,
      include: Certificate.include(
        user: PharmaUser.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );
    if (cert == null) return '';

    String html;
    if (templateId != null) {
      final tpl = await CertificateTemplate.db.findById(session, templateId);
      html = tpl?.htmlTemplate ?? _defaultTemplate();
    } else {
      html = _defaultTemplate();
    }

    final userName = cert.user != null
        ? '${cert.user!.firstName} ${cert.user!.lastName}'
        : 'Unknown';
    final courseName = cert.courseVersion?.course?.title ?? 'Unknown Course';
    final orgName = cert.user?.organization?.name ?? '';

    return html
        .replaceAll('{{learnerName}}', userName)
        .replaceAll('{{courseName}}', courseName)
        .replaceAll('{{issueDate}}', cert.issuedAt.toIso8601String().split('T').first)
        .replaceAll('{{expiryDate}}', cert.expiresAt?.toIso8601String().split('T').first ?? 'N/A')
        .replaceAll('{{evaluator}}', '')
        .replaceAll('{{qrCode}}', cert.qrCode ?? '')
        .replaceAll('{{organizationName}}', orgName);
  }

  String _generateQrCode() {
    final rand = Random.secure();
    final bytes = List.generate(16, (_) => rand.nextInt(256));
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  String _defaultTemplate() {
    return '''
<div style="text-align:center;padding:60px;font-family:Georgia,serif;border:4px double #333;margin:20px;">
  <h1 style="color:#1a5276;">Certificate of Completion</h1>
  <p style="font-size:18px;margin:30px 0;">This certifies that</p>
  <h2 style="color:#2c3e50;font-size:28px;">{{learnerName}}</h2>
  <p style="font-size:18px;margin:20px 0;">has successfully completed</p>
  <h3 style="color:#1a5276;">{{courseName}}</h3>
  <p style="margin:30px 0;">Issue Date: {{issueDate}}</p>
  <p>Expiry Date: {{expiryDate}}</p>
  <p style="margin-top:40px;font-size:12px;color:#666;">{{organizationName}}</p>
</div>
''';
  }
}
