import 'package:bookia/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingUi extends StatelessWidget {
  const LoadingUi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150,
        width: 150,
        child: LottieBuilder.asset(
          AppAssets.loadingAnimation,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
