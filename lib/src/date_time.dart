import 'package:intl/intl.dart';

extension DateTimeHelper on DateTime {
  /// Returns a String representation with the date, time, and timezone.
  ///
  /// Will be in the local timezone in 12-hour format.
  ///
  /// Example: `2020-01-01 12:00 PM EST`
  String getDateTimeString() {
    final localDateTime = toLocal();
    final dateString = DateFormat('yyyy-MM-dd').format(localDateTime);
    final timeString = DateFormat('hh:mm a').format(localDateTime);
    final timezoneString = localDateTime.timeZoneName;
    return '$dateString $timeString $timezoneString';
  }
}
