import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/core/constants/api_endpoints.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/validate_utils.dart';
import 'package:funix_thieudvfx_foodsaver/resources/assets.gen.dart';

class ImageParse extends StatelessWidget {
  final double width;
  final double height;
  final String? url;
  final String type;
  const ImageParse({
    Key? key,
    required this.width,
    required this.height,
    required this.url,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!ValidateUtils.isNotNullOrEmpty(url)) {
      return Padding(
        padding: EdgeInsets.all(8.h),
        child: Image.asset(Assets.images.noneImageProduct.path, width: width, height: height - 16.h),
      );
    }

    return SizedBox(
      // color: Colors.amberAccent,
      width: width,
      height: height,
      child: Image.network(
        '${ApiEndpoints.baseUrl}/image/$type/$url',
        width: width,
        height: height,
        fit: BoxFit.fill,
      ),
    );
  }
}
