import 'package:intl/intl.dart';

extension DateFormate on DateTime {
  String format({String pattern = 'yyyy-MM-dd'}) {
    if (this == null) {
      return '';
    }
    final DateFormat formatter = DateFormat(pattern);

    return formatter.format(this);
  }
}
String formatDate(String apiDate) => DateFormat('hh:mm a, dd MMM yyyy').format(DateTime.parse(apiDate).toLocal());
