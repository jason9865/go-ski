import 'package:get/get.dart';
import 'package:goski_student/data/model/reservation.dart';
import 'package:goski_student/data/repository/reservation_repository.dart';

class LessonTeamListViewModel extends GetxController {
  final ReservationRepository _reservationRepository = ReservationRepository();
  var lessonTeams = <BeginnerResponse>[].obs;

  LessonTeamListViewModel() {
    getLessonTeamList();
  }

  Future<void> getLessonTeamList() async {
    lessonTeams.value =
        await _reservationRepository.getBeginnerLessonTeamInfo();
  }
}
