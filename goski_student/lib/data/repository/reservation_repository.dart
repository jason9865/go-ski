import 'package:get/get.dart';
import 'package:goski_student/data/data_source/reservation_service.dart';
import 'package:goski_student/data/model/instructor.dart';
import 'package:goski_student/data/model/reservation.dart';
import 'package:goski_student/main.dart';

class ReservationRepository {
  final ReservationService reservationService = Get.find();

  Future<List<BeginnerResponse>> getBeginnerLessonTeamInfo(
      ReservationRequest reservationRequest) async {
    return await reservationService
        .getBeginnerLessonTeamInfo(reservationRequest);
  }

  Future<List<Instructor>> getBeginnerInstructorList(
      List<int> instructorsId,
      int studentCount,
      int duration,
      String level,
      int teamId,
      String lessonType) async {
    Map<String, dynamic> beginnerInstListRequest = {
      "instructorsList": instructorsId,
      "studentCount": studentCount,
      "duration": duration,
      "level": level.toUpperCase(),
      "lessonType": lessonType,
    };
    logger.e(beginnerInstListRequest);
    return await reservationService.getBeginnerInstructorList(
        beginnerInstListRequest, teamId);
  }

  Future<List<Instructor>> getAdvancedInstructorList(
      ReservationRequest reservationRequest) async {
    return await reservationService
        .getAdvancedInstructorList(reservationRequest);
  }
}
