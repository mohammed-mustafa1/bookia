import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/wishlist/data/model/get_wish_list_response/get_wish_list_response.dart';
import 'package:bookia/features/wishlist/data/repo/wish_list_repo.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wish_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListCubit extends Cubit<WishListState> {
  WishListCubit() : super(WishListInitial());

  GetWishListResponse getWishListresponse = GetWishListResponse();
  GetWishListResponse addToWishListresponse = GetWishListResponse();

  Future getWishList() async {
    emit(WishListLoading());
    var response = await WishListRepo.getWishList();
    response.fold((failure) {
      emit(WishListError(message: failure.message));
    }, (response) {
      getWishListresponse = response;
      emit(WishListSuccess());
    });
  }

  Future addToWishList({required int bookId}) async {
    emit(WishListLoading());
    var response = await WishListRepo.addToWishList(bookId: bookId);
    response.fold((failure) {
      emit(WishListError(message: failure.message));
    }, (response) {
      addToWishListresponse = response;
      emit(WishListSuccess());
    });
  }

  Future removeFromWishList({required int bookId}) async {
    emit(WishListLoading());
    var response = await WishListRepo.removeFromWishList(bookId: bookId);
    response.fold((failure) {
      emit(WishListError(message: failure.message));
    }, (response) {
      getWishListresponse = response;
      emit(WishListSuccess());
    });
  }

  Future addToCart({required int bookId}) async {
    emit(WishListLoading());
    var response = await CartRepo.addToCart(bookId: bookId);
    response.fold((failure) {
      emit(WishListError(message: failure.message));
    }, (response) {
      emit(WishListSuccess());
    });
  }
}
