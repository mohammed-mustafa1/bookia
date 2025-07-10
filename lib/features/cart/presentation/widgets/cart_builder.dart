import 'package:bookia/features/cart/data/model/cart_response/cart_item.dart';
import 'package:bookia/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';

class CartBuilder extends StatelessWidget {
  const CartBuilder({
    super.key,
    required this.books,
    required this.onRemoveItem,
    required this.onUpdate,
  });

  final List<CartItem> books;
  final Function(int) onRemoveItem;
  final Function(int, int) onUpdate;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(20),
      itemCount: books.length,
      itemBuilder: (context, index) {
        return Hero(
          tag: index,
          child: CartItemWidget(
            onUpdate: onUpdate,
            book: books[index],
            onRemoveItem: onRemoveItem,
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
  }
}
