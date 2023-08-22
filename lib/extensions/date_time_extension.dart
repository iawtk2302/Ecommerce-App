import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String formattedDate() {
    final formatter = DateFormat('d MMM, yyyy');
    return formatter.format(this);
  }

  String formattedDateChat() {
    final formatter = DateFormat('h:mm a');
    return formatter.format(this);
  }
}
