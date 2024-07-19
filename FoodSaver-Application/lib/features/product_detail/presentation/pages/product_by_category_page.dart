import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

class ProductByCategoryPage extends StatelessWidget {
  final int categoryId;
  final String categoryName;
  const ProductByCategoryPage({
    Key? key,
    required this.categoryId,
    required this.categoryName,
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
      child: ProductByCategoryWrapper(
        categoryId: categoryId,
        categoryName: categoryName,
      ),
    );
  }
}

class ProductByCategoryWrapper extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  const ProductByCategoryWrapper({super.key, required this.categoryId, required this.categoryName});

  @override
  State<ProductByCategoryWrapper> createState() => _ProductByCategoryWrapperState();
}

class _ProductByCategoryWrapperState extends State<ProductByCategoryWrapper> {
  late ProductDetailBloc _productDetailBloc;
  late CartBloc _cartBloc;
  late FToast fToast;

  @override
  void initState() {
    _productDetailBloc = BlocProvider.of<ProductDetailBloc>(context);
    _productDetailBloc.add(ProductByCategoryPageEvent(widget.categoryId));
    _cartBloc = BlocProvider.of<CartBloc>(context);
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: AppSizes.paddingHorizontal,
        backgroundColor: AppColors.primaryBrand,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
        title: AppComponent.customAppBar(Colors.white, widget.categoryName, context),
        toolbarHeight: 50.h,
      ),
      body: SingleChildScrollView(
        child: Consumer(
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
              child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
                bloc: _productDetailBloc,
                builder: (context, state) {
                  if (state is ProductByCategoryPageFinishedState) {
                    return state.listProductEntity.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 15.h),
                              ProductListViewVertical(
                                products: state.listProductEntity,
                                cartBloc: _cartBloc,
                                fToast: fToast,
                                userEntity: ref.watch(UserInfoNotifier.provider).userInfo,
                              ),
                              SizedBox(height: AppSizes.paddingBottom),
                            ],
                          )
                        : const NoDataFound();
                  } else if (state is ProductByCategoryPageLoadingState) {
                    return const LoadingPage();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
