import 'package:serverpod/serverpod.dart';
import 'dart:convert';
import '../services/rbac_helper.dart';
import '../services/esignature_service.dart';
import '../generated/access_reviews/access_review.dart';
import '../generated/access_reviews/role_history.dart';
import '../generated/audit/audit_trail.dart';
import '../generated/shared/electronic_signature.dart';

class AccessReviewEndpoint extends Endpoint {
  // List all access review records for the current window
  Future<List<AccessReview>> getAccessReviews(Session session, int windowId) async {
    return await AccessReview.db.find(
      session,
      where: (t) => t.windowId.equals(windowId),
    );
  }

  // Recertify (approve) a user
  Future<void> recertify(Session session, {required int reviewId, required String justification}) async {
    final review = await AccessReview.db.findById(session, reviewId);
    if (review == null) throw Exception('Review not found');
    if (justification.trim().isEmpty) throw Exception('Justification required');
  review.decision = 'APPROVED';
  review.justification = justification;
  final pharmaUser = await RbacHelper.getCurrentPharmaUser(session);
  review.reviewedById = pharmaUser?.id;
    review.reviewedAt = DateTime.now().toUtc();
    await AccessReview.db.updateRow(session, review);
    // Audit event
    await AuditTrail.db.insertRow(session, AuditTrail(
      entityType: 'access_review',
      entityId: reviewId.toString(),
      action: 'ACCESS_RECERTIFIED',
      newValueJson: justification,
      timestamp: DateTime.now().toUtc(),
      userId: pharmaUser?.id,
      reason: justification,
  ipAddress: 'unknown',
      rowHash: '', // TODO: Compute HMAC chain
    ));
  }

  // Revoke a user's elevated role
  Future<void> revoke(Session session, {required int reviewId, required String justification}) async {
    final review = await AccessReview.db.findById(session, reviewId);
    if (review == null) throw Exception('Review not found');
    if (justification.trim().isEmpty) throw Exception('Justification required');
    review.decision = 'REVOKED';
    review.justification = justification;
  final pharmaUser = await RbacHelper.getCurrentPharmaUser(session);
  review.reviewedById = pharmaUser?.id;
    review.reviewedAt = DateTime.now().toUtc();
    await AccessReview.db.updateRow(session, review);
    // Deactivate user role (TODO: update user_roles, invalidate sessions, clear JWT cache)
    // Role history
    await RoleHistory.db.insertRow(session, RoleHistory(
  userId: review.userId,
  roleId: review.roleId,
      action: 'REVOKED',
      timestamp: DateTime.now().toUtc(),
  performedById: pharmaUser?.id,
  reason: justification,
  grantRecordId: null, // TODO: Link to original grant
  ipAddress: 'unknown',
  hmacHash: '', // TODO: Compute HMAC chain
    ));
    // Audit event
    await AuditTrail.db.insertRow(session, AuditTrail(
      entityType: 'access_review',
      entityId: reviewId.toString(),
      action: 'ACCESS_REVOKED',
      newValueJson: justification,
      timestamp: DateTime.now().toUtc(),
      userId: pharmaUser?.id,
      reason: justification,
  ipAddress: 'unknown',
      rowHash: '', // TODO: Compute HMAC chain
    ));
  }

  // E-signature submission
  Future<void> signReview(Session session, {required int windowId, required String password, required String reason}) async {
    await RbacHelper.requirePermission(session, resource: 'users', action: 'update');
    final pharmaUser = await RbacHelper.getCurrentPharmaUser(session);
    final userId = pharmaUser?.id;
    if (userId == null) throw Exception('User not authenticated');
    if (reason.trim().isEmpty) throw Exception('Signing reason required');

    await EsignatureService.sign(
      session,
      userId: userId,
      signatureMeaning: reason.trim(),
      entityType: 'access_review_window',
      entityId: windowId.toString(),
      passwordPlaintext: password,
      ipAddress: 'unknown',
    );

    await AuditTrail.db.insertRow(
      session,
      AuditTrail(
        entityType: 'access_review_window',
        entityId: windowId.toString(),
        action: 'ACCESS_REVIEW_SIGNED',
        newValueJson: jsonEncode({'reason': reason.trim()}),
        timestamp: DateTime.now().toUtc(),
        userId: userId,
        reason: reason.trim(),
        ipAddress: 'unknown',
        rowHash: '',
      ),
    );
  }

