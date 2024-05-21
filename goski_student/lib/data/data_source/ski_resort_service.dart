import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/util/custom_dio.dart';
import 'package:goski_student/data/data_source/main_service.dart';
import 'package:goski_student/data/model/ski_resort.dart';
import 'package:goski_student/main.dart';

class SkiResortService extends GetxService {
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

      if (response.statusCode == 200 &&
          response.data is Map<String, dynamic> &&
          response.data['data'] is List) {
        List<dynamic> dataList = response.data['data'];
        List<SkiResort> resortList = dataList
            .map<SkiResort>(
                (json) => SkiResort.fromJson(json as Map<String, dynamic>))
            .toList();

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
