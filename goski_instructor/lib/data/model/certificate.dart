import 'dart:io';

class Certificate {
  int? certificateId;
  File certificateImage;
  Certificate({
    this.certificateId,
    required this.certificateImage,
  });
}
