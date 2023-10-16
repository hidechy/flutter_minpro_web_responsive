import 'package:intl/intl.dart';

///
String convertDateTimeToString({required DateTime dateTime}) {
  return DateFormat.yMd('ja').format(dateTime);
}
