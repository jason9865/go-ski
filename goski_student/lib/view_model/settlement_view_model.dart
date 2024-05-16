import 'package:get/get.dart';
import 'package:goski_student/data/model/settlement_response.dart';
import 'package:goski_student/data/repository/settlement_repository.dart';

class SettlementViewModel extends GetxController {
  SettlementRepository settlementRepository = Get.find();
  RxList<Settlement> settlementList = <Settlement>[].obs;
  RxBool isLoading = true.obs;

  void getSettlementList() async {
    isLoading.value = true;

    List<Settlement> response = await settlementRepository.getSettlementList();

    response.sort((a, b) => b.paymentDate.compareTo(a.paymentDate));

    settlementList.value = response;

    isLoading.value = false;
  }
}