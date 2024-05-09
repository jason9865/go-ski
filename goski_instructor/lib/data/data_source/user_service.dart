import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/util/custom_dio.dart';
import 'package:goski_instructor/data/model/certificate.dart';
import 'package:goski_instructor/main.dart';

class UserService extends GetxService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final baseUrl = dotenv.env['BASE_URL'];

  Future<List<CertificateChoiceResponse>> fetchCertificateChoiceList() async {
    try {
      dynamic response = await CustomDio.dio.get('$baseUrl/common/certificate');
      logger.w(response.data);
      if (response.data['status'] == "success") {
        var data = response.data['data'];
        List<CertificateChoiceResponse> certificateChoiceList =
            List<CertificateChoiceResponse>.from(
                data.map((item) => CertificateChoiceResponse.fromJson(item)));
        return certificateChoiceList;
      }
    } catch (e) {
      logger.e("Failed to fetch certificateList : $e");
    }
    return [];
  }
}
