import 'package:get/get.dart';
import 'package:goski_student/data/data_source/lesson_payment_service.dart';
import 'package:goski_student/data/model/default_dto.dart';
import 'package:goski_student/data/model/instructor.dart';
import 'package:goski_student/data/model/kakao_pay.dart';
import 'package:goski_student/data/model/lesson_payment.dart';
import 'package:goski_student/data/model/reservation.dart';
import 'package:goski_student/data/model/student_info.dart';

class LessonPaymentRepository {
  final lessonPaymentService = Get.find<LessonPaymentService>();

  Future<KakaoPayPrepareResponse> teamLessonPayment(
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
            lessonType: beginnerResponse.lessonType,
            studentInfo: studentInfo,
            requestComplain: requestComplain,
            basicFee: beginnerResponse.basicFee,
            designatedFee: beginnerResponse.designatedFee,
            peopleOptionFee: beginnerResponse.peopleOptionFee,
            levelOptionFee: beginnerResponse.levelOptionFee);

    return lessonPaymentService
        .teamLessonPayment(teamLessonPaymentRequest.toJson());
  }

  Future<KakaoPayPrepareResponse> instLessonPayment(
      ReservationRequest reservationRequest,
      BeginnerResponse beginnerResponse,
      Instructor instructor,
      List<StudentInfo> studentInfo,
      String requestComplain) async {
    InstLessonPaymentRequest instLessonPaymentRequest =
        InstLessonPaymentRequest(
            teamId: beginnerResponse.teamId,
            instId: instructor.instructorId,
            lessonDate: reservationRequest.lessonDate,
            startTime: reservationRequest.startTime,
            duration: reservationRequest.duration,
            peopleNumber: reservationRequest.studentCount,
            lessonType: instructor.lessonType,
            studentInfo: studentInfo,
            requestComplain: requestComplain,
            basicFee: beginnerResponse.basicFee,
            designatedFee: beginnerResponse.designatedFee,
            peopleOptionFee: beginnerResponse.peopleOptionFee,
            levelOptionFee: beginnerResponse.levelOptionFee);

    return lessonPaymentService
        .instLessonPayment(instLessonPaymentRequest.toJson());
  }

  Future<KakaoPayPrepareResponse> advancedLessonPayment(
      ReservationRequest reservationRequest,
      Instructor instructor,
      List<StudentInfo> studentInfo,
      String requestComplain) async {
    InstLessonPaymentRequest instLessonPaymentRequest =
        InstLessonPaymentRequest(
            teamId: instructor.teamId,
            instId: instructor.instructorId,
            lessonDate: reservationRequest.lessonDate,
            startTime: reservationRequest.startTime,
            duration: reservationRequest.duration,
            peopleNumber: reservationRequest.studentCount,
            lessonType: instructor.lessonType,
            studentInfo: studentInfo,
            requestComplain: requestComplain,
            basicFee: instructor.basicFee,
            designatedFee: instructor.designatedFee,
            peopleOptionFee: instructor.peopleOptionFee,
            levelOptionFee: instructor.levelOptionFee);

    return lessonPaymentService
        .instLessonPayment(instLessonPaymentRequest.toJson());
  }

  Future<bool> approvePayment(String tid, String pgToken) {
    ApprovePaymentRequest approvePaymentRequest =
        ApprovePaymentRequest(tid: tid, pgToken: pgToken);
    return lessonPaymentService.approvePayment(approvePaymentRequest.toJson());
  }
}
