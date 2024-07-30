import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/parse_utils.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_update_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_dialog.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class CartContentWidget extends StatelessWidget {
  const CartContentWidget({
    super.key,
    required CartBloc cartBloc,
    required CartBloc cartBlocAction,
    required this.cartEntity,
  })  : _cartBloc = cartBloc,
        _cartBlocAction = cartBlocAction;

  final CartBloc _cartBloc;
  final CartBloc _cartBlocAction;
  final CartEntity cartEntity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
          child: cartEntity.cartByCreator.isNotEmpty
              ? ListView(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    SizedBox(height: 12.h),
                    ListView.builder(
                      itemCount: cartEntity.cartByCreator.length,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
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
                                children: [
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  if (cartEntity.cartByCreator[index]!.cartItems.isNotEmpty)
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: 3.w),
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(20.w),
                                              child: ImageParse(
                                                width: 20.w,
                                                height: 20.w,
                                                url: cartEntity.cartByCreator[index]!.cartItems.first.cartProduct
                                                    .creator.storeImageUrl,
                                                type: 'store',
                                              ),
                                            ),
                                            SizedBox(width: 10.w),
                                            Text(
                                              cartEntity
                                                  .cartByCreator[index]!.cartItems.first.cartProduct.creator.storeName!,
                                              style: AppTextStyle.primaryText().copyWith(
                                                color: const Color(0xFF03A33A),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 1.h,
                                          color: const Color(0xFFCACACA).withOpacity(0.5),
                                        ),
                                      ],
                                    )
                                  else
                                    const SizedBox(),
                                  ListView.builder(
                                    itemCount: cartEntity.cartByCreator[index]!.cartItems.length,
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, indexItem) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 12.h,
                                          ),
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
                                                          url: cartEntity.cartByCreator[index]!.cartItems[indexItem]
                                                              .cartProduct.imageUrl,
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
                                                                    cartEntity.cartByCreator[index]!
                                                                        .cartItems[indexItem].cartProduct.name!,
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: AppTextStyle.primaryText().copyWith(
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
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
                                                                            id: cartEntity.cartByCreator[index]!
                                                                                .cartItems[indexItem].id,
                                                                          ),
                                                                        );
                                                                        context.router.pop();
                                                                      },
                                                                    );
                                                                  },
                                                                  child: Icon(
                                                                    Icons.delete,
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
                                                                      text: cartEntity.cartByCreator[index]!
                                                                          .cartItems[indexItem].cartProduct.description,
                                                                      style: AppTextStyle.primaryText().copyWith(
                                                                        color: AppColors.greyColor,
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
                                                                            cartEntity.cartByCreator[index]!
                                                                                .cartItems[indexItem].cartProduct.price
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
                                                                            cartEntity.cartByCreator[index]!
                                                                                    .cartItems[indexItem].unitQuantity *
                                                                                cartEntity
                                                                                    .cartByCreator[index]!
                                                                                    .cartItems[indexItem]
                                                                                    .cartProduct
                                                                                    .price
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
                                                                        if (cartEntity.cartByCreator[index]!
                                                                                .cartItems[indexItem].unitQuantity >
                                                                            1) {
                                                                          _cartBloc.add(
                                                                            CartUpdateItemEvent(
                                                                              cartUpdateRequest: CartUpdateRequest(
                                                                                id: cartEntity
                                                                                    .cartByCreator[index]!
                                                                                    .cartItems[indexItem]
                                                                                    .cartProduct
                                                                                    .id,
                                                                                quantity: -1,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }
                                                                      },
                                                                      child: Icon(
                                                                        Icons.remove_circle,
                                                                        color: AppColors.primaryBrand,
                                                                        size: 20.w,
                                                                      ),
                                                                    ),
                                                                    SizedBox(width: 8.w),
                                                                    Text(
                                                                      cartEntity.cartByCreator[index]!
                                                                          .cartItems[indexItem].unitQuantity
                                                                          .toString(),
                                                                      style: AppTextStyle.primaryText().copyWith(
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    SizedBox(width: 8.w),
                                                                    InkWell(
                                                                      onTap: () {
                                                                        _cartBloc.add(
                                                                          CartUpdateItemEvent(
                                                                            cartUpdateRequest: CartUpdateRequest(
                                                                              id: cartEntity.cartByCreator[index]!
                                                                                  .cartItems[indexItem].cartProduct.id,
                                                                              quantity: 1,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child: Icon(
                                                                        Icons.add_circle,
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
                                            height: 12.h,
                                          ),
                                          if (indexItem < cartEntity.cartByCreator[index]!.cartItems.length - 1)
                                            Container(
                                              width: double.infinity,
                                              height: 1.h,
                                              color: const Color(0xFFCACACA).withOpacity(0.5),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 14.h),
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
                      style: AppTextStyle.mediumTitle().copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Bạn hãy thêm sản phẩm nhé.',
                      style: AppTextStyle.mediumTitle().copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
        ),
        if (cartEntity.cartByCreator.isNotEmpty)
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
                        ParseUtils.formatCurrency(cartEntity.totalAmount.toDouble()),
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
                          content: 'Bạn có muốn thanh toán đơn hàng?',
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
                        'THANH TOÁN',
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
  }
}
