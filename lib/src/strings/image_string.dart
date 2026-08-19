class ImageString {
  // prevents instantiation
  const ImageString._();
  static const assetImage = AssetImage._();
}

class AssetImage {
  // prevents instantiation
  const AssetImage._();
  /// App logo
  final String darkAppLogo = 'assets/images/profile-1.png';
  final String lightAppLogo = 'assets/images/profile-1.png';
  final String profileImage = 'assets/images/profile-1.png';
  /// Social logo
  final String google = 'assets/images/profile-1.png';
  final String facebook = 'assets/images/profile-1.png';
  // -- Animations
  final String deliveredEmailIllustration = 'assets/images/profile-1.png';
  final String uploadImageIllustration = 'assets/images/profile-1.png';
  final String verifyIllustration = 'assets/images/profile-1.png';
}