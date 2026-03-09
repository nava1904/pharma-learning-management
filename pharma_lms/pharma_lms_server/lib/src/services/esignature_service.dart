import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Electronic signature service for FDA 21 CFR Part 11 compliance.
/// Every training completion requires electronic signature.
class EsignatureService {
  static String _getHmacSecret() {
    return Platform.environment['ESIGNATURE_HMAC_SECRET'] ??
        'pharma-lms-esig-secret-change-in-production';
  }

  static String _computeIntegrityHash(
    int userId,
    String entityType,
    String entityId,
    DateTime timestamp,
    String signatureMeaning,
  ) {
    final payload = '$userId|$entityType|$entityId|${timestamp.toIso8601String()}|$signatureMeaning';
    final key = utf8.encode(_getHmacSecret());
    final bytes = utf8.encode(payload);
    final hmac = Hmac(sha256, key);
    return hmac.convert(bytes).toString();
  }

  /// Verify integrity of a stored signature.
  /// Returns true if valid, false if mismatch. Legacy signatures (no integrityHash) return true.
  static bool verifyIntegrity(ElectronicSignature sig) {
    if (sig.integrityHash == null || sig.integrityHash!.isEmpty) {
      return true;
    }
    final computed = _computeIntegrityHash(
      sig.userId,
      sig.entityType,
      sig.entityId,
      sig.timestamp,
      sig.signatureMeaning,
    );
    return sig.integrityHash == computed;
  }

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
    final now = DateTime.now();
    final integrityHash = _computeIntegrityHash(
      userId,
      entityType,
      entityId,
      now,
      signatureMeaning,
    );
    final signature = ElectronicSignature(
      userId: userId,
      signatureMeaning: signatureMeaning,
      entityType: entityType,
      entityId: entityId,
      passwordReauthHash: passwordReauthHash,
      ipAddress: ipAddress,
      integrityHash: integrityHash,
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
