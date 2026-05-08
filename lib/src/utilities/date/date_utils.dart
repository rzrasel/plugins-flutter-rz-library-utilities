class DateUtils {

  static bool isValid(String? value) {
    if (value == null || value.trim().isEmpty) {
      return false;
    }
    try {
      final date = DateTime.parse(value.trim());
      return true;
    } catch (_) {
      return false;
    }
  }

  static DateTime now() {
    return DateTime.now();
  }

  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
  }

  static bool isToday(DateTime date) {
    return isSameDay(date, DateTime.now());
  }

  static bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday ||
        date.weekday == DateTime.sunday;
  }

  static bool isWeekday(DateTime date) {
    return !isWeekend(date);
  }

  static bool isFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  static bool isPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  static bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) ||
        year % 400 == 0;
  }

  static int getAge(DateTime birthDate) {
    final today = DateTime.now();

    var age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month &&
            today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  static bool isAdult(String? value, {int adultAge = 18}) {
    final error = isValid(value);
    if (error) return error;

    final birthDate = DateTime.parse(value!.trim());
    final age = DateTime.now().difference(birthDate).inDays ~/ 365;
    if (age < adultAge) {
      return false;
    }
    return true;
  }
}