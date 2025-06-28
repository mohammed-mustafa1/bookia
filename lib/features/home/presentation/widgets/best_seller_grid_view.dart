import 'package:bookia/features/home/presentation/widgets/best_seller_grid_view_item.dart';
import 'package:flutter/material.dart';

class BestSellerGridView extends StatelessWidget {
  const BestSellerGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.58,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return BestSellerGridViewItem();
      },
      itemCount: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
