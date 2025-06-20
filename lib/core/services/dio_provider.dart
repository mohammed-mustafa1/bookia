import 'package:bookia/core/constants/app_constatns.dart';
import 'package:dio/dio.dart';

class DioProvider {
  static late Dio dio;
  static const _baseUrl = AppConstatns.baseUrl;

  static init() {
    dio = Dio(BaseOptions(baseUrl: _baseUrl));
  }

  static Future<Response> get({
    required String endPoint,
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    Response response = await dio.get(
      endPoint,
      data: body,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );

    return response;
  }

  static Future<Response> post({
    required String endPoint,
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    Response response = await dio.post(
      endPoint,
      data: body,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return response;
  }

  static Future<Response> update({
    required String endPoint,
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    Response response = await dio.put(
      endPoint,
      data: body,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );

    return response;
  }
}
