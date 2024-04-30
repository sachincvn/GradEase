import 'package:intl/intl.dart';

extension DateTimeExtension on String {
  /// Parses the string into a DateTime object assuming it's in ISO 8601 format.
  DateTime parseAsDateTime() {
    return DateTime.parse(this).toLocal();
  }

  /// Formats the DateTime string into a desired format.
  String formatDateTime(String format) {
    try {
      final dateTime = parseAsDateTime();
      final formatter = DateFormat(format);
      return formatter.format(dateTime);
    } catch (e) {
      return this;
    }
  }
}
