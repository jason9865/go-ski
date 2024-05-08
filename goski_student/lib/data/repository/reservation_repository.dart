import 'package:get/get.dart';
import 'package:goski_student/data/data_source/reservation_service.dart';
import 'package:goski_student/data/model/reservation.dart';

class ReservationRepository {
  final ReservationService reservationService = Get.find();

  Future<List<BeginnerResponse>> getBeginnerLessonTeamInfo() async {
    return await reservationService.getBeginnerLessonTeamInfo();
  }
}
