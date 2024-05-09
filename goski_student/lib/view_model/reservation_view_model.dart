import 'package:get/get.dart';
import 'package:goski_student/data/model/reservation.dart';
import 'package:goski_student/data/repository/reservation_repository.dart';
import 'package:logger/logger.dart';

final ReservationRepository _reservationRepository = ReservationRepository();

class ReservationViewModel extends GetxController {
  var reservation = ReservationRequest().obs;

  void setTotalStudent(int number) {
    reservation.value.studentCount = number;
  }

  void setLessonDate(String date) {
    reservation.value.lessonDate = date;
  }

  void setStartTime(String time) {
    reservation.value.startTime = time;
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
    logger.w("뭐 뭐 뭐 뭐적으라고");
    lessonTeams.value = await _reservationRepository
        .getBeginnerLessonTeamInfo(reservationRequest);
    lessonTeams.value.sort((a, b) => a.cost.compareTo(b.cost));
  }
}
