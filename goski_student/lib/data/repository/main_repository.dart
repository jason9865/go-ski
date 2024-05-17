import 'package:get/get.dart';
import 'package:goski_student/data/data_source/main_service.dart';
import 'package:goski_student/data/model/main_response.dart';
import 'package:goski_student/data/model/weather_response.dart';

class MainRepository {
  final MainService mainService = Get.find();

  Future<Main?> getUserInfo() async {
    MainResponse? mainResponse = await mainService.getUserInfo();
    return mainResponse?.toMain();
  }

  Future<Weather?> getWeather(double latitude, double longitude) async {
    WeatherResponse? weatherResponse = await mainService.getWeather(latitude, longitude);
    return weatherResponse?.toWeather();
  }
}
