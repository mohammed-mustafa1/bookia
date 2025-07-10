import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/components/error_text_ui.dart';
import 'package:bookia/components/loading_ui.dart';
import 'package:bookia/components/snack_bars/main_snack_bar.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wish_list_cubit.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wish_list_state.dart';
import 'package:bookia/features/wishlist/presentation/widgets/empty_ui.dart';
import 'package:bookia/features/wishlist/presentation/widgets/wish_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
                onAddToCart: (bookId) async {
                  showLoadingDialog(context);
                  await cubit.addToCart(bookId: bookId);
                  context.pop();
                  showMainSnackBar(context,
                      text: 'Cart Update Successfully',
                      type: SnackBarType.success);
                },
                books: books,
                onRemove: (bookId) async {
                  showLoadingDialog(context);
                  await cubit.removeFromWishList(bookId: bookId);
                  context.pop();
                },
              );
            } else if (state is WishListError) {
              return ErrorTextUi(message: state.message);
            } else {
              return LoadingUi();
            }
          },
        ),
      ),
    );
  }
}
