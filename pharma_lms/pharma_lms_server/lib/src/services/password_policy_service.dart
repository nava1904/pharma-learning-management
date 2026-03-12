/// Password policy service for FDA 21 CFR Part 11 / GxP compliance.
///
/// Enforces:
/// - Minimum length (default 12)
/// - Complexity: uppercase, lowercase, digit, special character
/// - No leading/trailing whitespace
class PasswordPolicyService {
  PasswordPolicyService._();

  /// Default minimum length per pharma compliance spec.
  static const int defaultMinLength = 12;

  /// Default minimum uppercase letters.
  static const int defaultMinUppercase = 1;

  /// Default minimum lowercase letters.
  static const int defaultMinLowercase = 1;

  /// Default minimum digits.
  static const int defaultMinDigits = 1;

  /// Default minimum special characters.
  static const int defaultMinSpecial = 1;

  /// Special characters allowed in passwords.
  static const String specialChars = r'!@#$%^&*()_+-=[]{}|;:,.<>?';

  /// Validates password against policy.
  /// Returns true if valid, false otherwise.
  static bool validate(
    String password, {
    int minLength = defaultMinLength,
    int minUppercase = defaultMinUppercase,
    int minLowercase = defaultMinLowercase,
    int minDigits = defaultMinDigits,
    int minSpecial = defaultMinSpecial,
  }) {
    if (password.isEmpty) return false;
    if (password.trim() != password) return false;
    if (password.length < minLength) return false;

    int uppercase = 0;
    int lowercase = 0;
    int digits = 0;
    int special = 0;

    for (final c in password.runes) {
      final ch = String.fromCharCode(c);
      if (ch.toUpperCase() == ch && ch.toLowerCase() != ch) {
        uppercase++;
      } else if (ch.toLowerCase() == ch && ch.toUpperCase() != ch) {
        lowercase++;
      } else if (RegExp(r'[0-9]').hasMatch(ch)) {
        digits++;
      } else if (specialChars.contains(ch)) {
        special++;
      }
    }

    return uppercase >= minUppercase &&
        lowercase >= minLowercase &&
        digits >= minDigits &&
        special >= minSpecial;
  }

  /// Returns a human-readable error message for invalid passwords.
  static String? getValidationError(
    String password, {
    int minLength = defaultMinLength,
    int minUppercase = defaultMinUppercase,
    int minLowercase = defaultMinLowercase,
    int minDigits = defaultMinDigits,
    int minSpecial = defaultMinSpecial,
  }) {
    if (password.isEmpty) return 'Password is required.';
    if (password.trim() != password) {
      return 'Password must not have leading or trailing spaces.';
    }
    if (password.length < minLength) {
      return 'Password must be at least $minLength characters.';
    }

    int uppercase = 0;
    int lowercase = 0;
    int digits = 0;
    int special = 0;

    for (final c in password.runes) {
      final ch = String.fromCharCode(c);
      if (ch.toUpperCase() == ch && ch.toLowerCase() != ch) {
        uppercase++;
      } else if (ch.toLowerCase() == ch && ch.toUpperCase() != ch) {
        lowercase++;
      } else if (RegExp(r'[0-9]').hasMatch(ch)) {
        digits++;
      } else if (specialChars.contains(ch)) {
        special++;
      }
    }

    final errors = <String>[];
    if (uppercase < minUppercase) {
      errors.add('at least $minUppercase uppercase letter(s)');
    }
    if (lowercase < minLowercase) {
      errors.add('at least $minLowercase lowercase letter(s)');
    }
    if (digits < minDigits) {
      errors.add('at least $minDigits digit(s)');
    }
    if (special < minSpecial) {
      errors.add('at least $minSpecial special character(s) ($specialChars)');
    }

    if (errors.isEmpty) return null;
    return 'Password must contain: ${errors.join('; ')}.';
  }

  /// Callback for use with EmailIdpConfig.passwordValidationFunction.
  /// Serverpod uses Argon2id for hashing (OWASP-recommended).
  static bool passwordValidationFunction(String password) {
    return validate(password);
  }
}
