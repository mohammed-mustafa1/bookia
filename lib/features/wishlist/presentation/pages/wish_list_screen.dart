import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/media_query.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wish_list_cubit.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wish_list_state.dart';
import 'package:bookia/features/wishlist/presentation/widgets/empty_ui.dart';
import 'package:bookia/features/wishlist/presentation/widgets/wish_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishListCubit()..getWishList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('WishList', style: TextStyles.getHeadLine2()),
          centerTitle: true,
        ),
        body: BlocBuilder<WishListCubit, WishListState>(
          builder: (context, state) {
            var cubit = context.read<WishListCubit>();
            var books = cubit.getWishListresponse.data?.data ?? [];
            if (state is WishListSuccess) {
              if (books.isEmpty) {
                return EmptyUi();
              }
              return WishListBuilder(
                onAddToCart: (bookId) {
                  cubit.addToCart(bookId: bookId);
                },
                books: books,
                onRemove: (bookId) {
                  cubit.removeFromWishList(bookId: bookId);
                },
              );
            } else if (state is WishListError) {
              return Center(child: Text(state.message));
            } else {
              return Center(
                child: LottieBuilder.asset(
                  AppAssets.loadingAnimation,
                  width: context.width * 0.5,
                  height: context.height * 0.5,
                  fit: BoxFit.scaleDown,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
