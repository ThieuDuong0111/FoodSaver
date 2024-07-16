import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/parse_utils.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/loading_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/toast_widget.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_update_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/cart_items_count_notifier.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/user_info_notifier.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
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
  late CartBloc _cartBloc;
  late CartBloc _cartBlocAction;
  double totalAmount = 0;
  late FToast fToast;
  @override
  void initState() {
    _cartBloc = BlocProvider.of<CartBloc>(context);
    _cartBlocAction = BlocProvider.of<CartBloc>(context);
    _cartBloc.add(const CartGetItemsEvent());
    super.initState();
    fToast = FToast();
    fToast.init(context);
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
        title: AppComponent.customAppBar(Colors.white, 'Giỏ hàng', context),
        toolbarHeight: 50.h,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return BlocListener<CartBloc, CartState>(
            bloc: _cartBlocAction,
            listener: (context, state) {
              if (state is CartCheckoutFinishedState) {
                final CartItemsCountNotifier cartItemsCount = ref.read(CartItemsCountNotifier.provider);
                cartItemsCount.setCartItemsCount(state.cartEntity.itemsCount);
                final UserEntity userInfo = ref.watch(UserInfoNotifier.provider).userInfo;
                context.router.replace(
                  CheckoutPageRoute(
                    totalAmount: totalAmount,
                    name: userInfo.name.toString(),
                  ),
                );
                fToast.showToast(child: const ToastWidget(message: 'Xác nhận đơn hàng thành công'));
              }
              if (state is CartCheckoutErrorState) {
                fToast.showToast(child: const ToastWidget(message: 'Đã có lỗi xảy ra. Vui lòng thử lại!'));
              }
            },
            child: BlocConsumer<CartBloc, CartState>(
              bloc: _cartBloc,
              listener: (context, state) {
                if (state is CartPageFinishedState) {
                  totalAmount = state.cartEntity.totalAmount.toDouble();
                  final CartItemsCountNotifier cartItemsCount = ref.read(CartItemsCountNotifier.provider);
                  cartItemsCount.setCartItemsCount(state.cartEntity.itemsCount);
                }
              },
              builder: (context, state) {
                if (state is CartPageLoadingState) {
                  return const LoadingPage();
                } else if (state is CartPageFinishedState) {
                  totalAmount = state.cartEntity.totalAmount.toDouble();
                  return Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
                        child: state.cartEntity.cartItems.isNotEmpty
                            ? ListView(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  SizedBox(height: 12.h),
                                  ListView.builder(
                                    itemCount: state.cartEntity.cartItems.length,
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
                                                        child: ImageParse(
                                                          width: 75.w,
                                                          height: 75.w,
                                                          url: state.cartEntity.cartItems[index]!.cartProduct.imageUrl,
                                                          type: 'product',
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 8.w),
                                                    Expanded(
                                                      child: SizedBox(
                                                        height: 75.w,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    state
                                                                        .cartEntity.cartItems[index]!.cartProduct.name!,
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
                                                                          'Bạn có chắc chắn muốn xóa sản phẩm này?',
                                                                      buttonName: 'Xóa',
                                                                      action: () {
                                                                        _cartBloc.add(
                                                                          CartDeleteItemEvent(
                                                                            id: state.cartEntity.cartItems[index]!.id,
                                                                          ),
                                                                        );
                                                                        context.router.pop();
                                                                      },
                                                                    );
                                                                  },
                                                                  child: Icon(
                                                                    Icons.delete_outline,
                                                                    color: AppColors.primaryBrand,
                                                                    size: 20.w,
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
                                                                      text: 'bởi ',
                                                                      style: AppTextStyle.primaryText()
                                                                          .copyWith(fontWeight: FontWeight.w500),
                                                                    ),
                                                                    TextSpan(
                                                                      text: state.cartEntity.cartItems[index]!
                                                                          .cartProduct.creator.name,
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
                                                                  child: Row(
                                                                    children: [
                                                                      Flexible(
                                                                        child: Text(
                                                                          ParseUtils.formatCurrencyWithoutSymbol(
                                                                            state.cartEntity.cartItems[index]!
                                                                                .cartProduct.price
                                                                                .toDouble(),
                                                                          ),
                                                                          maxLines: 1,
                                                                          overflow: TextOverflow.ellipsis,
                                                                          style: AppTextStyle.primaryText().copyWith(
                                                                            fontWeight: FontWeight.w500,
                                                                            color: Colors.black,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 5.w),
                                                                      Expanded(
                                                                        child: Text(
                                                                          ParseUtils.formatCurrency(
                                                                            state.cartEntity.cartItems[index]!
                                                                                    .unitQuantity *
                                                                                state.cartEntity.cartItems[index]!
                                                                                    .cartProduct.price
                                                                                    .toDouble(),
                                                                          ),
                                                                          maxLines: 1,
                                                                          overflow: TextOverflow.ellipsis,
                                                                          style: AppTextStyle.primaryText().copyWith(
                                                                            fontWeight: FontWeight.w700,
                                                                            color: AppColors.primaryBrand,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(width: 2.w),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap: () {
                                                                        _cartBloc.add(
                                                                          CartUpdateItemEvent(
                                                                            cartUpdateRequest: CartUpdateRequest(
                                                                              id: state.cartEntity.cartItems[index]!
                                                                                  .cartProduct.id,
                                                                              quantity: -1,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child: Icon(
                                                                        Icons.remove_circle_outline,
                                                                        color: AppColors.primaryBrand,
                                                                        size: 20.w,
                                                                      ),
                                                                    ),
                                                                    SizedBox(width: 8.w),
                                                                    Text(
                                                                      state.cartEntity.cartItems[index]!.unitQuantity
                                                                          .toString(),
                                                                      style: AppTextStyle.primaryText()
                                                                          .copyWith(fontWeight: FontWeight.w500),
                                                                    ),
                                                                    SizedBox(width: 8.w),
                                                                    InkWell(
                                                                      onTap: () {
                                                                        _cartBloc.add(
                                                                          CartUpdateItemEvent(
                                                                            cartUpdateRequest: CartUpdateRequest(
                                                                              id: state.cartEntity.cartItems[index]!
                                                                                  .cartProduct.id,
                                                                              quantity: 1,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child: Icon(
                                                                        Icons.add_circle_outline,
                                                                        color: AppColors.primaryBrand,
                                                                        size: 20.w,
                                                                      ),
                                                                    ),
                                                                  ],
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
                                    'Giỏ hàng trống.',
                                    style: AppTextStyle.mediumTitle()
                                        .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    'Bạn hãy thêm sản phẩm nhé.',
                                    style: AppTextStyle.mediumTitle()
                                        .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                      ),
                      if (state.cartEntity.cartItems.isNotEmpty)
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
                                      'Tổng:',
                                      style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      ParseUtils.formatCurrency(state.cartEntity.totalAmount.toDouble()),
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
                                      AppDialog.showAppDialog(
                                        context: context,
                                        content: 'Bạn có muốn hoàn thành đơn hàng?',
                                        buttonName: 'Đồng ý',
                                        action: () {
                                          context.router.pop();
                                          _cartBlocAction.add(const CartCheckoutEvent());
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
                                      'XÁC NHẬN',
                                      style: AppTextStyle.primaryText().copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        const SizedBox(),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
