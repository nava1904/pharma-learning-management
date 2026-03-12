import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Biometric + secure storage for e-signature (plan 6B).
/// On web, biometric and secure storage may be unavailable.
class BiometricStorage {
  BiometricStorage._();

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const _keyPrefix = 'pharma_lms_biometric_token_';

  static String _key(int userId) => '$_keyPrefix$userId';

  /// Returns true if biometric auth is available on this device.
  static Future<bool> get isBiometricAvailable async {
    if (kIsWeb) return false;
    try {
      final auth = LocalAuthentication();
      return await auth.canCheckBiometrics;
    } catch (_) {
      return false;
    }
  }

  /// Returns true if we have a stored token for this user (may be expired server-side).
  static Future<bool> hasStoredToken(int userId) async {
    try {
      final token = await _storage.read(key: _key(userId));
      return token != null && token.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// Store biometric token after successful password sign. Call [issueBiometricToken] then this.
  static Future<void> storeToken(int userId, String token) async {
    try {
      await _storage.write(key: _key(userId), value: token);
    } catch (_) {}
  }

  /// Read stored token (call after [authenticateWithBiometric]).
  static Future<String?> readToken(int userId) async {
    try {
      return await _storage.read(key: _key(userId));
    } catch (_) {
      return null;
    }
  }

  /// Prompt user for biometric (Face ID / Touch ID). Returns true if authenticated.
  static Future<bool> authenticateWithBiometric({String reason = 'Sign with biometric'}) async {
    if (kIsWeb) return false;
    try {
      final auth = LocalAuthentication();
      if (!await auth.canCheckBiometrics) return false;
      return await auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }

  /// Clear stored token for user (e.g. on logout).
  static Future<void> clearToken(int userId) async {
    try {
      await _storage.delete(key: _key(userId));
    } catch (_) {}
  }
}
