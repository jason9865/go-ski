import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/util/custom_dio.dart';
import 'package:goski_student/data/model/reservation.dart';
import 'package:goski_student/view_model/reservation_view_model.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

class ReservationService extends GetxService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final ReservationViewModel reservationViewModel = Get.find();
  final baseUrl = dotenv.env['BASE_URL'];

  Future<List<BeginnerResponse>> getBeginnerLessonTeamInfo() async {
    logger.e(reservationViewModel.ReservationRequestToJson());
    try {
      dynamic response = await CustomDio.dio.post(
        '$baseUrl/lesson/reserve/novice',
        data: reservationViewModel.ReservationRequestToJson(),
      );
      logger.d(response.data);

      return (response.data as List)
          .map<BeginnerResponse>(
              (json) => BeginnerResponse.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioError catch (e) {
      logger.e("Failed to fetch Lesson Teams: ${e.message}");
      return []; // Return an empty list on error or throw a custom exception
    }
  }
}
