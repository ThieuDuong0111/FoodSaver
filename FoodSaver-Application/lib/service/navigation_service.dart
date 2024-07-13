import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funix_thieudvfx_foodsaver/core/constants/widget_keys.dart';
import 'package:funix_thieudvfx_foodsaver/features/about/presentation/pages/about_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/auth_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/presentation/pages/cart_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/presentation/pages/category_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/checkout/presentation/pages/checkout_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/customer_support/presentation/pages/customer_support_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/edit_profile/presentation/pages/edit_profile_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/pages/home_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/pages/init_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/presentation/pages/my_profile_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_detail/presentation/pages/order_detail_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/presentation/pages/order_history_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/presentation/pages/product_by_category_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/presentation/pages/product_detail_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/search/presentation/pages/search_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/presentation/pages/sign_in_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/presentation/pages/sign_up_page.dart';
import 'package:injectable/injectable.dart';

part 'navigation_service.gr.dart';

abstract class NavigationService implements RootStackRouter {}

@MaterialAutoRouter(
  routes: [
    AutoRoute<Object>(
      path: 'auth',
      page: AuthPage,
      initial: true,
    ),
    AutoRoute<Object>(
      path: 'init',
      page: InitPage,
    ),
    AutoRoute<Object>(
      path: 'sign_in',
      page: SignInPage,
    ),
    AutoRoute<Object>(
      path: 'sign_up',
      page: SignUpPage,
    ),
    AutoRoute<Object>(
      path: 'home',
      page: HomePage,
    ),
    AutoRoute<Object>(
      path: 'search',
      page: SearchPage,
    ),
    AutoRoute<Object>(
      path: 'category',
      page: CategoryPage,
    ),
    AutoRoute<Object>(
      path: 'product_detail',
      page: ProductDetailPage,
    ),
    AutoRoute<Object>(
      path: 'product_by_category',
      page: ProductByCategoryPage,
    ),
    AutoRoute<Object>(
      path: 'cart',
      page: CartPage,
    ),
    AutoRoute<Object>(
      path: 'checkout',
      page: CheckoutPage,
    ),
    AutoRoute<Object>(
      path: 'order_history',
      page: OrderHistoryPage,
    ),
    AutoRoute<Object>(
      path: 'order_detail',
      page: OrderDetailPage,
    ),
    AutoRoute<Object>(
      path: 'about',
      page: AboutPage,
    ),
    AutoRoute<Object>(
      path: 'customer_support',
      page: CustomerSupportPage,
    ),
    AutoRoute<Object>(
      path: 'edit_profile',
      page: EditProfilePage,
    ),
    AutoRoute<Object>(
      path: 'my_profile',
      page: MyProfilePage,
    ),
  ],
)
@LazySingleton(as: NavigationService)
class NavigationServiceImpl extends _$NavigationServiceImpl implements NavigationService {
  NavigationServiceImpl() : super(WidgetKeys.navigatorKey);

  @override
  Future<T?> replace<T extends Object?>(PageRouteInfo route, {OnNavigationFailure? onFailure}) {
    unawaited(super.replace(route, onFailure: onFailure));
    return Future.value();
  }
}
