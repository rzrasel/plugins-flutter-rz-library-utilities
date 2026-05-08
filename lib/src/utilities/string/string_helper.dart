import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StringHelper {

  const StringHelper._();
  const StringHelper._internal();

  static String truncateText(String text, int maxLength) {
    if(text.length <= maxLength) {
      return text;
    } else {
      return "${text.substring(0, maxLength)}...";
    }
  }

  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat("dd-MM-yyyy").format(date);
  }

  static String getFormattedDate(DateTime date, {String format = "yyyy-MM-dd"}) {
    return DateFormat(format).format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: "en_US", symbol: "\$").format(amount);
  }

  static String formatPhoneNumber(String phoneNumber) {
    if(phoneNumber.length == 10) {
      return "(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}";
    } else if(phoneNumber.length == 11) {
      return "(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}";
    }
    return phoneNumber;
  }

  static String internationalFormatPhoneNumber(String phoneNumber) {

    // Remove any non-digit characters
    var digitOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Extract country code
    String countryCode = "+${digitOnly.substring(0, 2)}";
    digitOnly = digitOnly.substring(2);

    // Format remaining number
    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode) ');

    int i = 0;

    while (i < digitOnly.length) {

      int groupLength = 2;

      if (i == 0 && countryCode == '+1') {
        groupLength = 3;
      }

      int end = i + groupLength;

      if (end > digitOnly.length) {
        end = digitOnly.length;
      }

      formattedNumber.write(digitOnly.substring(i, end));

      if (end < digitOnly.length) {
        formattedNumber.write(' ');
      }

      i = end;
    }

    return formattedNumber.toString();
  }
}