import 'package:get/get.dart';
import 'package:goski_instructor/data/data_source/team_service.dart';
import 'package:goski_instructor/data/data_source/user_service.dart';
import 'package:goski_instructor/data/model/certificate.dart';
import 'package:goski_instructor/data/model/instructor.dart';
import 'package:goski_instructor/data/model/team.dart';

class TeamRepository {
  final TeamService teamService = Get.find();

  Future<List<Team>?> getInstructorTeamList() async {
    var response = await teamService.fetchInstructorTeamList();
    if (response != null) {
      List<Team> instructorTeamList =
          List<Team>.from(response.map((item) => item.toTeam()));
      return instructorTeamList;
    }
    return null;
  }
}
