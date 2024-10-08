import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/loading_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/cart_items_count_notifier.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/user_info_notifier.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_service.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => DependencyInjection.instance(),
      child: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _authBloc.add(const AuthInitAppEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthInitAppFinishedState) {
              final UserInfoNotifier userInfoNotifier = ref.read(UserInfoNotifier.provider);
              userInfoNotifier.setUserInfo(state.userEntity);
              final CartItemsCountNotifier cartItemsCount = ref.read(CartItemsCountNotifier.provider);
              cartItemsCount.setCartItemsCount(state.cartItemsCount);
              context.router.replace(const InitPageRoute());
            } else if (state is AuthInitAppErrorState) {
              context.router.replace(const SignInPageRoute());
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppColors.backGroundColor,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.backGroundColor,
                systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
                toolbarHeight: 90.h,
              ),
              body: const LoadingPage(),
            );
          },
        );
      },
    );
  }
}
