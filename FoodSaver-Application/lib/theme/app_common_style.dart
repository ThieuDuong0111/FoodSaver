import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class AppCommonStyle {
  static InputDecoration textFieldStyle({
    String hintText = '',
    Widget? suffixIcon,
    bool hasError = false,
    bool isPassword = false,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppTextStyle.hintText(),
      border: const OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: hasError ? AppColors.primaryBrand : AppColors.greyColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(30.r)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.black87,
        ),
        borderRadius: BorderRadius.all(Radius.circular(30.r)),
      ),
      suffixIcon: suffixIcon,
    );
  }
}
