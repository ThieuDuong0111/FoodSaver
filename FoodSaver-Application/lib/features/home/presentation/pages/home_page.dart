import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/parse_utils.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/validate_utils.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/loading_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/bloc/home_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/cart_items_count_notifier.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/user_info_notifier.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_service.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

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
  @override
  void initState() {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.add(const HomePageEvent());
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
                                    'Welcome to FoodSaver',
                                    style: AppTextStyle.primaryText()
                                        .copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    ValidateUtils.isNotNullOrEmpty(userinfo.imageUrl) ? userinfo.name! : 'User',
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
                        child: (ValidateUtils.isNotNullOrEmpty(userinfo.imageUrl))
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
                                onTap: () {},
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
                          Expanded(child: Text('Search for foods you like', style: AppTextStyle.hintText())),
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
                      child: Text(
                        'Categories',
                        style: AppTextStyle.primaryText().copyWith(color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 95.h,
                      child: ListView.builder(
                        itemCount: state.homeEntity.categories.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              context.router.push(
                                ProductByCategoryPageRoute(
                                  categoryId: state.homeEntity.categories[index]!.id,
                                  categoryName: state.homeEntity.categories[index]!.name.toString(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: ImageParse(
                                        width: 70.h,
                                        height: 70.h,
                                        url: state.homeEntity.categories[index]!.imageUrl,
                                        type: 'category',
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      state.homeEntity.categories[index]!.name.toString(),
                                      style: AppTextStyle.primaryText()
                                          .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 14.w),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
                      child: Text(
                        'Top Products',
                        style: AppTextStyle.primaryText().copyWith(color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: AppSizes.homeCrossAxisSpacing,
                        mainAxisSpacing: AppSizes.homeMainAxisSpacing,
                        childAspectRatio: 150 / 201,
                      ),
                      itemCount: state.homeEntity.products.length,
                      itemBuilder: (context, index) {
                        //Home Product Component
                        return InkWell(
                          onTap: () {
                            context.router.push(
                              ProductDetailPageRoute(
                                productId: state.homeEntity.products[index]!.id,
                                productName: state.homeEntity.products[index]!.name.toString(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(color: const Color(0xFFD2C7C7), width: 1.w),
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.r),
                                    topRight: Radius.circular(15.r),
                                  ),
                                  child: ImageParse(
                                    width: AppSizes.homeProductImageSize(context),
                                    height: AppSizes.homeProductImageSize(context),
                                    url: state.homeEntity.products[index]!.imageUrl,
                                    type: 'product',
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
                                            state.homeEntity.products[index]!.name.toString(),
                                            style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w400),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          ParseUtils.formatCurrency(state.homeEntity.products[index]!.price.toDouble()),
                                          style: AppTextStyle.primaryText()
                                              .copyWith(fontWeight: FontWeight.w400, color: AppColors.primaryBrand),
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
