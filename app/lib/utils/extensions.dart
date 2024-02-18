import 'package:intl/intl.dart';

extension StringExtensions on String {
  String capitalize() {
    if (isEmpty || length < 2) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension DateExtensions on DateTime {
  String toFormattedString() {
    switch (difference(DateTime.now()).inDays) {
      case 0:
        return DateFormat(DateFormat.HOUR24_MINUTE).format(this);
      case 1:
        return "Yesterday";
      default:
        return DateFormat(DateFormat.DAY).format(this);
    }
  }
}

extension DateExtensions2 on int {
  String toFormattedString() {
    final date = DateTime.fromMillisecondsSinceEpoch(this);
    switch (date.difference(DateTime.now()).inDays) {
      case 0:
        return DateFormat(DateFormat.HOUR24_MINUTE).format(date);
      case 1:
        return "Yesterday";
      default:
        return DateFormat(DateFormat.DAY).format(date);
    }
  }
}
