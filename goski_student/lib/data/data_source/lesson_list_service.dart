import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:goski_student/data/model/default_dto.dart';
import 'package:goski_student/data/model/lesson_list_response.dart';
import 'package:goski_student/data/model/sned_message_request.dart';
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

      if (response.data['status'] == 'success' &&
          response.data is Map<String, dynamic> &&
          response.data['data'] is List) {
        List<LessonListItemResponse> data = (response.data['data'] as List)
            .map<LessonListItemResponse>((json) =>
                LessonListItemResponse.fromJson(json as Map<String, dynamic>))
            .toList();
        logger.d('LessonListService - getLessonList - 응답 성공 $data');

        return data;
      } else {
        logger.e('LessonListService - getLessonList - 응답 실패 ${response.data}');
      }
    } catch (e) {
      logger.e('LessonListService - getLessonList - 응답 실패 $e');
    }

    return [];
  }

  Future<DefaultDTO?> sendMessage(SendMessageRequest message) async {
    FormData formData = FormData();
    formData.fields.add(MapEntry('receiverId', message.receiverId.toString()));
    formData.fields.add(MapEntry('title', message.title));
    formData.fields.add(MapEntry('content', message.content.toString()));
    if (message.image != null) formData.files.add(MapEntry('image', await MultipartFile.fromFile(message.image!.path)));

    try {
      dynamic response = await CustomDio.dio.post(
        '$baseUrl/notification/dm',
        data: formData,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'multipart/form-data',
          },
        )
      );

      if (response.data['status'] == 'success') {
        logger.d('LessonListService - sendMessage - 응답 성공');
        DefaultDTO defaultDTO =
            DefaultDTO.fromJson(response.data as Map<String, dynamic>);
        return defaultDTO;
      } else {
        logger.e('LessonListService - sendMessage - 응답 실패 ${response.body}');
      }
    } catch (e) {
      logger.e('LessonListService - sendMessage - 응답 실패 $e');
    }

    return null;
  }
}
