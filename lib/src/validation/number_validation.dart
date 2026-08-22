final class NumberValidation {
  const NumberValidation._();
  static const NumberValidation instance = NumberValidation._();

  /// For TextFormField (String input)
  String? validate(
      String? value, {
        String fieldName = 'This field',
        bool required = true,
        num? min,
        num? max,
        bool isInt = false,
        bool allowNegative = true,
        int? decimalPlaces,
      }) {
    if (min!= null && max!= null) {
      assert(min <= max, 'min must be <= max');
    }

    if (value == null || value.trim().isEmpty) {
      if (!required) return null;
      return '$fieldName is required.';
    }

    final v = value.trim();
    final num? number = num.tryParse(v);

    if (number == null) {
      return isInt
          ? '$fieldName must be a valid integer.'
          : '$fieldName must be a valid number.';
    }

    return _validateNumber(
      number,
      fieldName: fieldName,
      min: min,
      max: max,
      isInt: isInt,
      allowNegative: allowNegative,
      decimalPlaces: decimalPlaces,
    );
  }

  /// For direct num / int / double values
  String? validateNum(
      num? value, {
        String fieldName = 'This field',
        bool required = true,
        num? min,
        num? max,
        bool isInt = false,
        bool allowNegative = true,
        int? decimalPlaces,
      }) {
    if (value == null) {
      if (!required) return null;
      return '$fieldName is required.';
    }

    return _validateNumber(
      value,
      fieldName: fieldName,
      min: min,
      max: max,
      isInt: isInt,
      allowNegative: allowNegative,
      decimalPlaces: decimalPlaces,
    );
  }

  String? _validateNumber(
      num number, {
        required String fieldName,
        num? min,
        num? max,
        required bool isInt,
        required bool allowNegative,
        int? decimalPlaces,
      }) {
    if (isInt && number is! int && number % 1!= 0) {
      return '$fieldName must be an integer.';
    }

    if (!allowNegative && number < 0) {
      return '$fieldName cannot be negative.';
    }

    if (decimalPlaces!= null) {
      final parts = number.toString().split('.');
      if (parts.length == 2 && parts[1].length > decimalPlaces) {
        return '$fieldName can have max $decimalPlaces decimal places.';
      }
    }

    // handle min == max = exact value
    if (min!= null && max!= null && min == max) {
      if (number!= min) {
        return '$fieldName must be exactly $min.';
      }
      return null;
    }

    if (min!= null && number < min) {
      return '$fieldName must be at least $min.';
    }

    if (max!= null && number > max) {
      return '$fieldName must not exceed $max.';
    }

    return null;
  }

  // --- helpers ---
  String? isRequired(String? value, {String fieldName = 'This field'}) {
    return validate(value, fieldName: fieldName);
  }

  String? optional(String? value, {String fieldName = 'This field', num? min, num? max}) {
    return validate(value, fieldName: fieldName, required: false, min: min, max: max);
  }

  String? intOnly(String? value, {String fieldName = 'This field', int? min, int? max}) {
    return validate(value, fieldName: fieldName, isInt: true, min: min, max: max);
  }
}