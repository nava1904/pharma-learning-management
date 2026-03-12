import 'package:otp/otp.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/rbac_helper.dart';

/// MFA (TOTP) endpoint: enroll, verify, status, disable.
/// Uses otp package for RFC6238 TOTP compatible with Google Authenticator.
class MfaEndpoint extends Endpoint {
  static const _totpInterval = 30;
  static const _totpLength = 6;

  /// Returns MFA status for the current user. Requires auth.
  Future<MfaStatusResult> getMfaStatus(Session session) async {
    final authUserId = session.authenticated?.userIdentifier;
    if (authUserId == null || authUserId.isEmpty) {
      throw RbacException('Authentication required');
    }
    final row = await UserMfa.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    return MfaStatusResult(
      mfaEnabled: row?.mfaEnabled ?? false,
      enrolledAt: row?.enrolledAt,
    );
  }

  /// Starts MFA enrollment. Generates secret and returns it for QR setup.
  Future<MfaEnrollResult> enrollMfa(Session session) async {
    final authUserId = session.authenticated?.userIdentifier;
    if (authUserId == null || authUserId.isEmpty) {
      throw RbacException('Authentication required');
    }
    var row = await UserMfa.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    final secret = OTP.randomSecret();
    if (row != null) {
      row = row.copyWith(
        mfaSecretBase32: secret,
        mfaEnabled: false,
        enrolledAt: DateTime.now(),
      );
      await UserMfa.db.updateRow(session, row);
    } else {
      row = await UserMfa.db.insertRow(
        session,
        UserMfa(
          authUserId: authUserId,
          mfaSecretBase32: secret,
          mfaEnabled: false,
          enrolledAt: DateTime.now(),
        ),
      );
    }
    return MfaEnrollResult(
      secretBase32: secret,
      otpauthUrl: _buildOtpauthUrl(secret, authUserId),
    );
  }

  /// Verifies the TOTP code and enables MFA.
  Future<bool> verifyMfaEnrollment(Session session, String code) async {
    final authUserId = session.authenticated?.userIdentifier;
    if (authUserId == null || authUserId.isEmpty) {
      throw RbacException('Authentication required');
    }
    final row = await UserMfa.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (row == null) {
      throw RbacException('MFA enrollment not started. Call enrollMfa first.');
    }
    if (!_verifyTotp(row.mfaSecretBase32, code)) {
      return false;
    }
    await UserMfa.db.updateRow(
      session,
      row.copyWith(mfaEnabled: true),
    );
    return true;
  }

  /// Verifies TOTP code for login. Records session as MFA-verified.
  Future<bool> verifyMfa(Session session, String code) async {
    final authUserId = session.authenticated?.userIdentifier;
    if (authUserId == null || authUserId.isEmpty) {
      throw RbacException('Authentication required');
    }
    final row = await UserMfa.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (row == null || !row.mfaEnabled) {
      throw RbacException('MFA not enabled for this user');
    }
    if (!_verifyTotp(row.mfaSecretBase32, code)) {
      return false;
    }
    await _cleanOldMfaSessions(session, authUserId);
    await MfaVerifiedSession.db.insertRow(
      session,
      MfaVerifiedSession(
        authUserId: authUserId,
        sessionId: authUserId,
        verifiedAt: DateTime.now(),
      ),
    );
    return true;
  }

  /// Disables MFA for the current user.
  Future<void> disableMfa(Session session) async {
    final authUserId = session.authenticated?.userIdentifier;
    if (authUserId == null || authUserId.isEmpty) {
      throw RbacException('Authentication required');
    }
    final row = await UserMfa.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (row != null) {
      await UserMfa.db.updateRow(
        session,
        row.copyWith(mfaEnabled: false, mfaSecretBase32: ''),
      );
    }
    await _cleanOldMfaSessions(session, authUserId);
  }

  /// Checks if the current session has passed MFA verification.
  Future<bool> isMfaVerified(Session session) async {
    final authUserId = session.authenticated?.userIdentifier;
    if (authUserId == null || authUserId.isEmpty) return false;
    final cutoff = DateTime.now().subtract(const Duration(minutes: 30));
    final verified = await MfaVerifiedSession.db.findFirstRow(
      session,
      where: (t) =>
          (t.authUserId.equals(authUserId) &
          (t.verifiedAt.between(cutoff, DateTime.now().add(const Duration(days: 1))))),
    );
    return verified != null;
  }

  bool _verifyTotp(String secretBase32, String code) {
    final now = DateTime.now().millisecondsSinceEpoch;
    for (var offset = -1; offset <= 1; offset++) {
      final t = now + (offset * _totpInterval * 1000);
      final expected = OTP.generateTOTPCodeString(
        secretBase32,
        t,
        length: _totpLength,
        interval: _totpInterval,
        algorithm: Algorithm.SHA1,
        isGoogle: true,
      );
      if (OTP.constantTimeVerification(code, expected)) return true;
    }
    return false;
  }

  String _buildOtpauthUrl(String secret, String authUserId) {
    final issuer = Uri.encodeComponent('Pharma LMS');
    final account = Uri.encodeComponent(authUserId);
    return 'otpauth://totp/$issuer:$account?secret=$secret&issuer=$issuer&algorithm=SHA1&digits=$_totpLength&period=$_totpInterval';
  }

  Future<void> _cleanOldMfaSessions(Session session, String authUserId) async {
    final cutoff = DateTime.now().subtract(const Duration(minutes: 30));
    await MfaVerifiedSession.db.deleteWhere(
      session,
      where: (t) =>
          (t.authUserId.equals(authUserId) & (t.verifiedAt.between(DateTime(1970), cutoff))),
    );
  }
}
