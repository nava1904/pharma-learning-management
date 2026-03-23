import 'package:serverpod/serverpod.dart';
import '../services/rbac_helper.dart';
import '../generated/access_reviews/access_review.dart';
import '../generated/access_reviews/role_history.dart';
import '../generated/audit/audit_trail.dart';

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
    // TODO: Validate password, create ElectronicSignature, update all reviews in window
    // Audit event: ACCESS_REVIEW_SIGNED
  }

  // Export signed PDF
  Future<String> exportSignedPdf(Session session, {required int windowId}) async {
    // TODO: Generate PDF, store in S3, return download URL
    // Audit event: ACCESS_REVIEW_EXPORTED
    return '';
  }
}
