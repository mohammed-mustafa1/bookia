import 'package:bookia/features/wishlist/data/model/get_wish_list_response/get_wish_list_response.dart';
import 'package:bookia/features/wishlist/data/repo/wish_list_repo.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wish_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListCubit extends Cubit<WishListState> {
  WishListCubit() : super(WishListInitial());

  GetWishListResponse response = GetWishListResponse();
  void getWishList() {
    emit(WishListLoading());
    WishListRepo.getWishList().then((value) => value
            .fold((failure) => emit(WishListError(message: failure.message)),
                (response) {
          this.response = response;
          emit(WishListSuccess());
        }));
  }
}
