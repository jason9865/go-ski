import 'package:intl/intl.dart';

// DateTime 객체를 "YYYY-MM-DD" String으로 변환
String dateTimeToString(DateTime dateTime) {
  DateFormat format = DateFormat('yyyy-MM-dd');
  return format.format(dateTime);
}

// 01012341234 to 010-1234-1234
String phoneNumberParser(String phoneNumber) {
  return '${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3, 7)}-${phoneNumber.substring(7)}';
}

DateTime stringToDateTime(String birthdate) {
  // Check if the string is exactly 8 characters long, which is valid for `yyyyMMdd`
  if (birthdate.length != 8) {
    throw const FormatException(
        "The date must be in yyyyMMdd format and exactly 8 characters long.");
  }

  // Insert dashes to conform to the `DateTime.parse` expected format `yyyy-MM-dd`
  String formattedDate =
      "${birthdate.substring(0, 4)}-${birthdate.substring(4, 6)}-${birthdate.substring(6)}";

  // Now, parse the formatted date string to a DateTime object
  try {
    return DateTime.parse(formattedDate);
  } on FormatException catch (e) {
    throw FormatException("Invalid date format: ${e.message}");
  }
}
