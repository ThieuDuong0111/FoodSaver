import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/loading_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/toast_widget.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_complete_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/cart_items_count_notifier.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/presentation/widgets/order_detail_widget.dart';
import 'package:funix_thieudvfx_foodsaver/resources/assets.gen.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_component.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_dialog.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class SelectShippingPage extends StatelessWidget {
  const SelectShippingPage({super.key, required this.paymentType});
  final int paymentType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartBloc>(
      create: (context) => DependencyInjection.instance(),
      child: SelectShippingWrapper(
        paymentType: paymentType,
      ),
    );
  }
}

class SelectShippingWrapper extends StatefulWidget {
  const SelectShippingWrapper({super.key, required this.paymentType});
  final int paymentType;

  @override
  State<SelectShippingWrapper> createState() => _SelectShippingWrapperState();
}

class _SelectShippingWrapperState extends State<SelectShippingWrapper> {
  int shippingType = 1;
  late CartBloc _cartBloc;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    _cartBloc = BlocProvider.of<CartBloc>(context);
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return BlocConsumer<CartBloc, CartState>(
          bloc: _cartBloc,
          listener: (context, state) {
            if (state is CartCompleteFinishedState) {
              final CartItemsCountNotifier cartItemsCount = ref.read(CartItemsCountNotifier.provider);
              cartItemsCount.setCartItemsCount(0);
            }
            if (state is CartCompleteErrorState) {
              fToast.showToast(child: const ToastWidget(message: 'Đã có lỗi xảy ra. Vui lòng thử lại!'));
            }
          },
          builder: (context, state) {
            if (state is CartCompleteLoadingState) {
              return Scaffold(
                backgroundColor: AppColors.backGroundColor,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  titleSpacing: AppSizes.paddingHorizontal,
                  backgroundColor: AppColors.primaryBrand,
                  systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
                  title: Center(
                    child: Text('Xác nhận đơn hàng', style: AppTextStyle.mediumTitle().copyWith(color: Colors.white)),
                  ),
                  toolbarHeight: 50.h,
                ),
                body: const LoadingPage(),
              );
            } else if (state is CartCompleteFinishedState) {
              return Scaffold(
                backgroundColor: AppColors.backGroundColor,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  titleSpacing: AppSizes.paddingHorizontal,
                  backgroundColor: AppColors.primaryBrand,
                  systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
                  title: Center(
                    child: Text('Xác nhận đơn hàng', style: AppTextStyle.mediumTitle().copyWith(color: Colors.white)),
                  ),
                  toolbarHeight: 50.h,
                ),
                body: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 18.h),
                          Text(
                            'Đơn hàng của bạn: ',
                            style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 12.h),
                          ListView.builder(
                            itemCount: state.listOrderEntity.length,
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  OrderDetailWidget(
                                    orderEntity: state.listOrderEntity[index],
                                  ),
                                  SizedBox(height: 15.h),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: AppSizes.paddingBottom + 48.h),
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
                            context.router.popUntilRoot();
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
                            'TRỞ LẠI TRANG CHỦ',
                            style: AppTextStyle.primaryText().copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Scaffold(
              backgroundColor: AppColors.backGroundColor,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                titleSpacing: AppSizes.paddingHorizontal,
                backgroundColor: AppColors.primaryBrand,
                systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
                title: AppComponent.customAppBar(Colors.white, 'Chọn hình thức giao hàng', context),
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
                              shippingType = 1;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: 80.h,
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: shippingType == 1 ? Colors.black : Colors.transparent, width: 1.w),
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
                                      Assets.images.deliveryBike.path,
                                      width: 35.w,
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(child: Text('Giao hàng', style: AppTextStyle.primaryText())),
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
                              shippingType = 2;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: 80.h,
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: shippingType == 2 ? Colors.black : Colors.transparent, width: 1.w),
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(48, 120, 245, 0.247),
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
                                      Assets.images.location.path,
                                      width: 35.w,
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(child: Text('Lấy hàng tại chỗ', style: AppTextStyle.primaryText())),
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
                          AppDialog.showAppDialog(
                            context: context,
                            content: 'Bạn có muốn hoàn thành đơn hàng?',
                            buttonName: 'Đồng ý',
                            action: () {
                              context.router.pop();
                              _cartBloc.add(
                                CartCompleteEvent(
                                  cartCompleteRequest: CartCompleteRequest(
                                    paymentType: widget.paymentType,
                                    shippingType: shippingType,
                                  ),
                                ),
                              );
                            },
                          );
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
          },
        );
      },
    );
  }
}
