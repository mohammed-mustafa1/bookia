import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/features/home/data/model/best_seller_response/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BestSellerGridViewItem extends StatelessWidget {
  const BestSellerGridViewItem({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: product.id ?? '',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: product.image ?? '',
          fit: BoxFit.cover,
          errorWidget: (context, url, error) {
            return Image.asset(AppAssets.noCoverImage, fit: BoxFit.cover);
          },
        ),
      ),
    );
  }
}
