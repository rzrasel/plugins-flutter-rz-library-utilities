
class UsernameValidation {

  const UsernameValidation._();
  static const UsernameValidation instance = UsernameValidation._();
  /*const UsernameValidation._internal();
  static const UsernameValidation instance = UsernameValidation._internal();*/

  String? _isValid(String? value, {int min = 4, int max = 254}) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required.';
    }

    value = value.trim();

    if (value.length < min) {
      return 'Username must be at least $min characters.';
    }

    if (value.length > max) {
      return 'Username must not exceed $max characters.';
    }

    //const pattern = r"^[a-zA-Z0-9_.-]{3, 256}$";
    //final pattern = "^[a-zA-Z0-9_.-]{$min,$max}\$";
    final pattern = r"^[a-zA-Z0-9_.-]{" + min.toString() + r"," + max.toString() + r"}$";

    final regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return 'Username can only contain letters, numbers, _, . and - ($min-$max chars).';
    }

    if (value.startsWith("_") || value.startsWith("-") || value.endsWith("_") || value.endsWith("-")) {
      return 'Username cannot start or end with _ or -.';
    }

    return null;
  }

  String? validate(String? value, {int min = 4, int max = 254}) {
    return _isValid(value, min: min, max: max);
  }
}