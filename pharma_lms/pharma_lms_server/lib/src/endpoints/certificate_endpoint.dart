import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
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
    // Public verification - no auth required
    return await Certificate.db.findFirstRow(
      session,
      where: (t) => t.qrCode.equals(qrCode),
      include: Certificate.include(
        user: PharmaUser.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );
  }
}
