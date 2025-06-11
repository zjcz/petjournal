import 'package:intl/intl.dart';

class DateHelper {
  static const String dateFormat = 'dd MMMM yyyy';

  static String formatDate(DateTime date) {
    return DateFormat(dateFormat).format(date);
  }

  static DateTime? parseDate(String date) {
    return DateFormat(dateFormat).tryParse(date);
  }

  /// Get today's date, minus the time segment
  static DateTime getToday() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  // Remove the time component from the dateTime object
  static DateTime removeTime(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  // Format the difference between 2 dates.  If the difference is 1 year or over, return "X Years", otherwise return "X Months", or "X Days"
  static String formatDifference(
    DateTime startDate, {
    DateTime? endDate,
    bool showMonthsWithYears = false,
  }) {
    endDate ??= DateTime.now();
    Duration difference = endDate.difference(startDate);

    if (difference.isNegative) {
      return '0 Days';
    }

    int years = difference.inDays ~/ 365;
    int months = difference.inDays ~/ 30;
    int days = difference.inDays;

    String ret = '';
    if (years > 0) {
      ret = '$years Year${years == 1 ? '' : 's'}';
      if (showMonthsWithYears) {
        int remainingMonths = months - (years * 12);
        ret += ', $remainingMonths Month${remainingMonths == 1 ? '' : 's'}';
      }
    } else if (months > 0) {
      ret = '$months Month${months == 1 ? '' : 's'}';
    } else {
      ret = '$days Day${days == 1 ? '' : 's'}';
    }

    return ret;
  }
}
