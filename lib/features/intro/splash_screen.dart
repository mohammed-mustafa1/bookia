// ignore_for_file: use_build_context_synchronously

import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/services/shared_prefs.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    String token = SharedPrefs.getToken();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (token.isNotEmpty) {
        context.pushToBase(AppRouter.mainScreen);
      } else {
        context.pushToBase(AppRouter.welcome);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.logoImageSvg, width: 250),
            Gap(10),
            Text('Order Your Book Now!',
                style: TextStyles.getTitle(color: AppColors.darkColor)),
            // Row(),
          ],
        ),
      ),
    );
  }
}
