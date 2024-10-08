import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/core/localization/generated/l10n.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/service/bloc_observer_service.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_logger.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_service.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

final userInfoProvider = StateProvider(
  (ref) => UserEntity(
    address: '',
    id: 0,
    name: '',
    imageUrl: '',
    email: '',
    phone: '',
    storeName: '',
    storeImageUrl: '',
    storeDescription: '',
  ),
);
Future<void> main() async {
  await DependencyInjection.registerDependecies();
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //Bloc Observer
  Bloc.observer = BlocObserverService();
  //Native Splash Start
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future<void>.delayed(const Duration(seconds: 2));
  //Load Intl
  // await Lang.load(const Locale('vi', 'VN'));
  //App Logger
  // final appLogger = DependencyInjection.instance<AppLogger>();
  // await runZonedGuarded(
  //   () async =>
  //   (ex, st) => appLogger.severe('Unhandled error', ex, st),

  // );
  runApp(const FoodSaverApp());
  //Remove Native Splash
  FlutterNativeSplash.remove();
}

class FoodSaverApp extends StatefulWidget {
  const FoodSaverApp({super.key});

  @override
  State<FoodSaverApp> createState() => _FoodSaverAppState();
}

class _FoodSaverAppState extends State<FoodSaverApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final AppRouter appRouter = AppRouter();
    return ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(AppSizes.designScreenWidth, AppSizes.designScreenHeight),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            localizationsDelegates: const [
              Lang.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: const Locale('vi', 'VN'),
            supportedLocales: Lang.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            routerDelegate: AutoRouterDelegate(
              DependencyInjection.instance<NavigationService>(),
              navigatorObservers: () => [
                DependencyInjection.instance<NavigationLogger>(),
              ],
            ),
            routeInformationParser: DependencyInjection.instance<NavigationService>().defaultRouteParser(),
          );
        },
      ),
    );
  }
}
