import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class ErrorTextUi extends StatelessWidget {
  const ErrorTextUi({
    super.key,
    required this.message,
  });
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      message,
      style: TextStyles.getTitle(),
    ));
  }
}
