
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/util/custom_dio.dart';
import 'package:goski_student/data/model/ski_resort.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

class SkiResortService extends GetxService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final baseUrl = dotenv.env['BASE_URL'];

  Future<List<SkiResort>> getSkiResorts() async {
    try {
      dynamic response = await CustomDio.dio.get(
        '$baseUrl/common/resort',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );
      logger.d(response.data);

      if (response.statusCode == 200 &&
          response.data is Map<String, dynamic> &&
          response.data['data'] is List) {
        // List<BeginnerResponse> data = (response.data['data'] as List)
        //     .map<BeginnerResponse>((json) =>
        //         BeginnerResponse.fromJson(json as Map<String, dynamic>))
        //     .toList();
        List<dynamic> dataList = response.data['data'];
        List<SkiResort> resortList = dataList
            .map<SkiResort>(
                (json) => SkiResort.fromJson(json as Map<String, dynamic>))
            .toList();
        logger.d('SkiResortService - getSkiResorts - 응답 성공 $resortList');

        return resortList;
      } else {
        logger.e('SkiResortService - getSkiResorts - 응답 실패 ${response.data}');
      }
    } on DioException catch (e) {
      logger.e("Failed to fetch ski resorts: ${e.message}");
      return []; // Return an empty list on error or throw a custom exception
    }
    return [];
  }
}
