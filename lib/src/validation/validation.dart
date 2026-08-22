import 'confirm_password_validation.dart';
import 'date_validation.dart';
import 'email_dns_validation.dart';
import 'email_or_mobile_validation.dart';
import 'email_validation.dart';
import 'mobile_validation.dart';
import 'number_validation.dart';
import 'password_validation.dart';
import 'string_validation.dart';
import 'username_validation.dart';

class Validation {
  // prevents instantiation
  const Validation._();
  // const Validation._internal();
  //
  static const DateValidation date = DateValidation.instance;
  static const EmailDnsValidation emailDns = EmailDnsValidation.instance;
  static const EmailOrMobileValidation emailOrMobile = EmailOrMobileValidation.instance;
  static const EmailValidation email = EmailValidation.instance;
  static const MobileValidation mobile = MobileValidation.instance;
  static const NumberValidation number = NumberValidation.instance;
  static const PasswordValidation password = PasswordValidation.instance;
  static const ConfirmPasswordValidation confirmPassword = ConfirmPasswordValidation.instance;
  static const StringValidation string = StringValidation.instance;
  static const UsernameValidation username = UsernameValidation.instance;

  static String? validateEmptyText(String? fieldName, String? value) {
    if(value == null || value.isEmpty) {
      return "$fieldName is required.";
    }
    return null;
  }
}