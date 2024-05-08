import 'dart:convert';

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
      return (response.data as List)
          .map<SkiResort>(
              (json) => SkiResort.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioError catch (e) {
      logger.e("Failed to fetch ski resorts: ${e.message}");
      return []; // Return an empty list on error or throw a custom exception
    }
  }
}
