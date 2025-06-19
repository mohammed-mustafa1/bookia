import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({
    super.key,
    this.onPressed,
  });
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkColor
                    : AppColors.borderColor),
            borderRadius: BorderRadius.circular(12)),
      ),
      icon: SvgPicture.asset(AppAssets.backArrowSvg,
          colorFilter: ColorFilter.mode(
              Theme.of(context).brightness == Brightness.dark
                  ? AppColors.whiteColor
                  : AppColors.darkColor,
              BlendMode.srcIn)),
    );
  }
}
