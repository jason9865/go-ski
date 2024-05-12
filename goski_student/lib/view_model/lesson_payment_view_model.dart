import 'package:get/get.dart';
import 'package:goski_student/const/util/url_launch_util.dart';
import 'package:goski_student/data/model/instructor.dart';
import 'package:goski_student/data/model/kakao_pay.dart';
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
    KakaoPayPrepareResponse kakaoPayPrepareResponse =
        await lessonPaymentRepository.teamLessonPayment(
            reservationRequest, beginnerResponse, studentInfo, requestComplain);
    UrlLaunchUtil.launch(kakaoPayPrepareResponse.next_redirect_pc_url);
  }

  Future<void> instLessonPayment(
      ReservationRequest reservationRequest,
      BeginnerResponse beginnerResponse,
      Instructor instructor,
      List<StudentInfo> studentInfo,
      String requestComplain) async {
    KakaoPayPrepareResponse kakaoPayPrepareResponse =
        await lessonPaymentRepository.instLessonPayment(reservationRequest,
            beginnerResponse, instructor, studentInfo, requestComplain);
    UrlLaunchUtil.launch(kakaoPayPrepareResponse.next_redirect_pc_url);
  }
}