  // Export signed PDF
  Future<String> exportSignedPdf(Session session, {required int windowId}) async {
    await RbacHelper.requirePermission(session, resource: 'users', action: 'read');
    final pharmaUser = await RbacHelper.getCurrentPharmaUser(session);
    final userId = pharmaUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    final signature = await ElectronicSignature.db.findFirstRow(
      session,
      where: (t) =>
          t.entityType.equals('access_review_window') &
          t.entityId.equals(windowId.toString()) &
          t.isValid.equals(true),
      orderBy: (t) => t.timestamp,
      orderDescending: true,
    );
    if (signature == null) {
      throw Exception('Access review window is not signed');
    }

    final reviews = await AccessReview.db.find(
      session,
      where: (t) => t.windowId.equals(windowId),
    );
    final approved = reviews.where((r) => r.decision == 'APPROVED').length;
    final revoked = reviews.where((r) => r.decision == 'REVOKED').length;
    final pending = reviews.where((r) => r.decision == 'PENDING').length;

    final text = StringBuffer()
      ..writeln('Privileged Access Review')
      ..writeln('Window: $windowId')
      ..writeln('Approved: $approved')
      ..writeln('Revoked: $revoked')
      ..writeln('Pending: $pending')
      ..writeln('')
      ..writeln('Signed by userId=${signature.userId} at ${signature.timestamp.toIso8601String()}')
      ..writeln('Meaning: ${signature.signatureMeaning}');

    final pdfBytes = _simplePdf(text.toString());
    final b64 = base64Encode(pdfBytes);

    await AuditTrail.db.insertRow(
      session,
      AuditTrail(
        entityType: 'access_review_window',
        entityId: windowId.toString(),
        action: 'ACCESS_REVIEW_EXPORTED',
        newValueJson: jsonEncode({'bytes': pdfBytes.length}),
        timestamp: DateTime.now().toUtc(),
        userId: userId,
        reason: 'exportSignedPdf',
        ipAddress: 'unknown',
        rowHash: '',
      ),
    );

    return 'data:application/pdf;base64,$b64';
  }

  List<int> _simplePdf(String text) {
    final safe = text.replaceAll('\\', '\\\\').replaceAll('(', '\\(').replaceAll(')', '\\)');
    final content = 'BT /F1 12 Tf 50 750 Td (${safe.replaceAll('\n', ') Tj T* (')}) Tj ET';
    final contentBytes = utf8.encode(content);

    final objects = <String>[];
    objects.add('1 0 obj << /Type /Catalog /Pages 2 0 R >> endobj');
    objects.add('2 0 obj << /Type /Pages /Kids [3 0 R] /Count 1 >> endobj');
    objects.add('3 0 obj << /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Resources << /Font << /F1 4 0 R >> >> /Contents 5 0 R >> endobj');
    objects.add('4 0 obj << /Type /Font /Subtype /Type1 /BaseFont /Helvetica >> endobj');
    objects.add('5 0 obj << /Length ${contentBytes.length} >> stream\n$content\nendstream endobj');

    final xref = <int>[];
    final b = StringBuffer();
    b.writeln('%PDF-1.4');
    for (final obj in objects) {
      xref.add(utf8.encode(b.toString()).length);
      b.writeln(obj);
    }
    final xrefStart = utf8.encode(b.toString()).length;
    b.writeln('xref');
    b.writeln('0 ${objects.length + 1}');
    b.writeln('0000000000 65535 f ');
    for (final off in xref) {
      b.writeln('${off.toString().padLeft(10, '0')} 00000 n ');
    }
    b.writeln('trailer << /Size ${objects.length + 1} /Root 1 0 R >>');
    b.writeln('startxref');
    b.writeln(xrefStart);
    b.writeln('%%EOF');
    return utf8.encode(b.toString());
  }
}
