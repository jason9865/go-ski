import 'package:get/get.dart';
import 'package:goski_student/data/model/reservation.dart';
import 'package:goski_student/data/repository/reservation_repository.dart';

class ReservationViewModel extends GetxController {
  final ReservationRepository reservationRepository = Get.find();
  var reservation = Reservation().obs;

// Future<bool> userSignup(Reservation reservation) async {
//   return await ReservationRepository.userSignup(user.toUserRequest());
// }
}
