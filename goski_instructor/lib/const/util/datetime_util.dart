import 'package:easy_localization/easy_localization.dart';

class DateTimeUtil {
  static final DateTimeUtil _instance = DateTimeUtil();

  factory DateTimeUtil() {
    return _instance;
  }

  /// 2024/04/29(월) 17:37 형식으로 반환
  static String getDateTime() {
    DateTime dateTime = DateTime.now();
    String dayOfWeek = DateFormat('E', 'ko_KR').format(dateTime).toString();
    return '${dateTime.year}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')}($dayOfWeek) ${dateTime.hour}:${dateTime.minute}';
  }
}
