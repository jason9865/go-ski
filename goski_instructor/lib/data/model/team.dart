class Team {
  int teamId;
  String teamName;
  String profileUrl;
  String description;
  String resortName;
  Team({
    this.teamId = 0,
    this.teamName = '',
    this.profileUrl = '',
    this.description = '',
    this.resortName = '',
  });
}

class TeamResponse {
  int teamId;
  String teamName;
  String profileUrl;
  String description;
  String resortName;
  TeamResponse({
    required this.teamId,
    required this.teamName,
    required this.profileUrl,
    required this.description,
    required this.resortName,
  });

  factory TeamResponse.fromJson(Map<String, dynamic> json) {
    return TeamResponse(
      teamId: json['teamId'],
      teamName: json['teamName'],
      profileUrl: json['profileUrl'],
      description: json['description'],
      resortName: json['resortName'],
    );
  }
}

extension TeamResponseToTeam on TeamResponse {
  Team toTeam() {
    return Team(
      teamId: teamId,
      teamName: teamName,
      profileUrl: profileUrl,
      description: description,
      resortName: resortName,
    );
  }
}
