import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/resources/assets.gen.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_service.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_component.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_dialog.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartBloc>(
      create: (context) => DependencyInjection.instance(),
      child: const CartWrapper(),
    );
  }
}

class CartWrapper extends StatefulWidget {
  const CartWrapper({super.key});

  @override
  State<CartWrapper> createState() => _CartWrapperState();
}

class _CartWrapperState extends State<CartWrapper> {
  late int count;
  late int length;
  @override
  void initState() {
    count = 1;
    length = 8;
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
        title: AppComponent.customAppBar(Colors.white, 'My Cart', context),
        toolbarHeight: 50.h,
      ),
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
            child: length > 0
                ? ListView(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                      SizedBox(height: 12.h),
                      ListView.builder(
                        itemCount: length,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10.r),
                                            child: Image.asset(
                                              Assets.images.foodImage.path,
                                              height: 80.w,
                                              width: 80.w,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: SizedBox(
                                            height: 80.w,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        'Hamburger Cheese',
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: AppTextStyle.primaryText()
                                                            .copyWith(fontWeight: FontWeight.w500),
                                                      ),
                                                    ),
                                                    SizedBox(width: 5.w),
                                                    InkWell(
                                                      onTap: () {
                                                        AppDialog.showAppDialog(
                                                          context: context,
                                                          content:
                                                              'Are you sure you want to remove this item from your cart?',
                                                          buttonName: 'Delete',
                                                          action: () {},
                                                        );
                                                      },
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color: AppColors.primaryBrand,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Flexible(
                                                  child: Text.rich(
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'by ',
                                                          style: AppTextStyle.primaryText()
                                                              .copyWith(fontWeight: FontWeight.w500),
                                                        ),
                                                        TextSpan(
                                                          text: 'Foodiesfeed',
                                                          style: AppTextStyle.primaryText().copyWith(
                                                            color: const Color(0xFF03A33A),
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        '235,000VND',
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: AppTextStyle.primaryText().copyWith(
                                                          fontWeight: FontWeight.w500,
                                                          color: AppColors.primaryBrand,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 5.w),
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                if (count > 1) {
                                                                  count--;
                                                                }
                                                              });
                                                            },
                                                            child: const Icon(
                                                              Icons.remove_circle,
                                                              color: AppColors.primaryBrand,
                                                            ),
                                                          ),
                                                          SizedBox(width: 8.w),
                                                          Text(
                                                            count.toString(),
                                                            style: AppTextStyle.primaryText()
                                                                .copyWith(fontWeight: FontWeight.w500),
                                                          ),
                                                          SizedBox(width: 8.w),
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                count++;
                                                              });
                                                            },
                                                            child: const Icon(
                                                              Icons.add_circle,
                                                              color: AppColors.primaryBrand,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                width: double.infinity,
                                height: 1.h,
                                color: const Color(0xFFCACACA),
                              ),
                              SizedBox(height: 12.h),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: AppSizes.buttonHeight + 24.h,
                      ),
                      SizedBox(height: AppSizes.paddingBottom),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 120.h),
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: AppColors.primaryBrand,
                        size: 200.w,
                      ),
                      Text(
                        'Your cart is empty.',
                        style: AppTextStyle.mediumTitle().copyWith(color: Colors.black),
                      ),
                      Text(
                        'Please add some products.',
                        style: AppTextStyle.mediumTitle().copyWith(color: Colors.black),
                      ),
                    ],
                  ),
          ),
          if (length > 0)
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total:',
                          style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '235,000VND',
                          style: AppTextStyle.primaryText()
                              .copyWith(color: AppColors.primaryBrand, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.router.push(const CheckoutPageRoute());
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(AppColors.primaryBrand),
                          shape: WidgetStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius),
                            ),
                          ),
                        ),
                        child: Text('CHECKOUT', style: AppTextStyle.primaryText().copyWith(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
