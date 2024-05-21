class SkiResort {
  final int resortId;
  final String resortName;
  final String resortLocation;
  final double latitude;
  final double longitude;
  final List<int> lessonTimeList;

  SkiResort({
    required this.resortId,
    required this.resortName,
    required this.resortLocation,
    required this.latitude,
    required this.longitude,
    required this.lessonTimeList,
  });

  factory SkiResort.fromJson(Map<String, dynamic> json) {
    var list = json['lessonTime'] as List;
    List<int> lessonTimeList = list.map((i) => i as int).toList();

    return SkiResort(
      resortId: json['resortId'] as int,
      resortName: json['resortName'] as String,
      resortLocation: json['resortLocation'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      lessonTimeList: lessonTimeList,
    );
  }
}
