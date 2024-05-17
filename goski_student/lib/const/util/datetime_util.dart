import 'package:easy_localization/easy_localization.dart';

class DateTimeUtil {
  static final DateTimeUtil _instance = DateTimeUtil();

  factory DateTimeUtil() {
    return _instance;
  }

  /// 2024/04/29(월) 07:07 형식으로 반환
  static String getDateTime(DateTime dateTime) {
    String dayOfWeek = DateFormat('E', 'ko_KR').format(dateTime).toString();
    return '${dateTime.year}/${dateTime.month.toTimeString()}/${dateTime.day.toTimeString()}($dayOfWeek) ${dateTime.hour.toTimeString()}:${dateTime.minute.toTimeString()}';
  }

  /// 2024/04/29(월) 07:07 형식으로 반환
  static String getDateTimeNow() {
    DateTime dateTime = DateTime.now();
    String dayOfWeek = DateFormat('E', 'ko_KR').format(dateTime).toString();
    return '${dateTime.year}/${dateTime.month.toTimeString()}/${dateTime.day.toTimeString()}($dayOfWeek) ${dateTime.hour.toTimeString()}:${dateTime.minute.toTimeString()}';
  }
}

extension IntToTimeString on int {
  String toTimeString() {
    return toString().padLeft(2, '0');
  }
}