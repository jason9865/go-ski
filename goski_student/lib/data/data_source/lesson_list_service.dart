import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:goski_student/data/model/lesson_list_response.dart';
import 'package:logger/logger.dart';

import '../../const/util/custom_dio.dart';

var logger = Logger();

class LessonListService extends GetxService {
  final baseUrl = dotenv.env['BASE_URL'];

  Future<List<LessonListItemResponse>> getLessonList() async {
    try {
      dynamic response = await CustomDio.dio.get(
        '$baseUrl/lesson/list/user',
      );

      if (response.statusCode == 200 &&
          response.data is Map<String, dynamic> &&
          response.data['data'] is List) {
        List<LessonListItemResponse> data = (response.data['data'] as List)
            .map<LessonListItemResponse>((json) =>
                LessonListItemResponse.fromJson(json as Map<String, dynamic>))
            .toList();
        logger.d('LessonListService - getLessonList - 응답 성공 ${data}');

        return data;
      } else {
        logger.e('LessonListService - getLessonList - 응답 실패 ${response.body}');
      }
    } catch (e) {
      logger.e('LessonListService - getLessonList - 응답 실패 ${e}');
    }

    return [];
  }
}
