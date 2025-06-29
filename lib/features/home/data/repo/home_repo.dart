import 'package:bookia/core/constants/app_constatns.dart';
import 'package:bookia/core/errors/failures.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/features/home/data/model/best_seller_response/best_seller_response.dart';
import 'package:bookia/features/home/data/model/slider_response/slider_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepo {
  static Future<Either<Failure, SliderResponse>> getSliders() async {
    try {
      var response =
          await DioProvider.get(endPoint: AppConstatns.sliderEndPoint);
      return right(SliderResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(message: e.toString()));
      }
    }
  }

  static Future<Either<Failure, BestSellerResponse>> getBestSellers() async {
    try {
      var response =
          await DioProvider.get(endPoint: AppConstatns.bestSellerEndPoint);
      return right(BestSellerResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(message: e.toString()));
      }
    }
  }
}
