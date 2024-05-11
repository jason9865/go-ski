import 'dart:async';

import 'package:get/get.dart';
import 'package:goski_student/data/model/student_info.dart';

class StudentInfoViewModel {
  var studentInfoList = <StudentInfo>[].obs;

  void addStudentInfo(StudentInfo studentInfo) {
    studentInfoList.add(studentInfo);
  }
}
