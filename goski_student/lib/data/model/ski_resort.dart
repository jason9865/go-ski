class SkiResort {
  final int resortId;
  final String resortName;
  final String resortLocation;

  SkiResort({
    required this.resortId,
    required this.resortName,
    required this.resortLocation,
  });

  factory SkiResort.fromJson(Map<String, dynamic> json) {
    return SkiResort(
        resortId: json['resortId'],
        resortName: json['resortName'],
        resortLocation: json['resortLocation']);
  }
}
