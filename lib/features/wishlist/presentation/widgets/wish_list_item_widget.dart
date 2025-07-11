import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/theme.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/home/data/model/best_seller_response/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class WishListItemWidget extends StatelessWidget {
  const WishListItemWidget({
    super.key,
    required this.book,
    required this.onRemove,
    required this.onAddToCart,
  });

  final Product book;
  final Function(int value) onRemove;
  final Function(int value) onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: book.image ?? '',
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
                      child: Text(book.name ?? '',
                          style: TextStyles.getTitle(
                            color: context.brightness == Brightness.light
                                ? Color(0xff606060)
                                : AppColors.whiteColor,
                          ),
                          maxLines: 2)),
                  GestureDetector(
                      onTap: () => onRemove(book.id ?? 0),
                      child: SvgPicture.asset(
                        AppAssets.closeSvg,
                        colorFilter: ColorFilter.mode(
                            context.brightness == Brightness.light
                                ? AppColors.darkColor
                                : AppColors.whiteColor,
                            BlendMode.srcIn),
                      )),
                ],
              ),
              Gap(9),
              Text('\$${book.price}', style: TextStyles.getBody()),
              Gap(16),
              MainButton(
                  height: 40,
                  onTap: () => onAddToCart(book.id ?? 0),
                  text: 'Add to Cart'),
            ],
          ),
        )
      ],
    );
  }
}
