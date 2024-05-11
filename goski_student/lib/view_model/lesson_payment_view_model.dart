import 'package:get/get.dart';
import 'package:goski_student/data/model/reservation.dart';
import 'package:goski_student/data/model/student_info.dart';
import 'package:goski_student/data/repository/lesson_payment_repository.dart';

class LessonPaymentViewModel {
  final lessonPaymentRepository = Get.find<LessonPaymentRepository>();

  Future<void> teamLessonPayment(
      ReservationRequest reservationRequest,
      BeginnerResponse beginnerResponse,
      List<StudentInfo> studentInfo,
      String requestComplain) async {
    await lessonPaymentRepository.teamLessonPayment(
        reservationRequest, beginnerResponse, studentInfo, requestComplain);
  }
}
