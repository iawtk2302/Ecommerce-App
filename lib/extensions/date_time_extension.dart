import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String formattedDate() {
    final formatter = DateFormat('d MMM, yyyy');
    return formatter.format(this);
  }

  String toTransactionDateTimeFormat() {
    return DateFormat('MMM dd, yyyy | h:mm a').format(this);
  }
}
