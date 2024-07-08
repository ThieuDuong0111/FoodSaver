import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class AppTextStyle {
  static TextStyle bigTitle() {
    return TextStyle(
      color: AppColors.primaryBrand,
      fontSize: 28.sp,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle mediumTitle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle primaryText() {
    return TextStyle(
      color: Colors.black,
      fontSize: 14.sp,
    );
  }

  static TextStyle labelText() {
    return TextStyle(
      color: AppColors.primaryBrand,
      fontSize: 14.sp,
    );
  }

  static TextStyle focusText() {
    return TextStyle(
      color: Colors.black,
      fontSize: 14.sp,
    );
  }

  static TextStyle hintText() {
    return TextStyle(
      color: AppColors.greyColor,
      fontSize: 14.sp,
    );
  }
}
