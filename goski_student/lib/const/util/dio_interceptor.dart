import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class DioInterceptor extends Interceptor {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final accessTokenKey = dotenv.env['ACCESS_TOKEN_KEY'];
  final refreshTokenKey = dotenv.env['REFRESH_TOKEN_KEY'];
  final baseUrl = dotenv.env['BASE_URL'];
  Dio dio = Dio(BaseOptions(baseUrl: dotenv.env['BASE_URL']!));

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? accessToken = await secureStorage.read(key: accessTokenKey!);

    if (accessToken != null) {
      options.headers.addAll({
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
        "DeviceType": "MOBILE",
      });
    }
    return super.onRequest(options, handler);
  }

  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   return super.onResponse(response, handler);
  // }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if the user is unauthorized.
    if (err.response?.statusCode == 401) {
      // Refresh the user's authentication token.
      // await refreshToken(err.requestOptions);
      // Retry the request.
      try {
        handler.resolve(await refreshToken(err.requestOptions));
      } on DioException catch (e) {
        // If the request fails again, pass the error to the next interceptor in the chain.
        handler.next(e);
      }
      // Return to prevent the next interceptor in the chain from being executed.
      return;
    }
    // Pass the error to the next interceptor in the chain.
    handler.next(err);
  }

  Future<Response<dynamic>> refreshToken(RequestOptions requestOptions) async {
    String? accessToken = await secureStorage.read(key: accessTokenKey!);
    String? refreshToken = await secureStorage.read(key: refreshTokenKey!);

    final options = Options(
      method: requestOptions.method,
      headers: {
        "Content-Type": "application/json",
        "accessToken": "Bearer $accessToken",
        "Authorization": "Bearer $refreshToken"
      },
    );

    dynamic response = await dio.request<dynamic>(
      requestOptions.path,
      options: options,
      data: requestOptions.data,
    );
    // on success response, deserialize the response
    if (response.statusCode == 200) {
      logger.e("refresh 재발급 : $response");
      // LoginRequestResponse requestResponse =
      //    LoginRequestResponse.fromJson(response.data);
      // UPDATE the STORAGE with new access and refresh-tokens
      final String? serverAccessToken = response.headers['accessToken'];
      final String? serverRefreshToken = response.headers['refreshToken'];

      if (serverAccessToken != null && serverRefreshToken != null) {
        await secureStorage.write(
            key: dotenv.env['ACCESS_TOKEN_KEY']!, value: serverAccessToken);
        await secureStorage.write(
            key: dotenv.env['REFRESH_TOKEN_KEY']!, value: serverRefreshToken);
      }
      return response;
    }
    return response;
  }

  // Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
  //   // Create a new `RequestOptions` object with the same method, path, data, and query parameters as the original request.
  //   final options = Options(
  //     method: requestOptions.method,
  //     headers: {
  //       "Authorization": "Bearer $token",
  //     },
  //   );

  //   // Retry the request with the new `RequestOptions` object.
  //   return dio.request<dynamic>(requestOptions.path,
  //       data: requestOptions.data,
  //       queryParameters: requestOptions.queryParameters,
  //       options: options);
  // }
}
