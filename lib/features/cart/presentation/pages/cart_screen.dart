import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/components/dialogs/success_dialog.dart';
import 'package:bookia/components/error_text_ui.dart';
import 'package:bookia/components/loading_ui.dart';
import 'package:bookia/components/snack_bars/main_snack_bar.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/cart/data/model/cart_response/cart_item.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:bookia/features/cart/presentation/widgets/cart_builder.dart';
import 'package:bookia/features/cart/presentation/widgets/empty_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

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
            List<CartItem> books = cubit.cartResponse?.data?.cartItems ?? [];
            if (state is CartSuccess) {
              if (books.isEmpty) {
                return EmptyUi();
              }
              return Column(
                children: [
                  Expanded(
                    child: CartBuilder(
                      books: books,
                      onRemoveItem: (value) async {
                        showLoadingDialog(context);
                        await cubit.removeFromCart(cartItemId: value);
                        context.pop();
                        showMainSnackBar(context,
                            text: 'Cart Update Successfully',
                            type: SnackBarType.success);
                      },
                      onUpdate: (itemId, quantity) async {
                        showLoadingDialog(context);
                        await cubit.updateCart(
                            cartItemId: itemId, quantity: quantity);
                        context.pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: TextStyles.getTitle(
                                    color: AppColors.grayColor, fontSize: 20),
                              ),
                              Text('\$${cubit.cartResponse?.data?.total ?? 0}',
                                  style: TextStyles.getTitle().copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ]),
                        Gap(20),
                        MainButton(
                            onTap: () {
                              showSuccessDialog(context);
                            },
                            text: 'Checkout'),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is CartFailure) {
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
