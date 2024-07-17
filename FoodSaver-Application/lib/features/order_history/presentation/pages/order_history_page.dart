import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/parse_utils.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/loading_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/no_data_found.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/presentation/bloc/order_history_bloc.dart';
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
  late OrderHistoryBloc _orderHistoryBloc;
  @override
  void initState() {
    _orderHistoryBloc = BlocProvider.of<OrderHistoryBloc>(context);
    _orderHistoryBloc.add(const OrderHistoryPageEvent());
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
        title: AppComponent.customAppBar(Colors.white, 'Danh sách đơn hàng', context),
        toolbarHeight: 50.h,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
        child: ListView(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 16.h),
            BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
              builder: (context, state) {
                if (state is OrderHistoryPageLoadingState) {
                  return const LoadingPage();
                } else if (state is OrderHistoryPageFinishedState) {
                  return state.listOrderEntity.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.listOrderEntity.length,
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            //Order History Component
                            final List<String> orderCode = state.listOrderEntity[index].orderCode!.split('-');
                            return InkWell(
                              onTap: () {
                                context.router.push(OrderDetailPageRoute(orderId: state.listOrderEntity[index].id));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
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
                                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 8.h),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '#${orderCode.last}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyle.smallText().copyWith(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(
                                              ParseUtils.formatDateTime(
                                                state.listOrderEntity[index].publishedDate.toString(),
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyle.smallText().copyWith(
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 6.h),
                                        Row(
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
                                                      state.listOrderEntity[index].creatorName!,
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
                                              ParseUtils.convertStatusTypeText(state.listOrderEntity[index].statusType),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyle.smallText().copyWith(
                                                color: ParseUtils.convertStatusTypeColor(
                                                  state.listOrderEntity[index].statusType,
                                                ),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8.h),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 95.w,
                                              width: 80.w * 2.52,
                                              child: ListView.builder(
                                                itemCount: state.listOrderEntity[index].orderDetails.length,
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (context, indexDetail) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(right: 10.w),
                                                    child: Column(
                                                      children: [
                                                        Flexible(
                                                          child: SizedBox(
                                                            width: 70.w,
                                                            height: 70.w,
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(5.r),
                                                              child: ImageParse(
                                                                width: 70.w,
                                                                height: 70.w,
                                                                url: state.listOrderEntity[index]
                                                                    .orderDetails[indexDetail]!.productImage,
                                                                type:
                                                                    'order/${state.listOrderEntity[index].orderDetails[indexDetail]!.id}',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 3.h),
                                                        SizedBox(
                                                          width: 70.w,
                                                          child: Text(
                                                            state.listOrderEntity[index].orderDetails[indexDetail]!
                                                                .productName!,
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyle.smallText().copyWith(
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  ParseUtils.formatCurrency(
                                                    state.listOrderEntity[index].totalAmount.toDouble(),
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: AppTextStyle.smallText().copyWith(fontWeight: FontWeight.w500),
                                                ),
                                                Text(
                                                  '${state.listOrderEntity[index].orderDetails.length} sản phẩm',
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: AppTextStyle.smallText().copyWith(fontWeight: FontWeight.w400),
                                                ),
                                                SizedBox(height: 10.h),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8.h),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                ],
                              ),
                            );
                          },
                        )
                      : const NoDataFound();
                } else {
                  return const SizedBox();
                }
              },
            ),
            SizedBox(height: AppSizes.paddingBottom),
          ],
        ),
      ),
    );
  }
}
