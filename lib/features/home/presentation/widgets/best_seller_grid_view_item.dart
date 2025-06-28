import 'package:bookia/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class BestSellerGridViewItem extends StatelessWidget {
  const BestSellerGridViewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(AppAssets.welcomeImage,
          width: double.infinity, fit: BoxFit.cover),
    );
  }
}
