import 'package:get/get.dart';
import 'package:goski_student/data/model/settlement_response.dart';
import 'package:goski_student/data/repository/settlement_repository.dart';

class SettlementViewModel extends GetxController {
  SettlementRepository settlementRepository = Get.find();
  RxList<Settlement> settlementList = <Settlement>[].obs;

  void getSettlementList() async {
    List<Settlement> response = await settlementRepository.getSettlementList();

    settlementList.value = response;
  }
}