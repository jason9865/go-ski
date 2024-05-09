import 'package:get/get.dart';
import 'package:goski_student/data/data_source/reservation_service.dart';
import 'package:goski_student/data/model/instructor.dart';
import 'package:goski_student/data/model/reservation.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

class ReservationRepository {
  final ReservationService reservationService = Get.find();

  Future<List<BeginnerResponse>> getBeginnerLessonTeamInfo(
      ReservationRequest reservationRequest) async {
    return await reservationService
        .getBeginnerLessonTeamInfo(reservationRequest);
  }

  Future<List<Instructor>> getBeginnerInstructorList(List<int> instructorsId,
      int studentCount, int duration, String level, int teamId) async {
    Map<String, dynamic> beginnerInstListRequest = {
      "instructorsList": instructorsId,
      "studentCount": studentCount,
      "duration": duration,
      "level": level.toUpperCase()
    };
    logger.e(beginnerInstListRequest);
    return await reservationService.getBeginnerInstructorList(
        beginnerInstListRequest, teamId);
  }
}
