import 'package:get/get.dart';
import 'package:goski_student/data/data_source/reservation_service.dart';
import 'package:goski_student/data/model/reservation.dart';
import 'package:goski_student/view_model/reservation_view_model.dart';

class ReservationRepository {
  final ReservationService reservationService = Get.find();

  Future<List<BeginnerResponse>> getBeginnerLessonTeamInfo(
      ReservationRequest reservationRequest) async {
    return await reservationService
        .getBeginnerLessonTeamInfo(reservationRequest);
  }
}
