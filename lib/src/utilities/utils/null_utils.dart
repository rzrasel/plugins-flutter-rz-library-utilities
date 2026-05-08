class NullUtils {
  // Private constructor to prevent instantiation - it's a utility class
  NullUtils._();

  static const Set<String> _nullStrings = {'', 'null', 'Null', 'NULL'};

  /// Checks if data is null / empty / null-like string
  static bool isNull(dynamic data) {
    if (data == null) return true;
    if (data is String) return _nullStrings.contains(data.trim());
    if (data is Map) return data.isEmpty;
    if (data is Iterable) return data.isEmpty;
    return false;
  }

  /// Returns null if data is null-like, otherwise returns original data
  static dynamic setNull(dynamic data) {
    return isNull(data) ? null : data;
  }

  /// Returns "NA" if data is null-like, otherwise returns string value
  static String setNA(dynamic data) {
    if (isNull(data)) return "NA";
    return data.toString();
  }
}