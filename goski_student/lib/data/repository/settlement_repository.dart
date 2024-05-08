import 'package:get/get.dart';
import 'package:goski_student/data/data_source/settlement_service.dart';
import 'package:goski_student/data/model/settlement_response.dart';

class SettlementRepository {
  final SettlementService settlementService = Get.find();

  Future<List<Settlement>> getSettlementList() async {
    List<SettlementResponse> settlementResponse =
        await settlementService.getSettlementList();

    return settlementResponse
        .map<Settlement>((response) => response.toSettlement())
        .toList();
  }
}
