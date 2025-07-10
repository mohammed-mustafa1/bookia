import 'dart:developer';

import 'package:bookia/features/cart/data/model/cart_response/cart_response.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  CartResponse? cartResponse;
  Future<void> getCart() async {
    try {
      emit(CartLoading());
      await CartRepo.getCart().then((value) => value.fold(
            (failure) => emit(CartFailure(message: failure.message)),
            (response) {
              cartResponse = response;
              emit(CartSuccess());
            },
          ));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> addToCart({required int bookId}) async {
    try {
      await CartRepo.addToCart(bookId: bookId).then((value) => value.fold(
            (failure) => emit(CartFailure(message: failure.message)),
            (response) {
              cartResponse = response;
              emit(CartSuccess());
            },
          ));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> removeFromCart({required int cartItemId}) async {
    try {
      await CartRepo.removeFromCart(cartItemId: cartItemId)
          .then((value) => value.fold(
                (failure) => emit(CartFailure(message: failure.message)),
                (response) {
                  cartResponse = response;
                  emit(CartSuccess());
                },
              ));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateCart(
      {required int cartItemId, required int quantity}) async {
    try {
      await CartRepo.updateCart(cartItemId: cartItemId, quantity: quantity)
          .then((value) => value.fold(
                (failure) => emit(CartFailure(message: failure.message)),
                (response) {
                  cartResponse = response;
                  emit(CartSuccess());
                },
              ));
    } catch (e) {
      log(e.toString());
    }
  }
}
