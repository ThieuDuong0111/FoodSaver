import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class ToastWidget extends StatelessWidget {
  final String message;
  const ToastWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - AppSizes.paddingHorizontal * 2,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(15.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 7.h),
        child: Center(
          child: Text(
            message,
            style: AppTextStyle.primaryText().copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
