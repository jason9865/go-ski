import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/util/custom_dio.dart';
import 'package:goski_instructor/data/model/schedule.dart';
import 'package:goski_instructor/main.dart';

class ScheduleService extends GetxService {
  final baseUrl = dotenv.env['BASE_URL'];

  Future<List<ScheduleResponse>?> fetchScheduleList() async {
    try {
      dynamic response = await CustomDio.dio.get('$baseUrl/schedule/mine');
      logger.w("fetchedScheduleList : ${response.data}");
      if (response.data['status'] == "success") {
        var data = response.data['data'];
        List<ScheduleResponse> scheduleResponseList =
            List<ScheduleResponse>.from(
                data.map((item) => ScheduleResponse.fromJson(item)));
        return scheduleResponseList;
      }
    } on DioException catch (e) {
      logger.e('DioError: ${e.response?.statusCode} - ${e.message}');
      logger.e('Full error: $e');
    } catch (e) {
      logger.e("Failed to fetchScheduleList : $e");
    }
    return null;
  }
}
