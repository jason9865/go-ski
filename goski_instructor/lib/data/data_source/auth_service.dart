import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:goski_instructor/const/enum/auth_status.dart';
import 'package:goski_instructor/const/util/custom_dio.dart';
import 'package:goski_instructor/const/util/parser.dart';
import 'package:goski_instructor/data/model/instructor.dart';
import 'package:goski_instructor/data/model/owner.dart';
import 'package:goski_instructor/fcm/fcm_config.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class AuthService extends GetxService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final baseUrl = dotenv.env['BASE_URL'];

  Future<AuthStatus> loginWithKakao() async {
    try {
      OAuthToken token; // 카카오 로그인 성공 시 받은 토큰을 저장할 변수
      try {
        // 카카오톡을 통한 로그인 시도
        token = await UserApi.instance.loginWithKakaoTalk();
      } catch (error) {
        // 카카오톡 설치되어 있지 않거나 로그인 실패 시, 웹뷰로 로그인 시도
        logger.e("Fallback to Kakao Account Login: $error");
        token = await UserApi.instance.loginWithKakaoAccount();
      }

      // 로그인 성공 후, 토큰을 안전하게 저장하고 서버에 전송
      await secureStorage.write(key: "isLoggedIn", value: "true");
      logger.e('kakao accessToken : ${token.accessToken}');
      // await sendFCMTokenToServer(); // FCM 토큰 서버에 저장
      saveUserInfo(token.accessToken);
      return sendTokenToServer(token.accessToken); // 로그인 성공 반환
    } catch (error) {
      logger.e(error.toString());
      return AuthStatus.error; // 로그인 실패 반환
    }
  }

  // 서버에 토큰을 전송하는 함수
  Future<AuthStatus> sendTokenToServer(String accessToken) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/signin/kakao'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'token': accessToken, // Kakao accessToken을 보낼 때만 'Bearer ' 생략
        }),
      );
      if (response.statusCode == 200) {
        logger.d('Token successfully sent to the server');
        logger.w(response.headers['accesstoken']);
        if (response.headers['accesstoken'] == null) {
          return AuthStatus.first;
        }

        String? serverAccessToken = response.headers['accesstoken'];
        String? serverRefreshToken = response.headers['refreshtoken'];

        if (serverAccessToken != null && serverRefreshToken != null) {
          await secureStorage.write(
              key: dotenv.env['ACCESS_TOKEN_KEY']!, value: serverAccessToken);
          await secureStorage.write(
              key: dotenv.env['REFRESH_TOKEN_KEY']!, value: serverRefreshToken);
          setFCM();
          logger.d('New Tokens from server stored successfully');
          return AuthStatus.already;
        } else {
          // Tokens not found in response
          logger.w(
              'Failed to get Tokens, response does not contain Tokens: ${response.headers}');
        }
      } else {
        // 서버 에러 처리
        logger.e('Failed to send token to the server: ${response.body}');
      }
    } catch (e) {
      logger.e('Error sending token to the server: $e');
    }
    return AuthStatus.error;
  }

  Future<void> saveUserInfo(String accessToken) async {
    // 사용자 정보 불러오는 로직
    final Uri uri = Uri.parse('https://kapi.kakao.com/v2/user/me');

    final http.Response response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      // 사용자 정보를 성공적으로 가져온 경우
      final Map<String, dynamic> userInfo = json.decode(response.body);
      logger.d('Succeeded in fetching userInfo: $userInfo');
      await secureStorage.write(
          key: "domainUserKey", value: userInfo['id'].toString());
      await secureStorage.write(
          key: "profileUrl", value: userInfo['properties']['profile_image']);
    } else {
      // 사용자 정보를 가져오는데 실패한 경우
      throw Exception(
          'Failed to get user info from Kakao: ${response.statusCode}');
    }
  }

  Future<bool> instructorSignUp(InstructorRequest instructor) async {
    FormData formData = FormData();

    String? domainUserKey = await secureStorage.read(key: "domainUserKey");
    String? kakaoProfileImage = await secureStorage.read(key: "profileUrl");
    formData.fields.add(MapEntry('domainUserKey', domainUserKey!));
    formData.fields.add(MapEntry('kakaoProfilUrl', kakaoProfileImage!));
    formData.fields.add(MapEntry('userName', instructor.userName));
    formData.fields.add(MapEntry('gender', instructor.gender.name));
    formData.fields
        .add(MapEntry('birthDate', dateTimeToString(instructor.birthDate!)));
    formData.fields.add(MapEntry('role', instructor.role.name));
    formData.fields.add(
        MapEntry('phoneNumber', phoneNumberParser(instructor.phoneNumber)));
    formData.fields.add(MapEntry('lessonType', instructor.lessonType));
    var profileImage =
        await MultipartFile.fromFile(instructor.profileImage!.path);
    if (instructor.profileImage != null) {
      formData.files.add(MapEntry('profileImage', profileImage));
    }
    for (int i = 0; i < instructor.certificates.length; i++) {
      formData.fields.add(MapEntry('certificateIds',
          instructor.certificates[i].certificateId.toString()));
      formData.files.add(MapEntry(
          'certificateImages',
          await MultipartFile.fromFile(
              instructor.certificates[i].certificateImage.path)));
    }

    try {
      dynamic response = await CustomDio.dio.post(
        '$baseUrl/user/signup/inst',
        data: formData,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      logger.d(response.data);

      if (response.data['status'] == 'success') {
        String? serverAccessToken = response.headers['accesstoken'][0];
        String? serverRefreshToken = response.headers['refreshtoken'][0];
        if (serverAccessToken != null && serverRefreshToken != null) {
          await secureStorage.write(
              key: dotenv.env['ACCESS_TOKEN_KEY']!, value: serverAccessToken);
          await secureStorage.write(
              key: dotenv.env['REFRESH_TOKEN_KEY']!, value: serverRefreshToken);
          setFCM();
          logger.w('Succeed in write tokens after signup');
        } else {
          logger.e('Failed to write tokens after signup');
        }
        logger.d("Succeed in SignUp!");
        return true;
      } else {
        logger.e("Failed to SignUp...");
      }
    } on DioException catch (e) {
      logger.e('DioError: ${e.response?.statusCode} - ${e.message}');
      logger.e('Full error: $e');
    } catch (e) {
      logger.e('Unexpected error: $e');
    }
    return false;
  }

  // TODO: 사장 로그인 로직 수정 필요
  Future<bool> ownerSignUp(OwnerRequest owner) async {
    FormData formData = FormData();
    String? domainUserKey = await secureStorage.read(key: "domainUserKey");
    String? kakaoProfileImage = await secureStorage.read(key: "profileUrl");
    var uri = Uri.parse('$baseUrl/user/signup/user');
    var request = http.MultipartRequest('POST', uri);

    request.fields['domainUserKey'] = domainUserKey!;
    request.fields['kakaoProfileImage'] = kakaoProfileImage!;
    if (owner.profileImage != null) {
      // profileImage를 등록한 경우만
      var bytes = await owner.profileImage!.readAsBytes();
      var profileImage = http.MultipartFile.fromBytes(
        'profileImage',
        bytes,
      );
      request.files.add(profileImage);
    }
    request.fields['userName'] = owner.userName;
    request.fields['gender'] = owner.gender.name;
    request.fields['birthDate'] = dateTimeToString(owner.birthDate!);
    request.fields['role'] = owner.role.name;
    request.fields['phoneNumber'] = phoneNumberParser(owner.phoneNumber);

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        logger.d("Succeed in SignUp!");
        logger.d("responseData : $response");
        return true;
      } else {
        logger.e(response.statusCode);
        logger.e("Failed to SignUp...");
      }
    } catch (e) {
      logger.e('Failed to send SignUp Request');
    }
    return false;
  }
}
