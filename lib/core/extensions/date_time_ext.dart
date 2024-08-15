import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String toFormattedString(String format) {
    final formatter = DateFormat(format);
    return formatter.format(this);
  }

  String toRelativeFormat() {
    final now = DateTime.now();
    final difference = now.difference(this).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference == -1) {
      return 'Tomorrow';
    } else if (difference > 365) {
      return 'Years ago';
    } else if (difference > 1) {
      return '$difference days ago';
    } else if (difference < -1) {
      return 'in ${-difference} days';
    } else {
      return DateFormat('yyyy-MM-dd').format(this);
    }
  }

  String toTimeFormat() {
    final timePart = DateFormat('h:mm a').format(this);
    return timePart;
  }

  String toRetativeFomatWithTime() {
    return "${toRelativeFormat()}, ${toTimeFormat()}";
  }
}
