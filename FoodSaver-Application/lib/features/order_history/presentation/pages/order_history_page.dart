import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/presentation/bloc/order_history_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/resources/assets.gen.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_service.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_component.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderHistoryBloc>(
      create: (context) => DependencyInjection.instance(),
      child: const OrderHistoryWrapper(),
    );
  }
}

class OrderHistoryWrapper extends StatefulWidget {
  const OrderHistoryWrapper({
    super.key,
  });

  @override
  State<OrderHistoryWrapper> createState() => _OrderHistoryWrapperState();
}

class _OrderHistoryWrapperState extends State<OrderHistoryWrapper> {
  late int length;
  @override
  void initState() {
    length = 12;
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
        title: AppComponent.customAppBar(Colors.white, 'Order History', context),
        toolbarHeight: 50.h,
      ),
      body: SingleChildScrollView(
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
                      //Order History Component
                      return InkWell(
                        onTap: () {
                          context.router.push(OrderDetailPageRoute(orderId: 1));
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0XFF000000).withOpacity(0.25),
                                    blurRadius: 3,
                                    offset: const Offset(3, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12.r),
                                                  bottomLeft: Radius.circular(12.r),
                                                ),
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
                                                    SizedBox(height: 3.h),
                                                    Expanded(
                                                      child: Text(
                                                        'Hamburger Cheese',
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: AppTextStyle.primaryText()
                                                            .copyWith(fontWeight: FontWeight.w500),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        'Jul 15, 2024 - 11:05 AM',
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: AppTextStyle.primaryText().copyWith(
                                                          fontWeight: FontWeight.w500,
                                                          color: AppColors.greyColor,
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            'Delivered',
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyle.primaryText().copyWith(
                                                              fontWeight: FontWeight.w500,
                                                              color: const Color(0xFF03A33A),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 5.w),
                                                        Expanded(
                                                          child: Align(
                                                            alignment: Alignment.centerRight,
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
                                                        ),
                                                        SizedBox(width: 8.w),
                                                      ],
                                                    ),
                                                    SizedBox(height: 3.h),
                                                  ],
                                                ),
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
                            SizedBox(height: 12.h),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: AppSizes.paddingBottom),
                ],
              )
            : const SizedBox(),
      ),
    );
  }
}
