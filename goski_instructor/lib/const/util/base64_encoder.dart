import 'dart:convert';

import 'package:image_picker/image_picker.dart';

Future<String> encodeFileToBase64(XFile file) async {
  List<int> fileBytes = await file.readAsBytes();
  return base64Encode(fileBytes);
}
