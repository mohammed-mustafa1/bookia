import 'package:bookia/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

showLoadingDialog(context) => showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => PopScope(
          canPop: false,
          child: Center(
              child: SizedBox(
            height: 150,
            width: 150,
            child: LottieBuilder.asset(
              AppAssets.loadingAnimation,
              fit: BoxFit.cover,
            ),
          )),
        ));
