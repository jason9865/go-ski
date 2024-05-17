import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:goski_instructor/data/data_source/main_service.dart';
import 'package:goski_instructor/data/model/lesson_list_response.dart';

import '../../const/util/custom_dio.dart';
import '../../main.dart';

class LessonListService extends GetxService {
  Future<List<LessonListResponse>> getLessonList() async {
    try {
      dynamic response = await CustomDio.dio.get(
        '$baseUrl/lesson/list/instructor',
      );
      logger.e(response.data['data']);
      if (response.data['status'] == 'success' &&
          response.data is Map<String, dynamic> &&
          response.data['data'] is List) {
        List<LessonListResponse> data = (response.data['data'] as List)
            .map<LessonListResponse>((json) =>
                LessonListResponse.fromJson(json as Map<String, dynamic>))
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
//
//   Future<DefaultDTO?> sendMessage(SendMessageRequest message) async {
//     FormData formData = FormData();
//     formData.fields.add(MapEntry('receiverId', message.receiverId.toString()));
//     formData.fields.add(MapEntry('title', message.title));
//     formData.fields.add(MapEntry('content', message.content.toString()));
//     if (message.image != null)
//       formData.files.add(
//           MapEntry('image', await MultipartFile.fromFile(message.image!.path)));
//
//     try {
//       dynamic response = await CustomDio.dio.post('$baseUrl/notification/dm',
//           data: formData,
//           options: Options(
//             headers: <String, String>{
//               'Content-Type': 'multipart/form-data',
//             },
//           ));
//
//       if (response.data['status'] == 'success') {
//         logger.d('LessonListService - sendMessage - 응답 성공');
//         DefaultDTO defaultDTO =
//             DefaultDTO.fromJson(response.data as Map<String, dynamic>);
//         return defaultDTO;
//       } else {
//         logger.e('LessonListService - sendMessage - 응답 실패 ${response.body}');
//       }
//     } catch (e) {
//       logger.e('LessonListService - sendMessage - 응답 실패 $e');
//     }
//
//     return null;
//   }
}
