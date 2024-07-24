import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/resources/assets.gen.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_service.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_component.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class SelectPaymentPage extends StatefulWidget {
  const SelectPaymentPage({super.key});

  @override
  State<SelectPaymentPage> createState() => _SelectPaymentPageState();
}

class _SelectPaymentPageState extends State<SelectPaymentPage> {
  int paymentType = 1;
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
        title: AppComponent.customAppBar(Colors.white, 'Chọn hình thức thanh toán', context),
        toolbarHeight: 50.h,
      ),
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                //COD
                InkWell(
                  onTap: () {
                    setState(() {
                      paymentType = 1;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 80.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: paymentType == 1 ? Colors.black : Colors.transparent, width: 1.w),
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(9, 30, 66, 0.25),
                          blurRadius: 8,
                          spreadRadius: -2,
                          offset: Offset(
                            0,
                            4,
                          ),
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(9, 30, 66, 0.08),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              Assets.images.money.path,
                              width: 35.w,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(child: Text('Thanh toán khi nhận hàng (COD)', style: AppTextStyle.primaryText())),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                InkWell(
                  onTap: () {
                    setState(() {
                      paymentType = 2;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 80.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: paymentType == 2 ? Colors.black : Colors.transparent, width: 1.w),
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(9, 30, 66, 0.25),
                          blurRadius: 8,
                          spreadRadius: -2,
                          offset: Offset(
                            0,
                            4,
                          ),
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(9, 30, 66, 0.08),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              Assets.images.bank.path,
                              width: 35.w,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(child: Text('Chuyển khoản (Banking)', style: AppTextStyle.primaryText())),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.paddingBottom),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: AppColors.greyColor,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: AppSizes.paddingHorizontal,
              ),
              height: AppSizes.buttonHeight + 24.h,
              child: ElevatedButton(
                onPressed: () {
                  context.router.push(SelectShippingPageRoute(paymentType: paymentType));
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(AppColors.primaryBrand),
                  shape: WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius),
                    ),
                  ),
                ),
                child: Text(
                  'TIẾP TỤC',
                  style: AppTextStyle.primaryText().copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
