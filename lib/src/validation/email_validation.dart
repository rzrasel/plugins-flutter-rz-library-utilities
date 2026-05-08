import 'dart:io';
import 'package:flutter/foundation.dart';

class EmailValidation {

  const EmailValidation._();
  const EmailValidation._internal();
  static const EmailValidation instance = EmailValidation._internal();

  Future<String?> _hasValidDns(String? value) async {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required.';
    }

    if (kIsWeb) return null;

    final domain = value.trim().split('@').last;

    try {
      final result = await InternetAddress.lookup(domain);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return null;
      }
      return 'Domain does not exist.';
    } on SocketException {
      return 'Domain does not exist.';
    } catch (_) {
      return 'Domain does not exist.';
    }
  }

  String? _isValid(String? value, {int min = 4, int max = 254}) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required.';
    }

    value = value.trim();
    if (value.isEmpty) {
      return 'Email is required.';
    }

    if (value.length < min) {
      return 'Email must be at least $min characters.';
    }

    if (value.length > max) {
      return 'Email must not exceed $max characters.';
    }

    const pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
        r"[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$";
    final regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return 'Invalid email format.';
    }

    return null;
  }

  String? validate(String? value, {int min = 4, int max = 254}) {
    return _isValid(value, min: min, max: max);
  }

  Future<String?> validateWithDns(String? value, {int min = 4, int max = 254}) async {
    final basicError = _isValid(value, min: min, max: max);
    if (basicError != null) return basicError;

    if (value == null) return 'Email is required.';
    final dnsError = await _hasValidDns(value);
    if (dnsError != null) return dnsError;

    return null;
  }

  Future<String?> isValidWithDns(String? value, {int min = 4, int max = 254}) {
    return validateWithDns(value, min: min, max: max);
  }
}

/*
Usages:

// 1. Only format check (fast, offline)
Validation.email.validate("test@gmail.com"); // true

// 2. Format + DNS check (needs internet)
bool ok = await Validation.email.validateWithDns("test@gmail.com");
bool ok2 = await EmailValidation.instance.validateWithDns("test@fake-domain-xyz123.com"); // false
*/