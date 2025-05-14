import 'package:intl/intl.dart';

String dateTime2String(DateTime time) {
  return DateFormat("dd.MM.yyyy HH:mm").format(time);
}
