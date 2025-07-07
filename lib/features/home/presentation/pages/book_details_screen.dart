import 'package:bookia/components/buttons/back_icon_button.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/media_query.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/home/data/model/best_seller_response/product.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wish_list_cubit.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wish_list_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.book});
  final Product book;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishListCubit()..getWishList(),
      child: BlocConsumer<WishListCubit, WishListState>(
        listener: (context, state) {
          if (state is WishListError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.message),
            ));
          }
        },
        builder: (context, state) {
          var cubit = context.read<WishListCubit>();
          int bookAddedId = cubit.getWishListresponse.data?.data
                  ?.where((element) => element.id == book.id)
                  .firstOrNull
                  ?.id ??
              0;

          return Scaffold(
            appBar: AppBar(
              title: BackIconButton(
                onPressed: () {
                  context.pop();
                },
              ),
              actions: [
                GestureDetector(
                  onTap: () async {
                    showLoadingDialog(context);
                    if (bookAddedId != book.id) {
                      await cubit.addToWishList(bookId: book.id ?? 0);
                    } else if (bookAddedId == book.id) {
                      await cubit.removeFromWishList(bookId: book.id ?? 0);
                    }
                    await cubit.getWishList();
                    context.pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SvgPicture.asset(
                      AppAssets.bookmarkSvg,
                      colorFilter: ColorFilter.mode(
                        book.id == bookAddedId
                            ? AppColors.primaryColor
                            : AppColors.darkColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                )
              ],
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Center(
                      child: Hero(
                        tag: book.id ?? '',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: book.image ?? '',
                            width: context.width * 0.50,
                            height: context.height * 0.30,
                            fit: BoxFit.fill,
                            errorWidget: (context, url, error) {
                              return Image.asset(AppAssets.noCoverImage,
                                  fit: BoxFit.cover);
                            },
                          ),
                        ),
                      ),
                    ),
                    Gap(12),
                    Text(
                      book.name ?? '',
                      style: TextStyles.getHeadLine1(),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      book.category ?? '',
                      style: TextStyles.getSmall(
                          fontSize: 15, color: AppColors.primaryColor),
                    ),
                    Gap(16),
                    Text(
                      book.description ?? '',
                      style: TextStyles.getBody().copyWith(height: 2),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(22),
              child: Row(
                children: [
                  Text('\$ ${book.price} ', style: TextStyles.getHeadLine2()),
                  Gap(45),
                  Expanded(
                    child: MainButton(
                      onTap: () async {
                        showLoadingDialog(context);
                        await cubit.addToCart(bookId: book.id ?? 0);

                        context.pop();
                      },
                      text: 'Add to Cart',
                      backgroundColor: AppColors.darkColor,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
