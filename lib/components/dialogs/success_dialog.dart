import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

showSuccessDialog(context) => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 4),
              SvgPicture.asset(
                AppAssets.successMarIkImageSvg,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
              Gap(32),
              Text('SUCCESS!', style: TextStyles.getHeadLine1()),
              Gap(16),
              Text('Your order will be delivered soon.',
                  style: TextStyles.getBody()),
              Text('Thank you for choosing our app!',
                  style: TextStyles.getBody()),
              // Gap(32),
              Spacer(
                flex: 1,
              ),
              MainButton(
                  onTap: () {
                    context.pop();
                  },
                  text: ' Back To Home'),
              Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
