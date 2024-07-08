import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/about/presentation/bloc/about_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/resources/assets.gen.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_component.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AboutBloc>(
      create: (context) => DependencyInjection.instance(),
      child: const AboutWrapper(),
    );
  }
}

class AboutWrapper extends StatefulWidget {
  const AboutWrapper({super.key});

  @override
  State<AboutWrapper> createState() => _AboutWrapperState();
}

class _AboutWrapperState extends State<AboutWrapper> {
  @override
  void initState() {
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
        title: AppComponent.customAppBar(Colors.white, 'About this app', context),
        toolbarHeight: 50.h,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Image.asset(
              Assets.images.foodsaverIcon.path,
              width: 120.w,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(height: 10.h),
            Text(
              'FoodSaver is committed to reducing food waste by providing a convenient platform for businesses to sell surplus food items at discounted prices, while simultaneously offering consumers access to affordable and high-quality food options. Our vision is to create a sustainable future where food waste is minimized, and everyone has access to fresh and nutritious food. We envision FoodSaver as the go-to platform for businesses to redistribute surplus food items, and for consumers to discover great deals while contributing to the fight against food waste.',
              style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: AppSizes.paddingBottom),
          ],
        ),
      ),
    );
  }
}
