import 'dart:developer';

import 'package:bookia/core/errors/failures.dart';
import 'package:bookia/features/home/data/model/all_products_response/all_products_response.dart';
import 'package:bookia/features/home/data/model/best_seller_response/best_seller_response.dart';
import 'package:bookia/features/home/data/model/best_seller_response/product.dart';
import 'package:bookia/features/home/data/model/slider_response/slider.dart';
import 'package:bookia/features/home/data/model/slider_response/slider_response.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:bookia/features/home/data/repo/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<SliderModel> sliders = [];
  List<Product> bestSellersList = [];
  List<Product> allproducts = [];

  void getHomeData() async {
    try {
      emit(HomeLoading());
      var future = await Future.wait([
        HomeRepo.getSliders(),
        HomeRepo.getBestSellers(),
        HomeRepo.getAllProducts()
      ]);
      (future[0] as Either<Failure, SliderResponse>).fold((failure) {
        emit(HomeError(message: failure.message));
      }, (response) {
        sliders = response.data!.sliders!;
        emit(HomeSuccess());
      });

      (future[1] as Either<Failure, BestSellerResponse>).fold((failure) {
        emit(HomeError(message: failure.message));
      }, (response) {
        bestSellersList = response.data!.products!;
        emit(HomeSuccess());
      });

      (future[2] as Either<Failure, AllProductsResponse>).fold((failure) {
        emit(HomeError(message: failure.message));
      }, (response) {
        allproducts = response.data!.products!;
        emit(HomeSuccess());
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
