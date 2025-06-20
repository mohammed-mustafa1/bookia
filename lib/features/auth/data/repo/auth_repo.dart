import 'package:bookia/core/constants/app_constatns.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/features/auth/data/model/request/auth_params.dart';
import 'package:bookia/features/auth/data/model/response/user_response/user_response.dart';

class AuthRepo {
  static Future<dynamic> registerUser({
    required AuthParams registerParams,
  }) async {
    try {
      var response = await DioProvider.post(
          endPoint: AppConstatns.registerEndPoint,
          body: registerParams.toJson());
      if (response.statusCode == 201) {
        return UserResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  static Future<dynamic> loginUser({
    required AuthParams loginParams,
  }) async {
    try {
      var response = await DioProvider.post(
          endPoint: AppConstatns.loginEndPoint, body: loginParams.toJson());
      if (response.statusCode == 200) {
        return UserResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}
