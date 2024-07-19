import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:funix_thieudvfx_foodsaver/core/constants/api_endpoints.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/loading_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/no_data_found.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/toast_widget.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/product_listview_vertical.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/cart_items_count_notifier.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/user_info_notifier.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/presentation/bloc/product_detail_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_component.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class ProductByStorePage extends StatelessWidget {
  final int storeId;

  const ProductByStorePage({
    Key? key,
    required this.storeId,
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
      child: ProductByStoreWrapper(
        storeId: storeId,
      ),
    );
  }
}

class ProductByStoreWrapper extends StatefulWidget {
  final int storeId;
  const ProductByStoreWrapper({super.key, required this.storeId});

  @override
  State<ProductByStoreWrapper> createState() => _ProductByStoreWrapperState();
}

class _ProductByStoreWrapperState extends State<ProductByStoreWrapper> {
  late ProductDetailBloc _productDetailBloc;
  late CartBloc _cartBloc;
  late FToast fToast;

  @override
  void initState() {
    _productDetailBloc = BlocProvider.of<ProductDetailBloc>(context);
    _productDetailBloc.add(ProductByStorePageEvent(widget.storeId));
    _cartBloc = BlocProvider.of<CartBloc>(context);
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Container(
          color: Colors.white,
          child: BlocListener<CartBloc, CartState>(
            listenWhen: (previous, current) => true,
            bloc: _cartBloc,
            listener: (context, state) {
              if (state is CartPageFinishedState) {
                final CartItemsCountNotifier cartItemsCount = ref.read(CartItemsCountNotifier.provider);
                cartItemsCount.setCartItemsCount(state.cartEntity.itemsCount);
                fToast.showToast(child: const ToastWidget(message: 'Thêm vào giỏ hàng thành công'));
              }
            },
            child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
              bloc: _productDetailBloc,
              builder: (context, state) {
                if (state is ProductByStorePageFinishedState) {
                  return state.listProductEntity.isNotEmpty
                      ? Scaffold(
                          backgroundColor: Colors.white,
                          appBar: AppBar(
                            backgroundColor: AppColors.primaryBrand,
                            automaticallyImplyLeading: false,
                            systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
                            title: Stack(
                              children: [
                                Column(
                                  children: [
                                    Image.network(
                                      '${ApiEndpoints.baseUrl}/image/store/${state.listProductEntity.first.creator.storeImageUrl}',
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.width / 1.5,
                                      fit: BoxFit.fill,
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 20.h,
                                  left: AppSizes.paddingHorizontal,
                                  child: InkWell(
                                    onTap: () {
                                      context.router.pop();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 12.w, bottom: 12.w, left: 12.w, right: 3.w),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.greyColor.withOpacity(0.5),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            toolbarHeight: 180.h,
                            titleSpacing: 0,
                          ),
                          body: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 15.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.verified_user,
                                            color: Colors.orangeAccent,
                                            size: 15.w,
                                          ),
                                          SizedBox(width: 5.w),
                                          Expanded(
                                            child: Text(
                                              '${state.listProductEntity.first.creator.storeName}',
                                              style: AppTextStyle.mediumTitle()
                                                  .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5.h),
                                      Row(
                                        children: [
                                          SizedBox(width: 20.w),
                                          Expanded(
                                            child: Text(
                                              '${state.listProductEntity.first.creator.address}',
                                              style: AppTextStyle.primaryText()
                                                  .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                ProductListViewVertical(
                                  products: state.listProductEntity,
                                  cartBloc: _cartBloc,
                                  fToast: fToast,
                                  userEntity: ref.watch(UserInfoNotifier.provider).userInfo,
                                ),
                                SizedBox(height: AppSizes.paddingBottom),
                              ],
                            ),
                          ),
                        )
                      : Scaffold(
                          backgroundColor: Colors.white,
                          appBar: AppBar(
                            automaticallyImplyLeading: false,
                            titleSpacing: AppSizes.paddingHorizontal,
                            backgroundColor: AppColors.primaryBrand,
                            systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
                            title: AppComponent.customAppBar(Colors.white, '', context),
                            toolbarHeight: 50.h,
                          ),
                          body: const NoDataFound(),
                        );
                } else if (state is ProductByStorePageLoadingState) {
                  return Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      titleSpacing: AppSizes.paddingHorizontal,
                      backgroundColor: AppColors.primaryBrand,
                      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
                      title: AppComponent.customAppBar(Colors.white, '', context),
                      toolbarHeight: 50.h,
                    ),
                    body: const LoadingPage(),
                  );
                } else {
                  return Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      titleSpacing: AppSizes.paddingHorizontal,
                      backgroundColor: AppColors.primaryBrand,
                      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
                      title: AppComponent.customAppBar(Colors.white, '', context),
                      toolbarHeight: 50.h,
                    ),
                    body: const SizedBox(),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
