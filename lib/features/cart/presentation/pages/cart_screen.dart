import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/media_query.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/cart/data/model/cart_response/cart_item.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Cart', style: TextStyles.getHeadLine2()),
          centerTitle: true,
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            var cubit = context.read<CartCubit>();
            List<CartItem> books = cubit.cartItems;

            if (state is CartSuccess) {
              if (books.isEmpty) {
                return Center(
                    child: Text(
                  'Your cart is empty',
                  style: TextStyles.getTitle(),
                ));
              }
              return ListView.separated(
                padding: EdgeInsets.all(20),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return Hero(
                    tag: index,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: books[index].itemProductImage ?? '',
                            width: 100,
                            height: 118,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return Image.asset(
                                AppAssets.noCoverImage,
                                width: 100,
                                height: 118,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        const Gap(20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Text(
                                          books[index].itemProductName ?? '',
                                          style: TextStyles.getTitle(
                                              color: Color(0xff606060)),
                                          maxLines: 2)),
                                  GestureDetector(
                                      onTap: () async {
                                        await cubit.removeFromCart(
                                            cartItemId:
                                                books[index].itemId ?? 0);
                                        await cubit.getCart();
                                      },
                                      child:
                                          SvgPicture.asset(AppAssets.closeSvg)),
                                ],
                              ),
                              Gap(9),
                              Text('\$${books[index].itemProductPrice}',
                                  style: TextStyles.getBody()),
                              Gap(16),
                              Row(
                                children: [
                                  IconButton.filled(
                                    onPressed: () {},
                                    style: IconButton.styleFrom(
                                      foregroundColor: Color(0xff606060),
                                      backgroundColor: Color(0xffF0F0F0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    icon: Icon(Icons.add),
                                  ),
                                  Gap(15),
                                  Text('${books[index].itemQuantity}',
                                      style: TextStyles.getBody()),
                                  Gap(15),
                                  IconButton(
                                    onPressed: () {},
                                    style: IconButton.styleFrom(
                                      foregroundColor: Color(0xff606060),
                                      backgroundColor: Color(0xffF0F0F0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    icon: Icon(Icons.remove),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const Divider(
                    color: Color(0xfff0f0f0),
                  ),
                ),
              );
            } else if (state is CartFailure) {
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Total',
                  style: TextStyles.getTitle(
                      color: AppColors.grayColor, fontSize: 20),
                ),

                // TODO : Add total price
                Text('\$123',
                    style: TextStyles.getTitle()
                        .copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
              ]),
              Gap(20),
              MainButton(onTap: () {}, text: 'Checkout'),
            ],
          ),
        ),
      ),
    );
  }
}
