import 'package:easy_localization/easy_localization.dart';

String weekdayToString(int weekday) {
  return weekday == 1
      ? tr('Monday')
      : weekday == 2
          ? tr('Tuesday')
          : weekday == 3
              ? tr('Wednesday')
              : weekday == 4
                  ? tr('Thursday')
                  : weekday == 5
                      ? tr('Friday')
                      : weekday == 6
                          ? tr('Saturday')
                          : tr('Sunday');
}
