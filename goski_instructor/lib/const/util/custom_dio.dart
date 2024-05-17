import 'package:dio/dio.dart';
import 'package:goski_instructor/const/util/dio_interceptor.dart';

class CustomDio {
  static late Dio dio; // Dio 객체를 정적으로 선언

  // 정적 초기화 메서드
  static void initialize() {
    dio = Dio(); // Dio 객체 초기화
    addInterceptors(dio); // 인터셉터 추가
  }

  // Interceptor를 추가하는 함수
  static void addInterceptors(Dio dio) {
    dio.interceptors.add(DioInterceptor()); // 인터셉터를 Dio 객체에 추가
  }
}
