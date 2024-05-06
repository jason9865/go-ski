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
      dynamic response = await CustomDio.dio.get('$baseUrl/common/resort');
      return (response.data as List)
          .map<SkiResort>((json) => SkiResort.fromJson(json))
          .toList();
    } on DioError catch (e) {
      logger.e("Failed to fetch ski resorts: ${e.message}");
      return []; // Return an empty list on error or throw a custom exception
    }
  }
}
