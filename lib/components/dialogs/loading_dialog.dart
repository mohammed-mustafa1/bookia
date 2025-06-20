import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/media_query.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

showLoadingDialog(context) => showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
            child: LottieBuilder.asset(
          AppAssets.loadingAnimation,
          width: context.width * 0.5,
          height: context.height * 0.5,
          fit: BoxFit.scaleDown,
        )));
