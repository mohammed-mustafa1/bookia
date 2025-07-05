import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/features/home/data/model/best_seller_response/product.dart';
import 'package:bookia/features/home/presentation/widgets/best_seller_grid_view_item.dart';
import 'package:flutter/material.dart';

class BestSellerGridView extends StatelessWidget {
  const BestSellerGridView({super.key, required this.products});
  final List<Product> products;
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
        return GestureDetector(
          onTap: () {
            context.pushTo(AppRouter.bookDetails, extra: products[index]);
          },
          child: BestSellerGridViewItem(product: products[index]),
        );
      },
      itemCount: products.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
