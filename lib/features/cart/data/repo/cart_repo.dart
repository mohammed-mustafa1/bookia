import 'package:bookia/core/constants/app_constatns.dart';
import 'package:bookia/core/errors/failures.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/core/services/shared_prefs.dart';
import 'package:bookia/features/cart/data/model/cart_response/cart_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class CartRepo {
  static Future<Either<Failure, CartResponse>> getCart() async {
    try {
      var response = await DioProvider.get(
          endPoint: AppConstatns.cartEndPoint,
          headers: {'Authorization': 'Bearer ${SharedPrefs.getToken()}'});
      return Right(CartResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(message: e.toString()));
    }
  }

  static Future<Either<Failure, CartResponse>> addToCart(
      {required int bookId}) async {
    try {
      var response = await DioProvider.post(
        endPoint: AppConstatns.addToCartEndPoint,
        headers: {'Authorization': 'Bearer ${SharedPrefs.getToken()}'},
        body: {"product_id": "$bookId"},
      );

      return Right(CartResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(message: e.toString()));
    }
  }

  static Future<Either<Failure, CartResponse>> removeFromCart(
      {required int cartItemId}) async {
    try {
      var response = await DioProvider.post(
        endPoint: AppConstatns.removeFromCartEndPoint,
        headers: {'Authorization': 'Bearer ${SharedPrefs.getToken()}'},
        body: {"cart_item_id": "$cartItemId"},
      );
      return Right(CartResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(message: e.toString()));
    }
  }

  static Future<Either<Failure, CartResponse>> updateCart(
      {required int cartItemId, required int quantity}) async {
    try {
      var response = await DioProvider.post(
        endPoint: AppConstatns.updateCartEndPoint,
        headers: {'Authorization': 'Bearer ${SharedPrefs.getToken()}'},
        body: {"cart_item_id": "$cartItemId", "quantity": "$quantity"},
      );
      return Right(CartResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
