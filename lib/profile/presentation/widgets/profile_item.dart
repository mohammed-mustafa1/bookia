import 'package:bookia/core/extensions/theme.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({super.key, this.onTap, required this.text, this.trailing});

  final void Function()? onTap;
  final String text;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            height: 60,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: context.brightness == Brightness.light
                    ? AppColors.whiteColor
                    : AppColors.darkColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff8A959E).withValues(alpha: 0.2),
                    spreadRadius: 0,
                    blurRadius: 40,
                    offset: Offset(0, 7),
                  )
                ]),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: TextStyles.getTitle(),
                  ),
                  trailing ?? Icon(Icons.arrow_forward_ios),
                ])));
  }
}
