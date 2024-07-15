import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/parse_utils.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/loading_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/presentation/bloc/order_history_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_component.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class OrderDetailPage extends StatelessWidget {
  final int orderId;
  const OrderDetailPage({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderHistoryBloc>(
      create: (context) => DependencyInjection.instance(),
      child: OrderDetailWrapper(orderId: orderId),
    );
  }
}

class OrderDetailWrapper extends StatefulWidget {
  final int orderId;
  const OrderDetailWrapper({super.key, required this.orderId});

  @override
  State<OrderDetailWrapper> createState() => _OrderDetailWrapperState();
}

class _OrderDetailWrapperState extends State<OrderDetailWrapper> {
  late OrderHistoryBloc _orderHistoryBloc;
  @override
  void initState() {
    _orderHistoryBloc = BlocProvider.of<OrderHistoryBloc>(context);
    _orderHistoryBloc.add(OrderDetailPageEvent(orderId: widget.orderId));
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
        title: AppComponent.customAppBar(Colors.white, 'Chi tiết đơn hàng', context),
        toolbarHeight: 50.h,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
        child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          builder: (context, state) {
            if (state is OrderDetailPageLoadingState) {
              return const LoadingPage();
            } else if (state is OrderDetailPageFinishedState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.h),
                  Text(
                    'Mã: ${state.orderEntity.orderCode!}',
                    style: AppTextStyle.primaryText().copyWith(color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.verified_user,
                              color: Colors.orangeAccent,
                              size: 15.w,
                            ),
                            SizedBox(width: 5.w),
                            Expanded(
                              child: Text(
                                state.orderEntity.creatorName!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.smallText().copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        ParseUtils.formatDateTime(
                          state.orderEntity.publishedDate.toString(),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.smallText().copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    color: const Color(0xFFCACACA),
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    children: state.orderEntity.orderDetails
                        .map(
                          (e) => Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5.r),
                                    child: ImageParse(
                                      width: 45.w,
                                      height: 45.w,
                                      url: e!.productImage.toString(),
                                      type: 'order/${e.id}',
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    flex: 3,
                                    child: Text(e.productName!, style: AppTextStyle.smallText()),
                                  ),
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    child: Text('x${e.unitQuantity}', style: AppTextStyle.smallText()),
                                  ),
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      ParseUtils.formatCurrencyWithoutSymbol(e.unitPrice.toDouble()),
                                      style: AppTextStyle.smallText(),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      ParseUtils.formatCurrencyWithoutSymbol((e.unitPrice * e.unitQuantity).toDouble()),
                                      style: AppTextStyle.smallText(),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Container(
                                width: double.infinity,
                                height: 1.h,
                                color: const Color(0xFFCACACA),
                              ),
                              SizedBox(height: 8.h),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (state.orderEntity.isPaid)
                        Text(
                          'Complete',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.smallText().copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      else
                        Text(
                          'Waiting',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.smallText().copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      SizedBox(width: 5.w),
                      Text(
                        ParseUtils.formatCurrency(
                          state.orderEntity.totalAmount.toDouble(),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.smallText().copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    color: const Color(0xFFCACACA),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
