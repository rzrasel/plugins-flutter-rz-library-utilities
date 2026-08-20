class ConfirmPasswordValidation {

  const ConfirmPasswordValidation._();
  const ConfirmPasswordValidation._internal();
  static const ConfirmPasswordValidation instance = ConfirmPasswordValidation._internal();

  String? validate(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Confirm password is required";
    }
    if (password != confirmPassword) {
      return "Password and confirm password do not match";
    }
    return null;
  }

  bool isValid(String? password, String? confirmPassword) {
    return validate(password, confirmPassword) == null;
  }
}