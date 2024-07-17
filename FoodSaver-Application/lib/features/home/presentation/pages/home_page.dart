import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/validate_utils.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/loading_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/bloc/home_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/product_gridview.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/cart_items_count_notifier.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/user_info_notifier.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_service.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_dialog.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => DependencyInjection.instance(),
      child: const HomeWrapper(),
    );
  }
}

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  late HomeBloc _homeBloc;
  late FToast fToast;
  final CarouselController _carouselController = CarouselController();

  int _currentBannerIndex = 0;
  @override
  void initState() {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.add(const HomePageEvent());
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryBrand,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
        toolbarHeight: 110.h,
        titleSpacing: 0,
        title: Consumer(
          builder: (context, ref, child) {
            final UserEntity userinfo = ref.watch(UserInfoNotifier.provider).userInfo;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            if (ValidateUtils.isNotNullOrEmpty(userinfo.imageUrl))
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40.w),
                                child: ImageParse(width: 40.w, height: 40.w, url: userinfo.imageUrl, type: 'user'),
                              )
                            else
                              Icon(
                                Icons.account_circle,
                                size: 40.w,
                                color: AppColors.greyColor,
                              ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Chào mừng đến với FoodSaver',
                                    style: AppTextStyle.primaryText()
                                        .copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    ValidateUtils.isNotNullOrEmpty(userinfo.name) ? userinfo.name! : 'User',
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
                      SizedBox(
                        child: (ValidateUtils.isLogined(userinfo))
                            ? InkWell(
                                onTap: () {
                                  context.router.push(const CartPageRoute());
                                },
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    final int cartItemsCount =
                                        ref.watch(CartItemsCountNotifier.provider).cartItemsCount;
                                    return Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                          size: 22.w,
                                        ),
                                        if (cartItemsCount > 0)
                                          Positioned(
                                            top: cartItemsCount < 10 ? -11.w : -8.w,
                                            right: -5.w,
                                            child: Container(
                                              decoration:
                                                  const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                              padding: EdgeInsets.all(cartItemsCount < 10 ? 5.w : 3.w),
                                              child: cartItemsCount < 10
                                                  ? Text(
                                                      cartItemsCount.toString(),
                                                      style: AppTextStyle.smallText()
                                                          .copyWith(color: Colors.white, fontSize: 11.sp),
                                                    )
                                                  : Text(
                                                      '9+',
                                                      style: AppTextStyle.smallText()
                                                          .copyWith(color: Colors.white, fontSize: 10.sp),
                                                    ),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  AppDialog.showAppDialog(
                                    context: context,
                                    content: 'Bạn hãy đăng nhập để sử dụng tính năng này. Quay lại trang đăng nhập?',
                                    buttonName: 'Đồng ý',
                                    action: () {
                                      context.router.replace(const SignInPageRoute());
                                    },
                                  );
                                },
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                  size: 22.w,
                                ),
                              ),
                      ),
                      SizedBox(width: 10.w),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  //Search Bar
                  InkWell(
                    onTap: () {
                      context.router.push(const SearchPageRoute());
                    },
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
                          Expanded(child: Text('Tìm sản phẩm', style: AppTextStyle.hintText())),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppSizes.paddingHorizontal),
          width: double.infinity,
          child: BlocBuilder<HomeBloc, HomeState>(
            bloc: _homeBloc,
            builder: (context, state) {
              if (state is HomePageFinishedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      carouselController: _carouselController,
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 7),
                        viewportFraction: 0.95,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentBannerIndex = index;
                          });
                        },
                      ),
                      items: state.homeEntity.banners
                          .map(
                            (banner) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: ImageParse(
                                width: 1920,
                                height: 1080,
                                url: banner!.imageUrl.toString(),
                                type: 'banner',
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 5.h),
                    Center(
                      child: AnimatedSmoothIndicator(
                        onDotClicked: (index) {
                          _carouselController.jumpToPage(index);
                        },
                        activeIndex: _currentBannerIndex,
                        count: state.homeEntity.banners.length,
                        effect: const ExpandingDotsEffect(
                          spacing: 4,
                          radius: 5,
                          dotWidth: 5,
                          dotHeight: 5,
                          dotColor: AppColors.greyColor,
                          activeDotColor: AppColors.primaryBrand,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
                      child: Text(
                        'Danh mục',
                        style: AppTextStyle.primaryText().copyWith(color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 7.h),
                    SizedBox(
                      height: 135.h,
                      child: ListView.builder(
                        itemCount: state.homeEntity.categories.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: InkWell(
                              onTap: () {
                                context.router.push(
                                  ProductByCategoryPageRoute(
                                    categoryId: state.homeEntity.categories[index]!.id,
                                    categoryName: state.homeEntity.categories[index]!.name.toString(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.h),
                                child: Container(
                                  width: 115.h,
                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.r),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(9, 30, 66, 0.25),
                                        blurRadius: 8,
                                        spreadRadius: -2,
                                        offset: Offset(
                                          0,
                                          4,
                                        ),
                                      ),
                                      BoxShadow(
                                        color: Color.fromRGBO(9, 30, 66, 0.08),
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.homeEntity.categories[index]!.name.toString(),
                                        style: AppTextStyle.primaryText()
                                            .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 1.h),
                                      Flexible(
                                        child: Text(
                                          state.homeEntity.categories[index]!.description.toString(),
                                          style: AppTextStyle.smallText()
                                              .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10.r),
                                          child: ImageParse(
                                            width: 60.h,
                                            height: 60.h,
                                            url: state.homeEntity.categories[index]!.imageUrl,
                                            type: 'category',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
                      child: Text(
                        'Sản phẩm mới nhất',
                        style: AppTextStyle.primaryText().copyWith(color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ProductGridView(products: state.homeEntity.products),
                    SizedBox(height: AppSizes.paddingBottom),
                  ],
                );
              } else if (state is HomePageLoadingState) {
                return const LoadingPage();
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
