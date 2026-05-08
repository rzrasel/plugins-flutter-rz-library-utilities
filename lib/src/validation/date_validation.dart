import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:dns_client/dns_client.dart';

class DateValidation {

  const DateValidation._();
  const DateValidation._internal();
  static const DateValidation instance = DateValidation._internal();

  // ---------------- BASIC ----------------
  String? isValid(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Date is required.';
    }

    if (DateTime.tryParse(value.trim()) == null) {
      return 'Invalid date.';
    }

    return null;
  }

  String? validate(String? value) => isValid(value);

  DateTime? parse(String? value) {
    if (value == null) return null;
    return DateTime.tryParse(value.trim());
  }

  DateTime? parseFormat(String? value, {String format = "yyyy-MM-dd"}) {
    if (value == null || value.trim().isEmpty) return null;
    try {
      return DateFormat(format).parseStrict(value.trim());
    } catch (_) {
      return null;
    }
  }

  String? isValidFormat(String? value, {String format = 'yyyy-MM-dd'}) {
    if (value == null || value.trim().isEmpty) {
      return 'Date is required.';
    }

    if (parseFormat(value, format: format) == null) {
      return 'Invalid date format.';
    }

    return null;
  }

  String? formatDate(DateTime? date, {String format = "yyyy-MM-dd"}) {
    if (date == null) return null;
    return DateFormat(format).format(date);
  }

  // ---------------- LOGIC ----------------
  String? isFuture(DateTime? date) {
    if (date == null) {
      return 'Date is required.';
    }

    if (!date.isAfter(DateTime.now())) {
      return 'Date must be in the future.';
    }

    return null;
  }

  String? isPast(DateTime? date) {
    if (date == null) {
      return 'Date is required.';
    }

    if (!date.isBefore(DateTime.now())) {
      return 'Date must be in the past.';
    }

    return null;
  }

  String? isToday(DateTime? date) {
    if (date == null) {
      return 'Date is required.';
    }

    final now = DateTime.now();

    if (date.year != now.year ||
        date.month != now.month ||
        date.day != now.day) {
      return 'Date must be today.';
    }

    return null;
  }

  String? isLeapYear(int year) {
    if ((year % 4 == 0 && year % 100 != 0) ||
        (year % 400 == 0)) {
      return null;
    }

    return 'Year must be a leap year.';
  }

  String? isLeapYearDate(DateTime? date) {
    if (date == null) {
      return 'Date is required.';
    }

    if (isLeapYear(date.year) != null) {
      return 'Date must be in a leap year.';
    }

    return null;
  }

  String? isWeekend(DateTime? date) {
    if (date == null) {
      return 'Date is required.';
    }

    if (date.weekday != DateTime.saturday &&
        date.weekday != DateTime.sunday) {
      return 'Date must be a weekend.';
    }

    return null;
  }

  String? isWeekday(DateTime? date) {
    if (date == null) {
      return 'Date is required.';
    }

    if (date.weekday == DateTime.saturday ||
        date.weekday == DateTime.sunday) {
      return 'Date must be a weekday.';
    }

    return null;
  }

  int? getAge(DateTime? birthDate) {
    if (birthDate == null) return null;
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  String? isAdult(DateTime? birthDate, {int adultAge = 18}) {
    final age = getAge(birthDate);

    if (age == null) {
      return 'Birth date is required.';
    }

    if (age < adultAge) {
      return 'You must be at least $adultAge years old.';
    }

    return null;
  }

  String? isBetween(DateTime? date, DateTime start, DateTime end) {
    if (date == null) {
      return 'Date is required.';
    }

    if (!date.isAfter(start) || !date.isBefore(end)) {
      return 'Date must be between the start and end dates.';
    }

    return null;
  }

  String? isSameDay(DateTime? before, DateTime? after) {
    if (after == null || before == null) {
      return 'Date is required.';
    }

    if (after.year != before.year ||
        after.month != before.month ||
        after.day != before.day) {
      return 'Dates must be the same day.';
    }

    return null;
  }

  String? validator(String? value, {String format = 'yyyy-MM-dd', bool required = true}) {
    if (required && (value == null || value.trim().isEmpty)) {
      return 'Date is required.';
    }

    if (value != null &&
        value.trim().isNotEmpty &&
        isValidFormat(value, format: format) != null) {
      return 'Invalid date format ($format).';
    }

    return null;
  }
}