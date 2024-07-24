import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/loading_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/toast_widget.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/presentation/widgets/cart_content_widget.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/cart_items_count_notifier.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_service.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_component.dart';
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
    super.initState();
    _cartBloc = BlocProvider.of<CartBloc>(context);
    _cartBlocAction = BlocProvider.of<CartBloc>(context);
    _cartBloc.add(const CartGetItemsEvent());
    fToast = FToast();
    fToast.init(context);
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
                context.router.push(const SelectPaymentPageRoute());
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
                  return CartContentWidget(
                    cartBloc: _cartBloc,
                    cartBlocAction: _cartBlocAction,
                    cartEntity: state.cartEntity,
                  );
                } else if (state is CartCheckoutFinishedState) {
                  return CartContentWidget(
                    cartBloc: _cartBloc,
                    cartBlocAction: _cartBlocAction,
                    cartEntity: state.cartEntity,
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
