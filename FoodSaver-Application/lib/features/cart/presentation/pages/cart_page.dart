import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/parse_utils.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/loading_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_update_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/cart_items_count_notifier.dart';
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
  int length = 12;
  @override
  void initState() {
    _cartBloc = BlocProvider.of<CartBloc>(context);
    _cartBloc.add(const CartGetItemsEvent());
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
      body: Consumer(
        builder: (context, ref, child) {
          return BlocConsumer<CartBloc, CartState>(
            bloc: _cartBloc,
            listener: (context, state) {
              if (state is CartPageFinishedState) {
                final CartItemsCountNotifier cartItemsCount = ref.read(CartItemsCountNotifier.provider);
                cartItemsCount.setCartItemsCount(state.cartEntity.itemsCount);
              }
            },
            builder: (context, state) {
              if (state is CartPageLoadingState) {
                return const LoadingPage();
              } else if (state is CartPageFinishedState) {
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
                                                        width: 80.w,
                                                        height: 80.w,
                                                        url: state.cartEntity.cartItems[index]!.cartProduct.imageUrl,
                                                        type: 'product',
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
                                                                  state.cartEntity.cartItems[index]!.cartProduct.name!,
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
                                                                    text: 'by ',
                                                                    style: AppTextStyle.primaryText()
                                                                        .copyWith(fontWeight: FontWeight.w500),
                                                                  ),
                                                                  TextSpan(
                                                                    text: state.cartEntity.cartItems[index]!.cartProduct
                                                                        .creator.name,
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
                                                                  ParseUtils.formatCurrency(
                                                                    state.cartEntity.cartItems[index]!.cartProduct.price
                                                                        .toDouble(),
                                                                  ),
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
                                    'Total:',
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
                                  child:
                                      Text('CHECKOUT', style: AppTextStyle.primaryText().copyWith(color: Colors.white)),
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
          );
        },
      ),
    );
  }
}
