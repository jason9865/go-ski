class StudentInfo {
  String name;
  String gender;
  String age;
  String height;
  String weight;
  int footSize;
  StudentInfo({
    this.name = '',
    this.gender = '',
    this.age = '',
    this.height = '',
    this.weight = '',
    this.footSize = 0,
  });
}

class StudentInfoResponse {
  String name;
  String gender;
  String age;
  String height;
  String weight;
  int footSize;
  StudentInfoResponse({
    required this.name,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.footSize,
  });

  factory StudentInfoResponse.fromJson(Map<String, dynamic> json) {
    return StudentInfoResponse(
      name: json['name'],
      gender: json['gender'],
      age: json['age'],
      height: json['height'],
      weight: json['weight'],
      footSize: json['footSize'],
    );
  }
}

extension StudentInfoResponseToStudentInfo on StudentInfoResponse {
  StudentInfo toStudentInfo() {
    return StudentInfo(
      name: name,
      gender: gender,
      age: age,
      height: height,
      weight: weight,
      footSize: footSize,
    );
  }
}
