import 'package:get/get.dart';
import 'package:goski_student/data/model/reservation.dart';
import 'package:logger/logger.dart';

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

  Map<String, dynamic> ReservationRequestToJson() {
    return {
      "resortId": reservation.value.resortId,
      "lessonType": reservation.value.lessonType,
      "studentCount": reservation.value.studentCount,
      "lessonDate": reservation.value.lessonDate,
      "startTime": reservation.value.startTime,
      "duration": reservation.value.duration,
      "level": reservation.value.level.toUpperCase()
    };
  }
}
