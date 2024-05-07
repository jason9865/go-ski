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
      // dynamic response = await CustomDio.dio.get('$baseUrl/common/resort');
      dynamic response = await CustomDio.dio.get(
        'https://mocki.io/v1/dd5ef6b5-1af5-4419-b7c4-475324efb060',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );
      if (response.data is Map<String, dynamic> &&
          response.data['data'] is List) {
        logger.d(response.data['data']);
        return (response.data['data'] as List)
            .map<SkiResort>(
                (json) => SkiResort.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        logger.e("Unexpected data format");
        return []; // Handle unexpected format by returning an empty list
      }
    } on DioError catch (e) {
      logger.e("Failed to fetch ski resorts: ${e.message}");
      return []; // Return an empty list on error or throw a custom exception
    }
  }
}
