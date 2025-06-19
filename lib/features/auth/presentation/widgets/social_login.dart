import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        socialCard(imagePath: AppAssets.facebookIconSvg),
        Gap(8),
        socialCard(imagePath: AppAssets.googleIconSvg),
        Gap(8),
        socialCard(
            imagePath: AppAssets.appleIconSvg,
            iconColor: Theme.of(context).brightness == Brightness.light
                ? AppColors.darkColor
                : AppColors.whiteColor),
      ],
    );
  }

  Widget socialCard({required String imagePath, Color? iconColor}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderColor, width: 1),
        ),
        height: 56,
        child: SvgPicture.asset(
          imagePath,
          width: 26,
          height: 26,
          fit: BoxFit.scaleDown,
          colorFilter: iconColor != null
              ? ColorFilter.mode(iconColor, BlendMode.srcIn)
              : null,
        ),
      ),
    );
  }
}
