import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/resources/assets.gen.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 50.h),
          Padding(
            padding: EdgeInsets.all(32.w),
            child: Image.asset(Assets.images.noDataFound.path),
          ),
        ],
      ),
    );
  }
}
