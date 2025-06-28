import 'package:bookia/core/constants/app_constatns.dart';
import 'package:bookia/core/errors/failures.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/features/auth/data/model/request/auth_params.dart';
import 'package:bookia/features/auth/data/model/response/user_response/user_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepo {
  static Future<Either<Failure, UserResponse>> registerUser(
      {required AuthParams registerParams}) async {
    try {
      var response = await DioProvider.post(
          endPoint: AppConstatns.registerEndPoint,
          body: registerParams.toJson());
      return right(UserResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(message: e.toString()));
      }
    }
  }

  static Future<Either<Failure, UserResponse>> loginUser(
      {required AuthParams loginParams}) async {
    try {
      var response = await DioProvider.post(
          endPoint: AppConstatns.loginEndPoint, body: loginParams.toJson());
      return right(UserResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(message: e.toString()));
      }
    }
  }

  static Future<Either<Failure, bool>> forgotPassword({
    required AuthParams forgotPasswordParams,
  }) async {
    try {
      await DioProvider.post(
          endPoint: AppConstatns.forgotPasswordEndPoint,
          body: forgotPasswordParams.toJson());
      return right(true);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(message: e.toString()));
      }
    }
  }

  static Future<Either<Failure, bool>> otpVerification({
    required AuthParams otpVerificationParams,
  }) async {
    try {
      await DioProvider.post(
          endPoint: AppConstatns.checkForGetPassword,
          body: otpVerificationParams.toJson());
      return right(true);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(message: e.toString()));
      }
    }
  }

  static Future<Either<Failure, bool>> resetPassword({
    required AuthParams resetPasswordParams,
  }) async {
    try {
      await DioProvider.post(
          endPoint: AppConstatns.resetPasswordEndPoint,
          body: resetPasswordParams.toJson());
      return right(true);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(message: e.toString()));
      }
    }
  }
}
