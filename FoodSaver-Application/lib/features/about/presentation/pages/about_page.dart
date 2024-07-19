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
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: AppSizes.paddingHorizontal,
        backgroundColor: AppColors.primaryBrand,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
        title: AppComponent.customAppBar(Colors.white, 'Về Food Saver', context),
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
              'FoodSaver cam kết giảm thiểu lãng phí thực phẩm bằng cách cung cấp một nền tảng tiện lợi cho các doanh nghiệp bán các mặt hàng thực phẩm dư thừa với giá chiết khấu, đồng thời mang đến cho người tiêu dùng cơ hội tiếp cận các thực phẩm chất lượng cao và giá cả phải chăng. Tầm nhìn của chúng tôi là tạo ra một tương lai bền vững, nơi lãng phí thực phẩm được giảm thiểu và mọi người đều có thể tiếp cận thực phẩm tươi ngon và bổ dưỡng. Chúng tôi hình dung FoodSaver là nền tảng hàng đầu cho các doanh nghiệp phân phối lại các mặt hàng thực phẩm dư thừa, và cho người tiêu dùng khám phá các ưu đãi tuyệt vời trong khi góp phần chống lại lãng phí thực phẩm.',
              style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w400),
            ),
            SizedBox(height: AppSizes.paddingBottom),
          ],
        ),
      ),
    );
  }
}
