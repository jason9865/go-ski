import 'package:get/get.dart';
import 'package:goski_student/data/model/main_response.dart';
import 'package:goski_student/data/model/ski_resort.dart';
import 'package:goski_student/data/model/weather_response.dart';
import 'package:goski_student/data/repository/main_repository.dart';
import 'package:goski_student/data/repository/ski_resort_repository.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class MainViewModel extends GetxController {
  final MainRepository mainRepository = Get.find();
  final SkiResortRepository skiResortRepository = Get.find();
  Rx<Main> userInfo = Main().obs;
  RxList<SkiResort> skiResortList = <SkiResort>[].obs;
  Rx<SkiResort> selectedSkiResort = SkiResort(
    resortId: 0,
    resortName: '',
    resortLocation: '',
    lessonTimeList: [],
    latitude: 0,
    longitude: 0,
  ).obs;
  RxBool isWeatherLoading = true.obs;
  Rx<Weather> weather = Weather(
    temp: 0,
    weather: '',
    description: '',
    iconUrl: '',
  ).obs;

  @override
  void onInit() async {
    super.onInit();
    getUserInfo();
    getSkiResortList();
  }

  void getUserInfo() async {
    Main? response = await mainRepository.getUserInfo();

    if (response != null) {
      userInfo.value = response;
    }
  }

  void getSkiResortList() async {
    skiResortList.clear();
    List<SkiResort> response = await skiResortRepository.getSkiResortList();

    skiResortList.addAll(response);

    if (response.isNotEmpty) {
      selectedSkiResort.value = response[0];
      getWeather();
    }
  }

  void getWeather() async {
    isWeatherLoading.value = true;

    Weather? response = await mainRepository.getWeather(
        selectedSkiResort.value.latitude, selectedSkiResort.value.latitude);

    if (response != null) {
      weather.value = response;
    }

    isWeatherLoading.value = false;
  }
}
