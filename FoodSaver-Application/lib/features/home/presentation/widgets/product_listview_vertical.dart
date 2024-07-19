import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/parse_utils.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/validate_utils.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/toast_widget.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_update_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_service.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_dialog.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class ProductListViewVertical extends StatelessWidget {
  final CartBloc cartBloc;
  final List<ProductEntity?> products;
  final FToast fToast;
  final UserEntity userEntity;
  const ProductListViewVertical({
    super.key,
    required this.products,
    required this.cartBloc,
    required this.fToast,
    required this.userEntity,
  });

  @override
  Widget build(BuildContext context) {
    final double size = 80.w;
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              context.router.push(
                ProductDetailPageRoute(
                  productId: products[index]!.id,
                  productName: products[index]!.name.toString(),
                ),
              );
            },
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: ImageParse(
                    width: size,
                    height: size,
                    url: products[index]!.imageUrl,
                    type: 'product',
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: SizedBox(
                    height: size,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products[index]!.name.toString(),
                          style: AppTextStyle.primaryText().copyWith(color: Colors.black, fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          products[index]!.description.toString(),
                          style: AppTextStyle.primaryText()
                              .copyWith(color: AppColors.greyColor, fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                ParseUtils.formatCurrency(products[index]!.price.toDouble()),
                                style:
                                    AppTextStyle.primaryText().copyWith(color: Colors.red, fontWeight: FontWeight.w500),
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            InkWell(
                              onTap: () {
                                if (ValidateUtils.isLogined(userEntity)) {
                                  if (products[index]!.isExpired!) {
                                    fToast.showToast(child: const ToastWidget(message: 'Sản phẩm này đã hết hạn.'));
                                  } else if (products[index]!.quantity < 1) {
                                    fToast.showToast(child: const ToastWidget(message: 'Sản phẩm này đã hết hàng.'));
                                  } else {
                                    cartBloc.add(
                                      CartUpdateItemEvent(
                                        cartUpdateRequest: CartUpdateRequest(id: products[index]!.id, quantity: 1),
                                      ),
                                    );
                                  }
                                } else {
                                  AppDialog.showAppDialog(
                                    context: context,
                                    content: 'Bạn hãy đăng nhập để sử dụng tính năng này. Quay lại trang đăng nhập?',
                                    buttonName: 'Đồng ý',
                                    action: () {
                                      context.router.pushAndPopUntil(
                                        const SignInPageRoute(),
                                        predicate: (_) => false,
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Icon(
                                Icons.add_box_sharp,
                                color: AppColors.primaryBrand,
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
        );
      },
    );
  }
}
