import 'package:bookia/core/constants/app_constatns.dart';
import 'package:bookia/core/errors/failures.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/core/services/shared_prefs.dart';
import 'package:bookia/features/auth/data/model/response/user_response/user.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ProfileRepo {
  static Future<Either<Failure, User>> updateProfile({
    required String name,
    required String address,
    required String phone,
  }) async {
    try {
      var response = await DioProvider.post(
        endPoint: AppConstatns.updateProfileEndPoint,
        headers: {'Authorization': 'Bearer ${SharedPrefs.getToken()}'},
        body: {'name': name, 'address': address, 'phone': phone},
      );
      return right(User.fromJson(response.data['data']));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(message: e.toString()));
      }
    }
  }

  static Future<Either<Failure, User>> showProfile() async {
    try {
      var response = await DioProvider.get(
        endPoint: AppConstatns.showProfileEndPoint,
        headers: {'Authorization': 'Bearer ${SharedPrefs.getToken()}'},
      );
      return right(User.fromJson(response.data['data']));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(message: e.toString()));
      }
    }
  }

  static Future<Either<Failure, bool>> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      await DioProvider.post(
        endPoint: AppConstatns.updatePasswordEndPoint,
        headers: {'Authorization': 'Bearer ${SharedPrefs.getToken()}'},
        body: {
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirmation': newPasswordConfirmation,
        },
      );
      return right(true);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(message: e.toString()));
      }
    }
  }

  static Future<bool> deleteAccount() async {
    return true;
  }

  static Future<Either<Failure, Response>> logout() async {
    try {
      var response = await DioProvider.post(
        endPoint: AppConstatns.logoutEndPoint,
        headers: {'Authorization': 'Bearer ${SharedPrefs.getToken()}'},
      );

      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(message: e.toString()));
      } else {
        return left(ServerFailure(message: e.toString()));
      }
    }
  }

  static Future<bool> changeTheme() async {
    return true;
  }
}
