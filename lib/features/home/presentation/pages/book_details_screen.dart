import 'package:bookia/components/buttons/back_icon_button.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/media_query.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/home/data/model/best_seller_response/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.book});
  final Product book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BackIconButton(),
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
                onTap: () {},
                text: 'Add to Cart',
                backgroundColor: AppColors.darkColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
