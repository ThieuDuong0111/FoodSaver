import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class AppDialog {
  static void showAppDialog({required BuildContext context, required String content, required String buttonName}) {
    final AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                content,
                style: AppTextStyle.primaryText(),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 18.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 30.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(AppColors.primaryBrand),
                          shape: WidgetStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius),
                            ),
                          ),
                        ),
                        child: Text(buttonName, style: AppTextStyle.primaryText().copyWith(color: Colors.white)),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: double.infinity,
                      height: 30.h,
                      child: ElevatedButton(
                        onPressed: () {
                          context.router.pop();
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                          shape: WidgetStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius),
                            ),
                          ),
                        ),
                        child: Text('Cancel', style: AppTextStyle.primaryText().copyWith(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (context) {
        return alert;
      },
    );
  }
}
