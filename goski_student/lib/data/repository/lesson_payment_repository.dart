import 'package:get/get.dart';
import 'package:goski_student/data/data_source/lesson_payment_service.dart';
import 'package:goski_student/data/model/default_dto.dart';
import 'package:goski_student/data/model/lesson_payment.dart';
import 'package:goski_student/data/model/reservation.dart';
import 'package:goski_student/data/model/student_info.dart';

class LessonPaymentRepository {
  final lessonPaymentService = Get.find<LessonPaymentService>();

  Future<DefaultDTO?> teamLessonPayment(
      ReservationRequest reservationRequest,
      BeginnerResponse beginnerResponse,
      List<StudentInfo> studentInfo,
      String requestComplain) async {
    TeamLessonPaymentRequest teamLessonPaymentRequest =
        TeamLessonPaymentRequest(
            teamId: beginnerResponse.teamId,
            lessonDate: reservationRequest.lessonDate,
            startTime: reservationRequest.startTime,
            duration: reservationRequest.duration,
            peopleNumber: reservationRequest.studentCount,
            studentInfo: studentInfo,
            requestComplain: requestComplain,
            basicFee: beginnerResponse.basicFee,
            designatedFee: beginnerResponse.designatedFee,
            peopleOptionFee: beginnerResponse.peopleOptionFee,
            levelOptionFee: beginnerResponse.levelOptionFee);

    return lessonPaymentService
        .teamLessonPayment(teamLessonPaymentRequest.toJson());
  }

  Future<DefaultDTO?> instLessonPayment(
      InstLessonPaymentRequest instLessonPaymentRequest) async {
    return lessonPaymentService.instLessonPayment(instLessonPaymentRequest);
  }
}
