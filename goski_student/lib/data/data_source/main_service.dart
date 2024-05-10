import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:goski_student/data/model/main_response.dart';
import 'package:goski_student/data/model/weather_response.dart';
import 'package:logger/logger.dart';

import '../../const/util/custom_dio.dart';

var logger = Logger();

class MainService extends GetxService {
  final baseUrl = dotenv.env['BASE_URL'];
  final openWeatherApiKey = dotenv.env['OPEN_WEATHER_API_KEY'];

  Future<MainResponse?> getUserInfo() async {
    try {
      dynamic response = await CustomDio.dio.get(
        '$baseUrl/user/profile/user',
      );

      if (response.data['status'] == 'success') {
        MainResponse data = MainResponse.fromJson(
            response.data['data'] as Map<String, dynamic>);
        logger.d('MainService - getUserInfo - 응답 성공 $data');

        return data;
      } else {
        logger.e('MainService - getUserInfo - 응답 실패 ${response.data}');
      }
    } catch (e) {
      logger.e('MainService - getUserInfo - 응답 실패 $e');
    }

    return null;
  }

  Future<WeatherResponse?> getWeather(double latitude, double longitude) async {
    try {
      dynamic response = await CustomDio.dio.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$openWeatherApiKey&units=metric',
      );

      WeatherResponse data =
          WeatherResponse.fromJson(response.data as Map<String, dynamic>);
      logger.d('MainService - getWeather - 응답 성공 $data');

      return data;
    } catch (e) {
      logger.e('MainService - getWeather - 응답 실패 $e');
    }

    return null;
  }
}
