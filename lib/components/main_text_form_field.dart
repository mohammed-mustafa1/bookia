import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class MainTextFormField extends StatelessWidget {
  const MainTextFormField({
    super.key,
    required this.text,
    this.obscureText,
    this.onSuffixTap,
    this.validator,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
  });
  final String text;
  final bool? obscureText;
  final Function()? onSuffixTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextFormField(
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        obscureText: obscureText ?? false,
        style: TextStyles.getSmall(fontSize: 15),
        decoration: InputDecoration(
          hintText: text,
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkColor
              : AppColors.accentColor,
          contentPadding: EdgeInsets.all(16),
          hintStyle:
              TextStyles.getSmall(fontSize: 15, color: AppColors.grayColor),
          suffixIconConstraints: BoxConstraints(minHeight: 22, minWidth: 22),
          suffixIcon: obscureText == true
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                      onTap: onSuffixTap,
                      child: SvgPicture.asset(AppAssets.fluentEyeSvg)),
                )
              : null,
        ),
      ),
    );
  }
}
