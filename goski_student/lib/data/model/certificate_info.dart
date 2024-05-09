class CertificateInfo {
  int certificateId;
  String certificateName;
  String certificateType;
  String certificateImageUrl;

  CertificateInfo({
    required this.certificateId,
    required this.certificateName,
    required this.certificateType,
    required this.certificateImageUrl,
  });

  factory CertificateInfo.fromJson(Map<String, dynamic> json) {
    return CertificateInfo(
      certificateId: json['certificateId'] as int,
      certificateName: json['certificateName'] as String,
      certificateType: json['certificateType'] as String,
      certificateImageUrl: json['certificateImageUrl'] as String,
    );
  }
}
