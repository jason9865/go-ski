import 'package:get/get.dart';
import 'package:goski_instructor/data/model/instructor.dart';
import 'package:goski_instructor/data/repository/team_repository.dart';
import 'package:goski_instructor/data/repository/user_repository.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class InstructorMainViewModel extends GetxController {
  final UserRespository userRespository = Get.find();
  final TeamRepository teamRepository = Get.find();
  Rx<Instructor> instructorInfo = Instructor().obs;
  void getInstructorInfo() async {
    var response = await userRespository.getInstructorInfo();
    if (response != null) {
      logger.w(response.available);
      instructorInfo.value = response;
    }
  }

  void getTeamList() async {
    teamRepository.getInstructorTeamList();
  }
}
