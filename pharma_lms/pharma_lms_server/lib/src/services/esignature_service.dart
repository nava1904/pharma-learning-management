import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Electronic signature service for FDA 21 CFR Part 11 compliance.
/// Every training completion requires electronic signature.
class EsignatureService {
  /// Signature meanings per 21 CFR Part 11.
  static const String meaningReadUnderstood = 'I have read and understood';
  static const String meaningVerification = 'Verification';
  static const String meaningApproval = 'Approval';

  /// Create and store an electronic signature.
  static Future<ElectronicSignature> sign(
    Session session, {
    required int userId,
    required String signatureMeaning,
    required String entityType,
    required String entityId,
    String? passwordReauthHash,
    String? ipAddress,
  }) async {
    final signature = ElectronicSignature(
      userId: userId,
      signatureMeaning: signatureMeaning,
      entityType: entityType,
      entityId: entityId,
      passwordReauthHash: passwordReauthHash,
      ipAddress: ipAddress,
    );
    return await ElectronicSignature.db.insertRow(session, signature);
  }

  /// Verify signature exists for entity.
  static Future<ElectronicSignature?> getForEntity(
    Session session, {
    required String entityType,
    required String entityId,
  }) async {
    final results = await ElectronicSignature.db.find(
      session,
      where: (t) =>
          t.entityType.equals(entityType) & t.entityId.equals(entityId),
    );
    return results.isNotEmpty ? results.first : null;
  }
}
