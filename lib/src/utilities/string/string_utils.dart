//part of 'validation.dart';

class StringUtils {
  const StringUtils._();
  const StringUtils._internal();
  static const StringUtils instance = StringUtils._internal();

  // MySQL escape
  static String? toEscapeString(String? value) {
    if (value == null) return null;
    return value
        .replaceAll(r'\', r'\\')
        .replaceAll('\x00', r'\0')
        .replaceAll('\n', r'\n')
        .replaceAll('\r', r'\r')
        .replaceAll('\x1A', r'\Z')
        .replaceAll("'", r"\'")
        .replaceAll('"', r'\"');
  }

  static String? toCollapseWhitespace(String? value, {bool strip = true}) {
    if (value == null) return null;
    var collapsed = value.replaceAll(RegExp(r'\s+'), ' ');
    return strip? collapsed.trim() : collapsed;
  }

  static String? toNormalizeWhitespace(String? value) => toCollapseWhitespace(value, strip: true);
  static String? toSquish(String? value) => toCollapseWhitespace(value, strip: true);
  static String? toStripWhitespace(String? value) => toCollapseWhitespace(value, strip: true);

  static String? toSlug(String? value, {bool lower = true, bool allowUnicode = true}) {
    if (value == null) return null;
    var v = value.trim();
    if (v.isEmpty) return "";

    if (!allowUnicode) {
      // remove non-ascii
      v = v.replaceAll(RegExp(r'[^\x00-\x7F]'), '');
    }

    if (lower) v = v.toLowerCase();

    v = v.replaceAll(RegExp(r'[^\w\s-]'), ''); // remove special
    v = v.replaceAll(RegExp(r'[\s_]+'), '-'); // space/_ -> -
    v = v.replaceAll(RegExp(r'-{2,}'), '-'); // --- -> -
    return v.replaceAll(RegExp(r'^-|-$'), '');
  }

  // stub - plug your translator
  static String? toSlugTranslation(String? value, {bool lower = true, bool allowUnicode = true, String toLanguage = 'en'}) {
    if (value == null) return null;
    // TODO: integrate your LanguageTranslator here
    // text = LanguageTranslator().translateTo(value, toLanguage)
    return toSlug(value, lower: lower, allowUnicode: allowUnicode);
  }

  static bool isEmpty(dynamic value) {
    if (value == null) return true;
    if (value is String) return value.trim().isEmpty;
    if (value is List || value is Map || value is Set) return value.isEmpty;
    return false;
  }

  static bool isNull(dynamic value) => value == null;

  static bool isAllEmpty(Iterable<dynamic> values) => values.every((v) => isEmpty(v));
  static bool isAnyEmpty(Iterable<dynamic> values) => values.any((v) => isEmpty(v));

  static bool parseBool(dynamic value, {bool defaultValue = false}) {
    const trueSet = {'true', '1', 't', 'yes', 'y', 'on'};
    const falseSet = {'false', '0', 'f', 'no', 'n', 'off', ''};

    if (value == null) return defaultValue;
    if (value is bool) return value;
    if (value is int) {
      if (value == 1) return true;
      if (value == 0) return false;
      return defaultValue;
    }
    if (value is String) {
      final v = value.trim().toLowerCase();
      if (trueSet.contains(v)) return true;
      if (falseSet.contains(v)) return false;
      return defaultValue;
    }
    return value.toString().isNotEmpty? true : defaultValue;
  }

  static bool getBool(dynamic value) {
    if (value is String) return value.trim().toLowerCase() == 'true';
    if (value is bool) return value;
    return false;
  }
}