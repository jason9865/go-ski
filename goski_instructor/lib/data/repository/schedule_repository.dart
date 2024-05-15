import 'package:get/get.dart';
import 'package:goski_instructor/data/data_source/schedule_service.dart';
import 'package:goski_instructor/data/model/schedule.dart';
import 'package:goski_instructor/data/model/student_info.dart';
import 'package:goski_instructor/main.dart';

class ScheduleRepository {
  final ScheduleService scheduleService = Get.find();

  Future<List<Schedule>?> getScheduleList() async {
    var response = await scheduleService.fetchScheduleList();
    if (response != null) {
      List<Schedule> scheduleList = List<Schedule>.from(response.map((item) {
        return item.toSchedule();
      }));
      return scheduleList;
    }
    return null;
  }
}
