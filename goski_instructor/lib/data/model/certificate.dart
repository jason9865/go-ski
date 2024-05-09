import 'package:image_picker/image_picker.dart';

class Certificate {
  int certificateId;
  String? certificateName;
  String? certificateType;
  dynamic certificateImage;
  Certificate({
    required this.certificateId,
    this.certificateName,
    this.certificateType,
    this.certificateImage,
  });
}

class CertificateRequest {
  int certificateId;
  XFile? certificateImage;
  CertificateRequest({
    required this.certificateId,
  });
}

class CertificateResponse {
  int certificateId;
  String? certificateImage;
  CertificateResponse({
    required this.certificateId,
  });
}

class CertificateChoice extends Certificate {
  CertificateChoice({
    required super.certificateId,
    super.certificateName,
    super.certificateType,
  });
}

class CertificateChoiceResponse extends Certificate {
  CertificateChoiceResponse({
    required super.certificateId,
    super.certificateName,
    super.certificateType,
  });

  factory CertificateChoiceResponse.fromJson(Map<String, dynamic> json) {
    return CertificateChoiceResponse(
      certificateId: json['certificateId'] as int,
      certificateName: json['certificateName'] as String,
      certificateType: json['certificateType'] as String,
    );
  }
}

extension CertificationChoiceResponseToCertificationChoice
    on CertificateChoiceResponse {
  CertificateChoice toCertificateChoice() {
    return CertificateChoice(
      certificateId: certificateId,
      certificateName: certificateName,
      certificateType: certificateType,
    );
  }
}
