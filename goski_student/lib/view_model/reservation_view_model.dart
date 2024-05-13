import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:goski_student/const/enum/gender.dart';
import 'package:goski_student/data/model/certificate_info.dart';
import 'package:goski_student/data/model/instructor.dart';
import 'package:goski_student/data/model/reservation.dart';
import 'package:goski_student/data/repository/reservation_repository.dart';
import 'package:goski_student/ui/reservation/u020_reservation_instructor_list.dart';
import 'package:logger/logger.dart';

final ReservationRepository _reservationRepository = ReservationRepository();

class ReservationViewModel extends GetxController {
  var reservation = ReservationRequest().obs;

  void setTotalStudent(int number) {
    reservation.value.studentCount = number;
  }

  void setLessonDate(String date) {
    reservation.update((val) {
      val?.lessonDate = date;
    });
    // reservation.value.lessonDate = date;
  }

  void setStartTime(String time) {
    reservation.update((val) {
      val?.startTime = time;
    });
  }

  void submitReservation() {
    Logger logger = Logger();
    // Implement submission logic
    logger.d('Reservation Data: ${{
      "resortId": reservation.value.resortId,
      "lessonType": reservation.value.lessonType,
      "studentCount": reservation.value.studentCount,
      "lessonDate": reservation.value.lessonDate,
      "startTime": reservation.value.startTime,
      "duration": reservation.value.duration,
      "level": reservation.value.level.toUpperCase()
    }}');
  }
}

class LessonTeamListViewModel extends GetxController {
  var lessonTeams = <BeginnerResponse>[].obs;

  Future<void> getLessonTeamList(ReservationRequest reservationRequest) async {
    lessonTeams.value = await _reservationRepository
        .getBeginnerLessonTeamInfo(reservationRequest);
    lessonTeams.sort((a, b) => a.cost.compareTo(b.cost));
  }
}

class BeginnerInstructorListViewModel extends GetxController {
  var instructors = <Instructor>[].obs;

  Future<void> getBeginnerInstructorList(
      List<int> instructorsId,
      int studentCount,
      int duration,
      String level,
      int teamId,
      String lessonType) async {
    instructors.value = await _reservationRepository.getBeginnerInstructorList(
        instructorsId, studentCount, duration, level, teamId, lessonType);
  }
}

class LessonInstructorListViewModel extends GetxController {
  var lessonInstructors = <Instructor>[].obs;
  RxList<String> skiCertificate = <String>[].obs;
  RxList<String> boardCertificate = <String>[].obs;

  Future<void> getLessonInstructorList(
      ReservationRequest reservationRequest) async {
    lessonInstructors.value = await _reservationRepository
        .getAdvancedInstructorList(reservationRequest);
    lessonInstructors.sort((a, b) => a.cost.compareTo(b.cost));
  }
}
