import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

import '../generated/protocol.dart';

/// Verifies user password for re-authentication (e.g. e-signature).
///
/// Uses the same Argon2id verifier as the email IdP ([EmailIdpUtils.hashUtil])
/// so hashes created by `createEmailAuthentication` validate correctly.
/// Older non-PHC hashes fall back to [defaultValidatePasswordHash].
class PasswordVerificationService {
  /// Verify password for the given user. Returns true if valid.
  /// Throws if user not found or has no email auth.
  static Future<bool> verifyPassword(
    Session session, {
    required int userId,
    required String password,
  }) async {
    final trimmedPassword = password.trim();
    if (trimmedPassword.isEmpty) return false;

    final user = await PharmaUser.db.findById(session, userId);
    if (user == null || user.email.isEmpty) {
      throw Exception('User not found');
    }

    // Case-insensitive match: pharma_user.email may differ in casing from the IdP row.
    final result = await session.db.unsafeQuery(
      r'SELECT "passwordHash", email FROM serverpod_auth_idp_email_account '
      r'WHERE lower(trim(email)) = lower(trim(@email)) LIMIT 1',
      parameters: QueryParameters.named({'email': user.email}),
    );

    if (result.isEmpty || result.first.isEmpty) {
      throw Exception('User has no email/password account');
    }

    final row = result.first;
    final hashValue = row[0];
    final idpEmail = row.length > 1 ? row[1]?.toString().trim() : null;
    if (idpEmail == null || idpEmail.isEmpty) {
      throw Exception('Invalid auth state');
    }

    String? normalizedHash;
    if (hashValue is String) {
      normalizedHash = hashValue;
    } else if (hashValue is List<int>) {
      normalizedHash = utf8.decode(hashValue);
    } else {
      normalizedHash = hashValue?.toString().trim();
    }

    if (normalizedHash == null || normalizedHash.isEmpty) {
      throw Exception('Invalid auth state');
    }

    // IdP stores PHC-format Argon2id ($argon2id$v=19$m=...); must use IdP hash util.
    if (_isIdpPhcArgon2idHash(normalizedHash)) {
      try {
        final hashUtil = AuthServices.instance.emailIdp.utils.hashUtil;
        return await hashUtil.validateHashFromString(
          secret: trimmedPassword,
          hashString: normalizedHash,
        );
      } catch (_) {
        return false;
      }
    }

    try {
      final validation = await defaultValidatePasswordHash(
        hash: normalizedHash,
        email: idpEmail,
        password: trimmedPassword,
      );
      return validation is PasswordValidationSuccess;
    } catch (_) {
      return false;
    }
  }

  /// PHC strings from [Argon2HashUtil] have 6 segments: '', 'argon2id', 'v=19', params, salt, hash.
  static bool _isIdpPhcArgon2idHash(String hash) {
    final parts = hash.split('\$');
    return parts.length >= 6 &&
        parts[1] == 'argon2id' &&
        parts[2].startsWith('v=');
  }
}
