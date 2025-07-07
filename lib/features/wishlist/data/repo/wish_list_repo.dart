import 'package:bookia/core/constants/app_constatns.dart';
import 'package:bookia/core/errors/failures.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/core/services/shared_prefs.dart';
import 'package:bookia/features/wishlist/data/model/get_wish_list_response/get_wish_list_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class WishListRepo {
  static Future<Either<Failure, GetWishListResponse>> getWishList() async {
    try {
      var response = await DioProvider.get(
          endPoint: AppConstatns.wishListEndPoint,
          headers: {'Authorization': 'Bearer ${SharedPrefs.getToken()}'});

      return right(GetWishListResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(message: e.toString()));
      }
    }
  }

  static Future<Either<Failure, GetWishListResponse>> addToWishList(
      {required int bookId}) async {
    try {
      var response = await DioProvider.post(
        endPoint: AppConstatns.addToWishListEndPoint,
        body: {'product_id': '$bookId'},
        headers: {'Authorization': 'Bearer ${SharedPrefs.getToken()}'},
      );
      return right(GetWishListResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(message: e.toString()));
      }
    }
  }

  static Future<Either<Failure, GetWishListResponse>> removeFromWishList(
      {required int bookId}) async {
    try {
      var response = await DioProvider.post(
          endPoint: AppConstatns.removeFromWishListEndPoint,
          body: {'product_id': '$bookId'},
          headers: {'Authorization': 'Bearer ${SharedPrefs.getToken()}'});

      return right(GetWishListResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(message: e.toString()));
      }
    }
  }
}
