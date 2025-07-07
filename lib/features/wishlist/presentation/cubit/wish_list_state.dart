abstract class WishListState {}

class WishListInitial extends WishListState {}

class WishListLoading extends WishListState {}

class WishListError extends WishListState {
  final String message;
  WishListError({required this.message});
}

class WishListSuccess extends WishListState {}

// class WishListAddSuccess extends WishListState {}

// class WishListRemoveSuccess extends WishListState {}
