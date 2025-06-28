import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/theme.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/home/presentation/widgets/home_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(children: [
          Image.asset(AppAssets.appIconImage, width: 30),
          Gap(3),
          Text('Bookia',
              style: TextStyles.getTitle(
                  fontSize: 22,
                  color: context.brightness == Brightness.light
                      ? AppColors.darkColor
                      : AppColors.whiteColor))
        ]),
        actions: [
          SvgPicture.asset(
            AppAssets.searchSvg,
            colorFilter: ColorFilter.mode(
                context.brightness == Brightness.light
                    ? AppColors.darkColor
                    : AppColors.whiteColor,
                BlendMode.srcIn),
          ),
          Gap(12)
        ],
      ),
      body: HomeSlider(),
    );
  }
}
