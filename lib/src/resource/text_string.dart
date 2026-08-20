class TextString {
  // prevents instantiation
  const TextString._();
  static const commonText = CommonText._();
  static const authText = AuthenticationText._();
}

class CommonText {
  // prevents instantiation
  const CommonText._();
  final String submit = "Submit";
}
class AuthenticationText {
  // prevents instantiation
  const AuthenticationText._();
  final String firstName = "First Name";
  final String lastName = "Last Name";
  final String email = "E-Mail";
  final String resendEmail = "Resend E-Mail";
  final String password = "Password";
  final String newPassword = "New Password";
  final String userName = "User Name";
  final String mobileNo = "Mobile Number";
  final String rememberMe = "Remember Me";
  final String forgetPassword = "Forget Password";
  final String signIn = "Sign In";
  final String createAccount = "Create Account";
  final String orSignInWith = "or sign in with";
  final String orSignUpWith = "or sign up with";
  final String iAgreeTo = "I agree to";
  final String privacyPolicy = "Privacy Policy";
  final String termsOfUse = "Terms of Use";
  final String loginTitle = "Welcome back,";
  final String loginSubtitle = "Discover Limitless Choices and Unmatched Convenience.";
  final String signUpTitle = "Let's create your account";
  final String forgetPasswordTitle = "Forget password";
  final String forgetPasswordSubtitle = "Don't worry sometimes people forget too, enter your email and";
  final String changeYourPasswordTitle = "Change Your Password";
  final String changeYourPasswordSubtitle = "Change Your Password";
  final String done = "Done";
}