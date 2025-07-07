import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class EmptyUi extends StatelessWidget {
  const EmptyUi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Your wishlist is empty',
      style: TextStyles.getTitle(),
    ));
  }
}
