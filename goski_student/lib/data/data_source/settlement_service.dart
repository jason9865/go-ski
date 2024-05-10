import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:goski_student/data/model/settlement_response.dart';
import 'package:logger/logger.dart';

import '../../const/util/custom_dio.dart';

var logger = Logger();

class SettlementService extends GetxService {
  final baseUrl = dotenv.env['BASE_URL'];

  Future<List<SettlementResponse>> getSettlementList() async {
    try {
      dynamic response = await CustomDio.dio.get(
        '$baseUrl/payment/history',
      );

      logger.w(response.data['data']);

      if (response.data['status'] == 'success' &&
          response.data is Map<String, dynamic> &&
          response.data['data'] is List) {
        List<SettlementResponse> data = (response.data['data'] as List)
            .map<SettlementResponse>((json) =>
            SettlementResponse.fromJson(json as Map<String, dynamic>))
            .toList();
        logger.d('SettlementService - getSettlementList - 응답 성공 $data');

        return data;
      } else {
        logger.e('SettlementService - getSettlementList - 응답 실패 ${response.data}');
      }
    } catch (e) {
      logger.e('SettlementService - getSettlementList - 응답 실패 $e');
    }

    return [];
  }
}