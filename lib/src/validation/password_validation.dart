class PasswordValidation {

  const PasswordValidation._();
  const PasswordValidation._internal();
  static const PasswordValidation instance = PasswordValidation._internal();

  static const int minLength = 8;
  static const int maxLength = 128;

  static final RegExp _uppercase = RegExp(r'[A-Z]');
  static final RegExp _lowercase = RegExp(r'[a-z]');
  static final RegExp _digit = RegExp(r'\d');
  static final RegExp _special = RegExp(r'''[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>/?`~]''');

  String? _isValid(
      String? value, {
        int minLength = PasswordValidation.minLength,
        int maxLength = PasswordValidation.maxLength,
        bool requireUppercase = true,
        bool requireLowercase = true,
        bool requireDigit = true,
        bool requireSpecial = true,
      }) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters.';
    }

    if (value.length > maxLength) {
      return 'Password must not exceed $maxLength characters.';
    }

    if (requireUppercase && !_uppercase.hasMatch(value)) {
      return 'Password must include at least one uppercase letter.';
    }

    if (requireLowercase && !_lowercase.hasMatch(value)) {
      return 'Password must include at least one lowercase letter.';
    }

    if (requireDigit && !_digit.hasMatch(value)) {
      return 'Password must include at least one digit.';
    }

    if (requireSpecial && !_special.hasMatch(value)) {
      return 'Password must include at least one special character.';
    }

    return null;
  }

  String? validate(
      String? value, {
        int minLength = PasswordValidation.minLength,
        int maxLength = PasswordValidation.maxLength,
        bool requireUppercase = true,
        bool requireLowercase = true,
        bool requireDigit = true,
        bool requireSpecial = true,
      }) {
    assert(minLength >= 0 && maxLength >= 0 && minLength <= maxLength, 'min length must be <= max length');

    return _isValid(
      value,
      minLength: minLength,
      maxLength: maxLength,
      requireUppercase: requireUppercase,
      requireLowercase: requireLowercase,
      requireDigit: requireDigit,
      requireSpecial: requireSpecial,
    );
  }
}