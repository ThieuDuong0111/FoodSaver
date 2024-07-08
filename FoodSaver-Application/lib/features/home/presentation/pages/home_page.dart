import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/bloc/home_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/resources/assets.gen.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_service.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class HomePage extends StatelessWidget {
  final PageController pageController;
  const HomePage({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => DependencyInjection.instance(),
      child: HomeWrapper(pageController: pageController),
    );
  }
}

class HomeWrapper extends StatefulWidget {
  final PageController pageController;
  const HomeWrapper({super.key, required this.pageController});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
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
        backgroundColor: AppColors.primaryBrand,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
        toolbarHeight: 115.h,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          height: 40.w,
                          width: 40.w,
                          decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(40.w),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello,',
                                style: AppTextStyle.primaryText()
                                    .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'thieuduong01526',
                                style: AppTextStyle.primaryText()
                                    .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5.w),
                  InkWell(
                    onTap: () {
                      context.router.push(const CartPageRoute());
                    },
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5.w),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              //Search Bar
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 35.h,
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: AppColors.primaryBrand,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(child: Text('Search for foods you like', style: AppTextStyle.hintText())),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppSizes.paddingHorizontal),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSizes.homeCrossAxisSpacing,
                  mainAxisSpacing: AppSizes.homeMainAxisSpacing,
                  childAspectRatio: 146 / 201,
                ),
                itemCount: 20,
                itemBuilder: (context, index) {
                  //Home Product Component
                  return InkWell(
                    onTap: () {
                      context.router.push(ProductDetailPageRoute(productId: 1));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: const Color(0xFFD2C7C7), width: 1.w),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(15.r), topRight: Radius.circular(15.r)),
                            child: Image.asset(
                              Assets.images.foodImage.path,
                              height: AppSizes.homeProductImageSize(context),
                              width: AppSizes.homeProductImageSize(context),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Hamburger Cheese',
                                      style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w500),
                                      maxLines: 1,
                                    ),
                                  ),
                                  Text(
                                    '235,000VND',
                                    style: AppTextStyle.primaryText()
                                        .copyWith(fontWeight: FontWeight.w500, color: AppColors.primaryBrand),
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
              ),
              SizedBox(height: AppSizes.paddingBottom),
            ],
          ),
        ),
      ),
    );
  }
}
