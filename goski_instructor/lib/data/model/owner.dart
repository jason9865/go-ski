import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../const/enum/gender.dart';
import '../../const/enum/role.dart';

class OwnerRequest {
  int domainUserKey;
  XFile? profileImage;
  String kakaoProfileUrl;
  String userName;
  Gender gender;
  DateTime? birthDate;
  Role role;
  String phoneNumber;

  OwnerRequest({
    required this.domainUserKey,
    this.profileImage,
    required this.kakaoProfileUrl,
    required this.userName,
    required this.gender,
    required this.birthDate,
    required this.role,
    required this.phoneNumber,
  });
}
