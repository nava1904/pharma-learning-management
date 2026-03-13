import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'password_verification_service.dart';

/// Biometric token validity (plan 6B).
const Duration _biometricTokenLifetime = Duration(minutes: 5);

/// Electronic signature service for FDA 21 CFR Part 11 compliance.
/// Every training completion requires electronic signature.
class EsignatureService {
  static String _getHmacSecret() {
    return Platform.environment['ESIGNATURE_HMAC_SECRET'] ??
        'pharma-lms-esig-secret-change-in-production';
  }

  static String _getBiometricSecret() {
    return Platform.environment['BIOMETRIC_TOKEN_SECRET'] ??
        Platform.environment['ESIGNATURE_HMAC_SECRET'] ??
        'pharma-lms-biometric-change-in-production';
  }

  /// Issue a short-lived biometric token after password verification (plan 6B).
  static Future<String> issueBiometricToken(
    Session session, {
    required int userId,
    required String passwordPlaintext,
  }) async {
    final valid = await PasswordVerificationService.verifyPassword(
      session,
      userId: userId,
      password: passwordPlaintext,
    );
    if (!valid) throw Exception('Invalid credentials');
    final expiry = DateTime.now().add(_biometricTokenLifetime).millisecondsSinceEpoch;
    final payload = '$userId|$expiry';
    final key = utf8.encode(_getBiometricSecret());
    final hmac = Hmac(sha256, key).convert(utf8.encode(payload));
    final token = '${base64Url.encode(hmac.bytes)}.${base64Url.encode(utf8.encode(payload))}';
    return token;
  }

  /// Verify biometric token and return userId if valid.
  static int? verifyBiometricToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 2) return null;
      final payloadBytes = base64Url.decode(parts[1]);
      final payload = utf8.decode(payloadBytes);
      final split = payload.split('|');
      if (split.length != 2) return null;
      final userId = int.tryParse(split[0]);
      final expiryMs = int.tryParse(split[1]);
      if (userId == null || expiryMs == null) return null;
      if (DateTime.now().millisecondsSinceEpoch > expiryMs) return null;
      final key = utf8.encode(_getBiometricSecret());
      final expectedHmac = base64Url.encode(Hmac(sha256, key).convert(utf8.encode(payload)).bytes);
      if (parts[0] != expectedHmac) return null;
      return userId;
    } catch (_) {
      return null;
    }
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
  /// When [passwordPlaintext] is provided, verifies it server-side (Argon2id) and does not store it.
  /// When [biometricToken] is provided, verifies the short-lived token and uses its userId (plan 6B).
  static Future<ElectronicSignature> sign(
    Session session, {
    required int userId,
    required String signatureMeaning,
    required String entityType,
    required String entityId,
    String? passwordPlaintext,
    String? biometricToken,
    String? ipAddress,
  }) async {
    int effectiveUserId = userId;
    if (biometricToken != null && biometricToken.isNotEmpty) {
      final tokenUserId = verifyBiometricToken(biometricToken);
      if (tokenUserId == null) throw Exception('Biometric token invalid or expired');
      effectiveUserId = tokenUserId;
    } else if (passwordPlaintext != null && passwordPlaintext.isNotEmpty) {
      final valid = await PasswordVerificationService.verifyPassword(
        session,
        userId: userId,
        password: passwordPlaintext,
      );
      if (!valid) {
        throw Exception('Invalid credentials');
      }
    }

    final now = DateTime.now();
    final integrityHash = _computeIntegrityHash(
      effectiveUserId,
      entityType,
      entityId,
      now,
      signatureMeaning,
    );
    final signature = ElectronicSignature(
      userId: effectiveUserId,
      signatureMeaning: signatureMeaning,
      entityType: entityType,
      entityId: entityId,
      passwordPlaintext: null,
      passwordReauthHash: null,
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

  /// Revoke an electronic signature.
  static Future<void> revokeSignature(
    Session session, {
    required int signatureId,
    required String reason,
    required String passwordPlaintext,
  }) async {
    final signature = await ElectronicSignature.db.findById(session, signatureId);
    if (signature == null) throw Exception('Signature not found');

    final revokerSignature = await sign(
      session,
      userId: signature.userId,
      signatureMeaning: 'Revocation of signature',
      entityType: 'electronic_signature',
      entityId: signatureId.toString(),
      passwordPlaintext: passwordPlaintext,
    );

    signature.isValid = false;
    await ElectronicSignature.db.updateRow(session, signature);

    final certificates = await Certificate.db.find(
      session,
      where: (t) => t.esignatureId.equals(signatureId), // Corrected field name
    );

    for (final cert in certificates) {
      cert.status = 'revoked';
      await Certificate.db.updateRow(session, cert);
    }
  }
}
