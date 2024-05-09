import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/util/custom_dio.dart';
import 'package:goski_student/data/model/reservation.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

class ReservationService extends GetxService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final baseUrl = dotenv.env['BASE_URL'];

  Future<List<BeginnerResponse>> getBeginnerLessonTeamInfo(
      ReservationRequest reservationRequest) async {
    logger.e(reservationRequest.ReservationRequestToJson());
    try {
      dynamic response = await CustomDio.dio.post(
        '$baseUrl/lesson/reserve/novice',
        data: reservationRequest.ReservationRequestToJson(),
      );
      logger.d("ReservationService : \n$response.data");

      if (response.statusCode == 200 &&
          response.data is Map<String, dynamic> &&
          response.data['data'] is List) {
        // List<BeginnerResponse> data = (response.data['data'] as List)
        //     .map<BeginnerResponse>((json) =>
        //         BeginnerResponse.fromJson(json as Map<String, dynamic>))
        //     .toList();
        List<dynamic> dataList = response.data['data'];
        List<BeginnerResponse> teams = dataList
            .map<BeginnerResponse>((json) =>
                BeginnerResponse.fromJson(json as Map<String, dynamic>))
            .toList();
        logger.d(
            'ReservationService - getBeginnerLessonTeamInfo - 응답 성공 ${teams}');

        return teams;
      } else {
        logger.e(
            'ReservationService - getBeginnerLessonTeamInfo - 응답 실패 ${response.data}');
      }
    } catch (e) {
      logger.e('ReservationService - getBeginnerLessonTeamInfo - 응답 실패 ${e}');
    }
    return [];
  }
}
