import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

import '../generated/protocol.dart';

/// Verifies user password for re-authentication (e.g. e-signature).
/// Uses Argon2id via Serverpod's defaultValidatePasswordHash.
class PasswordVerificationService {
  /// Verify password for the given user. Returns true if valid.
  /// Throws if user not found or has no email auth.
  static Future<bool> verifyPassword(
    Session session, {
    required int userId,
    required String password,
  }) async {
    if (password.isEmpty) return false;

    final user = await PharmaUser.db.findById(session, userId);
    if (user == null || user.email.isEmpty) {
      throw Exception('User not found');
    }

    final result = await session.db.unsafeQuery(
      r'SELECT "passwordHash" FROM serverpod_auth_idp_email_account WHERE email = @email LIMIT 1',
      parameters: QueryParameters.named({'email': user.email}),
    );

    if (result.isEmpty || result.first.isEmpty) {
      throw Exception('User has no email/password account');
    }

    final hash = result.first[0]?.toString();
    if (hash == null || hash.isEmpty) {
      throw Exception('Invalid auth state');
    }

    final validation = await defaultValidatePasswordHash(
      hash: hash,
      email: user.email,
      password: password,
    );

    return validation is PasswordValidationSuccess;
  }
}
