import 'package:intl/intl.dart';

// DateTime 객체를 "YYYY-MM-DD" String으로 변환
String dateTimeToString(DateTime dateTime) {
  DateFormat format = DateFormat('yyyy-MM-dd');
  return format.format(dateTime);
}

String phoneNumberParser(String phoneNumber) {
  return '${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3, 7)}-${phoneNumber.substring(7)}';
}
