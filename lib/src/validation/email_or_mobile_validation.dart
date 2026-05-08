import 'email_validation.dart';
import 'mobile_validation.dart';

class EmailOrMobileValidation {

  const EmailOrMobileValidation._();
  const EmailOrMobileValidation._internal();
  static const EmailOrMobileValidation instance =
  EmailOrMobileValidation._internal();

  static const EmailValidation _email = EmailValidation.instance;
  static const MobileValidation _mobile = MobileValidation.instance;

  String? isEmail(String? value) {
    return _email.validate(value);
  }

  String? isMobile(String? value) {
    return _mobile.validate(value);
  }

  String? _isValid(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email or mobile number is required.';
    }

    value = value.trim();
    if (value.isEmpty) return 'Email or mobile number is required.';

    final emailError = _email.validate(value);
    final mobileError = _mobile.validate(value);

    // valid if either one is valid (null)
    if (emailError == null || mobileError == null) {
      return null;
    }

    return 'Enter a valid email or mobile number.';
  }

  String? validate(String? value) => _isValid(value);
}