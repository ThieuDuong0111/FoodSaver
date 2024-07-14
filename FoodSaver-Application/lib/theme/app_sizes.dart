import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizes {
  static const double designScreenWidth = 360;
  static const double designScreenHeight = 640;
  static double paddingHorizontal = 18.w;
  static double paddingBottom = 20.h;
  static double spaceBetweenLabelAndForm = 3.h;
  static double spaceBetweenFormAndForm = 15.h;
  static double buttonHeight = 42.h;
  static double buttonBorderRadius = 30.r;
  static double homeCrossAxisSpacing = 16.w;
  static double homeMainAxisSpacing = 16.w;
  static double categoryCrossAxisSpacing = 12.w;
  static double categoryMainAxisSpacing = 12.w;

  static double homeProductImageSize(BuildContext context) {
    return (MediaQuery.sizeOf(context).width - paddingHorizontal * 2 - homeCrossAxisSpacing) / 2 - 1.w * 2;
  }
}
