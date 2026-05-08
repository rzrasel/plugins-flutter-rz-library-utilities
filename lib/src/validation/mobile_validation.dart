class MobileValidation {

  const MobileValidation._();
  const MobileValidation._internal();
  static const MobileValidation instance = MobileValidation._internal();

  static const int minLength = 7;
  static const int maxLength = 15;

  static final RegExp _pattern = RegExp(r'^\+?[\d\s().-]+$');
  static final RegExp _digitsOnly = RegExp(r'^\d+$');
  static final RegExp _nonDigit = RegExp(r'\D');

  static const Set<String> countryCodes = {
    '1','7','20','27','30','31','32','33','34','36','39','40','41','43','44','45','46','47','48','49',
    '51','52','53','54','55','56','57','58','60','61','62','63','64','65','66','81','82','84','86',
    '90','91','92','93','94','95','98','212','213','216','218','220','221','222','223','224','225',
    '226','227','228','229','230','231','232','233','234','235','236','237','238','239','240','241',
    '242','243','244','245','246','247','248','249','250','251','252','253','254','255','256','257',
    '258','260','261','262','263','264','265','266','267','268','269','290','291','297','298','299',
    '350','351','352','353','354','355','356','357','358','359','370','371','372','373','374','375',
    '376','377','378','380','381','382','383','385','386','387','389','420','421','423','500','501',
    '502','503','504','505','506','507','508','509','590','591','592','593','594','595','596','597',
    '598','599','670','672','673','674','675','676','677','678','679','680','681','682','683','685',
    '686','687','688','689','690','691','692','850','852','853','855','856','880','886','960','961',
    '962','963','964','965','966','967','968','970','971','972','973','974','975','976','977','992',
    '993','994','995','996','998'
  };
  static final List<String> sortedCodes = [...countryCodes]..sort((a,b) => b.length.compareTo(a.length));

  String? hasCountryCode(String? mobile) {
    if (mobile == null || mobile.trim().isEmpty) {
      return 'Mobile number is required.';
    }

    var cleaned = mobile.trim().replaceAll(' ', '').replaceAll('-', '').replaceAll('(', '').replaceAll(')', '');
    bool hasPlus = false;

    if (cleaned.startsWith('+')) {
      cleaned = cleaned.substring(1);
      hasPlus = true;
    } else if (cleaned.startsWith('00')) {
      cleaned = cleaned.substring(2);
      hasPlus = true;
    }

    if (!_digitsOnly.hasMatch(cleaned)) {
      return 'Mobile number must contain only digits.';
    }

    if (hasPlus) {
      for (final code in sortedCodes) {
        if (cleaned.startsWith(code)) {
          final national = cleaned.substring(code.length);
          if (national.length >= 4 && national.length <= 15) {
            if (national.startsWith('0') && code != '39') continue;
            return null; // valid
          }
        }
      }
      return 'Invalid country code.';
    }

    if (cleaned.startsWith('0')) {
      return 'Country code is required. Example: +1, +88';
    }

    if (cleaned.length < 8) {
      return 'Mobile number is too short.';
    }

    for (final code in sortedCodes) {
      if (cleaned.startsWith(code)) {
        final national = cleaned.substring(code.length);
        if (national.length >= 4 && national.length <= 15) {
          return null; // valid
        }
      }
    }

    return 'Invalid country code or number.';
  }

  String? _isValid(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Mobile number is required.';
    }

    value = value.trim();
    if (value.isEmpty) {
      return 'Mobile number is required.';
    }

    if (!_pattern.hasMatch(value)) {
      return 'Invalid mobile number format.';
    }

    final digits = value.replaceAll(_nonDigit, '');

    if (digits.length < minLength) {
      return 'Mobile number is too short.';
    }

    if (digits.length > maxLength) {
      return 'Mobile number is too long.';
    }

    return null;
  }

  String? validate(String? value) => _isValid(value);

  String? normalizeAndConvert(String? mobile) {
    if (mobile == null || mobile.isEmpty) return null;
    var cleaned = mobile.trim().replaceAll(' ', '').replaceAll('-', '').replaceAll('(', '').replaceAll(')', '');
    if (cleaned.startsWith('00')) cleaned = '+${cleaned.substring(2)}';
    if (!cleaned.startsWith('+')) {
      if (hasCountryCode(cleaned) == null) {
        cleaned = '+$cleaned';
      } else {
        return null;
      }
    }
    final digits = cleaned.substring(1);
    if (!_digitsOnly.hasMatch(digits)) return null;
    for (final code in sortedCodes) {
      if (digits.startsWith(code)) {
        var national = digits.substring(code.length);
        if (national.startsWith('0') && code != '39') {
          national = national.replaceAll(RegExp(r'^0+'), '');
        }
        return '+$code$national';
      }
    }
    return null;
  }
}

/*
Usages:

Validation.mobile.validate("+8801712345678"); // true
Validation.mobile.hasCountryCode("8801712345678"); // true
Validation.mobile.normalizeAndConvert("008801712345678"); // +8801712345678
Validation.mobile.normalizeAndConvert("01712345678"); // null

RzMobileValidation().validate("..."); // ❌ blocked - no public constructor
*/