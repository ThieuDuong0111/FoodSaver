import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/customer_support/presentation/bloc/customer_support_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/resources/assets.gen.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_component.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class CustomerSupportPage extends StatelessWidget {
  const CustomerSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CustomerSupportBloc>(
      create: (context) => DependencyInjection.instance(),
      child: const CustomerSupportWrapper(),
    );
  }
}

class CustomerSupportWrapper extends StatefulWidget {
  const CustomerSupportWrapper({super.key});

  @override
  State<CustomerSupportWrapper> createState() => _CustomerSupportWrapperState();
}

class _CustomerSupportWrapperState extends State<CustomerSupportWrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: AppSizes.paddingHorizontal,
        backgroundColor: AppColors.primaryBrand,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
        title: AppComponent.customAppBar(Colors.white, 'Hỗ trợ khách hàng', context),
        toolbarHeight: 50.h,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chào bạn',
                        style: TextStyle(color: AppColors.primaryBrand, fontSize: 20.sp, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Chúng tôi có thể giúp gì?',
                        style: TextStyle(color: AppColors.primaryBrand, fontSize: 20.sp, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5.w),
                Image.asset(
                  Assets.images.hand.path,
                  width: 60.w,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xFFD9D9D9)),
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'Tin nhắn',
                              maxLines: 1,
                              style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Image.asset(
                            Assets.images.typing.path,
                            width: 24.w,
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    color: const Color(0xFFD9D9D9),
                  ),
                  SizedBox(height: 6.h),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'Hỗ trợ',
                              maxLines: 1,
                              style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Image.asset(
                            Assets.images.help.path,
                            width: 24.w,
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Câu hỏi và trả lời',
              style: AppTextStyle.primaryText().copyWith(color: AppColors.primaryBrand, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 6.h),
            Container(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xFFD9D9D9)),
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'Làm sao sử dụng Food Saver',
                              maxLines: 1,
                              style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w400),
                            ),
                          ),
                          Icon(
                            Icons.navigate_next,
                            size: 24.w,
                            color: AppColors.greyColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    color: const Color(0xFFD9D9D9),
                  ),
                  SizedBox(height: 6.h),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'Làm sao để đặt thức ăn',
                              maxLines: 1,
                              style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w400),
                            ),
                          ),
                          Icon(
                            Icons.navigate_next,
                            size: 24.w,
                            color: AppColors.greyColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    color: const Color(0xFFD9D9D9),
                  ),
                  SizedBox(height: 6.h),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'Những người khác có thể đặt hàng cho tôi không',
                              maxLines: 1,
                              style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w400),
                            ),
                          ),
                          Icon(
                            Icons.navigate_next,
                            size: 24.w,
                            color: AppColors.greyColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    color: const Color(0xFFD9D9D9),
                  ),
                  SizedBox(height: 6.h),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'Làm sao để gửi phản hồi',
                              maxLines: 1,
                              style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w400),
                            ),
                          ),
                          Icon(
                            Icons.navigate_next,
                            size: 24.w,
                            color: AppColors.greyColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSizes.paddingBottom),
          ],
        ),
      ),
    );
  }
}
