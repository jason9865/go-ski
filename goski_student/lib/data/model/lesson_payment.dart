import 'student_info.dart';

class LessonPayment {
  int teamId; // beginnerResponse.teamId
  int instId; // instructor.instructorId
  String lessonDate; // reservationRequest.lessonDate
  String startTime; // reservationRequest.startTime
  int duration; // reservationRequest.duration
  int peopleNumber; // reservationRequest.studentCount
  List<StudentInfo> studentInfo; // List<studentInfo>
  String requestComplain; //requestComplain
  int basicFee; // beginnerResponse.basicFee
  int designatedFee; // beginnerResponse.designatedFee
  int peopleOptionFee; // beginnerResponse.peopleOptionFee
  int levelOptionFee; // beginnerResponse.levelOptionFee

  // int couponId;

  LessonPayment({
    required this.teamId,
    required this.instId,
    required this.lessonDate,
    required this.startTime,
    required this.duration,
    required this.peopleNumber,
    required this.studentInfo,
    required this.requestComplain,
    required this.basicFee,
    required this.designatedFee,
    required this.peopleOptionFee,
    required this.levelOptionFee,
  });
}

class TeamLessonPaymentRequest {
  int teamId; // beginnerResponse.teamId
  String lessonDate; // reservationRequest.lessonDate
  String startTime; // reservationRequest.startTime
  int duration; // reservationRequest.duration
  int peopleNumber; // reservationRequest.studentCount
  List<StudentInfo> studentInfo; // List<studentInfo>
  String requestComplain; //requestComplain
  int basicFee; // beginnerResponse.basicFee
  int designatedFee; // beginnerResponse.designatedFee
  int peopleOptionFee; // beginnerResponse.peopleOptionFee
  int levelOptionFee; // beginnerResponse.levelOptionFee

  TeamLessonPaymentRequest({
    required this.teamId,
    required this.lessonDate,
    required this.startTime,
    required this.duration,
    required this.peopleNumber,
    required this.studentInfo,
    this.requestComplain = '',
    required this.basicFee,
    required this.designatedFee,
    required this.peopleOptionFee,
    required this.levelOptionFee,
  });

  Map<String, dynamic> toJson() {
    return {
      "teamId": teamId,
      "lessonDate": lessonDate,
      "startTime": startTime,
      "duration": duration,
      "peopleNumber": peopleNumber,
      "studentInfo": studentInfo.map((e) => e.toJson()).toList(),
      "requestComplain": requestComplain,
      "basicFee": basicFee,
      "designatedFee": designatedFee,
      "peopleOptionFee": peopleOptionFee,
      "levelOptionFee": levelOptionFee,
    };
  }
}

class InstLessonPaymentRequest {
  int teamId; // beginnerResponse.teamId
  int instId; // instructor.instructorId
  String lessonDate; // reservationRequest.lessonDate
  String startTime; // reservationRequest.startTime
  int duration; // reservationRequest.duration
  int peopleNumber; // reservationRequest.studentCount
  List<StudentInfo> studentInfo; // List<studentInfo>
  String requestComplain; //requestComplain
  int basicFee; // beginnerResponse.basicFee
  int designatedFee; // beginnerResponse.designatedFee
  int peopleOptionFee; // beginnerResponse.peopleOptionFee
  int levelOptionFee; // beginnerResponse.levelOptionFee

  InstLessonPaymentRequest({
    required this.teamId,
    required this.instId,
    required this.lessonDate,
    required this.startTime,
    required this.duration,
    required this.peopleNumber,
    required this.studentInfo,
    required this.requestComplain,
    required this.basicFee,
    required this.designatedFee,
    required this.peopleOptionFee,
    required this.levelOptionFee,
  });

  Map<String, dynamic> toJson() {
    return {
      "teamId": teamId,
      "instId": instId,
      "lessonDate": lessonDate,
      "startTime": startTime,
      "duration": duration,
      "peopleNumber": peopleNumber,
      "studentInfo": studentInfo,
      "requestComplain": requestComplain,
      "basicFee": basicFee,
      "designatedFee": designatedFee,
      "peopleOptionFee": peopleOptionFee,
      "levelOptionFee": levelOptionFee,
    };
  }
}

extension LessonPaymentToTeamLessonPaymentRequest on LessonPayment {
  TeamLessonPaymentRequest toTeamLessonPaymentRequest() {
    return TeamLessonPaymentRequest(
      teamId: teamId,
      lessonDate: lessonDate,
      startTime: startTime,
      duration: duration,
      peopleNumber: peopleNumber,
      studentInfo: studentInfo,
      requestComplain: requestComplain,
      basicFee: basicFee,
      designatedFee: designatedFee,
      peopleOptionFee: peopleOptionFee,
      levelOptionFee: levelOptionFee,
    );
  }
}

extension LessonPaymentToInstLessonPaymentRequest on LessonPayment {
  InstLessonPaymentRequest toInstLessonPaymentRequest() {
    return InstLessonPaymentRequest(
      teamId: teamId,
      instId: instId,
      lessonDate: lessonDate,
      startTime: startTime,
      duration: duration,
      peopleNumber: peopleNumber,
      studentInfo: studentInfo,
      requestComplain: requestComplain,
      basicFee: basicFee,
      designatedFee: designatedFee,
      peopleOptionFee: peopleOptionFee,
      levelOptionFee: levelOptionFee,
    );
  }
}
