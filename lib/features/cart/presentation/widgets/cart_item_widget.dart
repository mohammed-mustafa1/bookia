import 'package:bookia/components/snack_bars/main_snack_bar.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/theme.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/cart/data/model/cart_response/cart_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.book,
    required this.onRemoveItem,
    required this.onUpdate,
  });

  final CartItem book;
  final Function(int itemId) onRemoveItem;
  final Function(int itemId, int quantity) onUpdate;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: book.itemProductImage ?? '',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(book.itemProductName ?? '',
                          style: TextStyles.getTitle(
                            color: context.brightness == Brightness.light
                                ? Color(0xff606060)
                                : AppColors.whiteColor,
                          ),
                          maxLines: 2)),
                  GestureDetector(
                      onTap: () => onRemoveItem(book.itemId ?? 0),
                      child: SvgPicture.asset(AppAssets.closeSvg)),
                ],
              ),
              Gap(9),
              Text('\$${book.itemProductPriceAfterDiscount}',
                  style: TextStyles.getBody()),
              Gap(16),
              Row(
                children: [
                  IconButton.filled(
                    onPressed: () {
                      if (book.itemQuantity! < book.itemProductStock!) {
                        onUpdate(
                            book.itemId ?? 0, (book.itemQuantity ?? 0) + 1);
                      } else {
                        showMainSnackBar(context,
                            text: 'Not Enough Stock', type: SnackBarType.error);
                      }
                    },
                    style: IconButton.styleFrom(
                      foregroundColor: Color(0xff606060),
                      backgroundColor: Color(0xffF0F0F0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    icon: Icon(Icons.add),
                  ),
                  Gap(15),
                  Text('${book.itemQuantity}', style: TextStyles.getBody()),
                  Gap(15),
                  IconButton(
                    onPressed: () {
                      if (book.itemQuantity! > 1) {
                        onUpdate(
                            book.itemId ?? 0, (book.itemQuantity ?? 0) - 1);
                      } else {
                        showMainSnackBar(context,
                            text: 'quantity can not be zero',
                            type: SnackBarType.error);
                      }
                    },
                    style: IconButton.styleFrom(
                      foregroundColor: Color(0xff606060),
                      backgroundColor: Color(0xffF0F0F0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
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
    );
  }
}
