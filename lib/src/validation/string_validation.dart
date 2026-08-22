final class StringValidation {

  const StringValidation._();
  static const StringValidation instance = StringValidation._();

  String? validate(
      String? value, {
        String fieldName = 'This field',
        bool required = true,
        int min = 1,
        int max = 255,
        RegExp? pattern,
        String? patternMessage,
        bool trim = true,
      }) {
    assert(min >= 0 && max >= 0 && min <= max, 'min must be <= max');

    if (value == null || (trim ? value.trim().isEmpty : value.isEmpty)) {
      if (!required) return null;
      return '$fieldName is required.';
    }

    final v = trim ? value.trim() : value;
    final isExact = min == max;

    if (isExact) {
      if (v.length != min) {
        return '$fieldName must be exactly $min characters.';
      }
    } else {
      if (v.length < min) {
        return '$fieldName must be at least $min characters.';
      }
      if (v.length > max) {
        return '$fieldName must not exceed $max characters.';
      }
    }

    if (pattern != null && !pattern.hasMatch(v)) {
      return patternMessage ?? '$fieldName format is invalid.';
    }
    return null;
  }

  // --- helpers (optional but useful) ---

  String? isRequired(String? value, {String fieldName = 'This field'}) {
    return validate(value, fieldName: fieldName, min: 1);
  }

  String? notEmpty(String? value, {String fieldName = 'This field'}) {
    return isRequired(value, fieldName: fieldName);
  }

  String? optional(String? value, {String fieldName = 'This field', int max = 255}) {
    return validate(value, fieldName: fieldName, required: false, min: 0, max: max);
  }
}