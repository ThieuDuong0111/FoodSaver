import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_component.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckoutBloc>(
      create: (context) => DependencyInjection.instance(),
      child: const CheckoutWrapper(),
    );
  }
}

class CheckoutWrapper extends StatefulWidget {
  const CheckoutWrapper({super.key});

  @override
  State<CheckoutWrapper> createState() => _CheckoutWrapperState();
}

class _CheckoutWrapperState extends State<CheckoutWrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: AppSizes.paddingHorizontal,
        backgroundColor: AppColors.primaryBrand,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
        title: AppComponent.customAppBar(Colors.white, 'Order Confirmation', context),
        toolbarHeight: 50.h,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Align(
              child: Icon(
                Icons.check_circle,
                color: const Color(0xFF00b569),
                size: 120.w,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Order Payment Successful',
              style: AppTextStyle.mediumTitle().copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.h),
            Text(
              'OrderID: 11055515072024',
              style: AppTextStyle.primaryText().copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              height: 1.h,
              color: const Color(0xFFCACACA),
            ),
            SizedBox(height: 12.h),
            Text.rich(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Amount paid: ',
                    style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: '235,000VND',
                    style: AppTextStyle.primaryText().copyWith(
                      color: AppColors.primaryBrand,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Text.rich(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Payed by ',
                    style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: 'thieuduong01526',
                    style: AppTextStyle.primaryText().copyWith(
                      color: AppColors.primaryBrand,
                      fontWeight: FontWeight.w500,
                    ),
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
