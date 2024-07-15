import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/parse_utils.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/validate_utils.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/loading_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/toast_widget.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_update_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/cart_items_count_notifier.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/user_info_notifier.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/presentation/bloc/product_detail_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_service.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_component.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_dialog.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class ProductDetailPage extends StatelessWidget {
  final int productId;
  final String productName;
  final bool fromSearch;
  const ProductDetailPage({
    Key? key,
    required this.productId,
    required this.productName,
    this.fromSearch = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductDetailBloc>(
          create: (context) => DependencyInjection.instance(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => DependencyInjection.instance(),
        ),
      ],
      child: ProductDetailWrapper(
        productId: productId,
        productName: productName,
        fromSearch: fromSearch,
      ),
    );
  }
}

class ProductDetailWrapper extends StatefulWidget {
  final int productId;
  final String productName;
  final bool fromSearch;
  const ProductDetailWrapper({super.key, required this.productId, required this.productName, required this.fromSearch});

  @override
  State<ProductDetailWrapper> createState() => _ProductDetailWrapperState();
}

class _ProductDetailWrapperState extends State<ProductDetailWrapper> {
  late ProductDetailBloc _productDetailBloc;
  late CartBloc _cartBloc;
  int count = 1;
  late FToast fToast;
  @override
  void initState() {
    _productDetailBloc = BlocProvider.of<ProductDetailBloc>(context);
    _productDetailBloc.add(ProductDetailPageEvent(widget.productId));
    _cartBloc = BlocProvider.of<CartBloc>(context);
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
        title: AppComponent.customAppBar(Colors.white, widget.productName, context),
        toolbarHeight: 50.h,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return BlocListener<CartBloc, CartState>(
            listenWhen: (previous, current) => true,
            bloc: _cartBloc,
            listener: (context, state) {
              if (state is CartPageFinishedState) {
                final CartItemsCountNotifier cartItemsCount = ref.read(CartItemsCountNotifier.provider);
                cartItemsCount.setCartItemsCount(state.cartEntity.itemsCount);
                fToast.showToast(child: const ToastWidget(message: 'Thêm vào giỏ hàng thành công'));
              }
            },
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
                  child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
                    bloc: _productDetailBloc,
                    builder: (context, state) {
                      if (state is ProductDetailPageFinishedState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 12.h),
                            SizedBox(
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: ImageParse(
                                  width: MediaQuery.of(context).size.width - AppSizes.paddingHorizontal,
                                  height: MediaQuery.of(context).size.width - AppSizes.paddingHorizontal,
                                  url: state.productEntity.imageUrl,
                                  type: 'product',
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(state.productEntity.name!, style: AppTextStyle.mediumTitle()),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Text(
                                  ParseUtils.formatCurrency(state.productEntity.price.toDouble()),
                                  style: AppTextStyle.mediumTitle().copyWith(color: AppColors.primaryBrand),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'bởi ',
                                          style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w500),
                                        ),
                                        TextSpan(
                                          text: state.productEntity.creator.name,
                                          style: AppTextStyle.primaryText()
                                              .copyWith(color: const Color(0xFF03A33A), fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
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
                                        style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w500),
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
                            SizedBox(height: 5.h),
                            Text(
                              state.productEntity.description!,
                              style: AppTextStyle.primaryText(),
                            ),
                            SizedBox(
                              height: AppSizes.buttonHeight + 24.h,
                            ),
                            SizedBox(height: AppSizes.paddingBottom),
                          ],
                        );
                      } else if (state is ProductDetailPageLoadingState) {
                        return const LoadingPage();
                      } else {
                        return const SizedBox();
                      }
                    },
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
                        final UserEntity userEntity = ref.watch(UserInfoNotifier.provider).userInfo;
                        if (ValidateUtils.isLogined(userEntity)) {
                          _cartBloc.add(
                            CartUpdateItemEvent(
                              cartUpdateRequest: CartUpdateRequest(id: widget.productId, quantity: count),
                            ),
                          );
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
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(AppColors.primaryBrand),
                        shape: WidgetStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius),
                          ),
                        ),
                      ),
                      child: Text('THÊM VÀO GIỎ HÀNG', style: AppTextStyle.primaryText().copyWith(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
