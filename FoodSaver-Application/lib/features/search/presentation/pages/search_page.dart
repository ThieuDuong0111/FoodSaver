import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/Search/presentation/bloc/search_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/resources/assets.gen.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_service.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_common_style.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) => DependencyInjection.instance(),
      child: const SearchWrapper(),
    );
  }
}

class SearchWrapper extends StatefulWidget {
  const SearchWrapper({super.key});

  @override
  State<SearchWrapper> createState() => _SearchWrapperState();
}

class _SearchWrapperState extends State<SearchWrapper> {
  late final TextEditingController _searchController;
  int length = 24;
  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
        title: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
              child: Row(
                children: [
                  // const Icon(
                  //   Icons.arrow_back_ios,
                  //   color: Colors.black,
                  // ),
                  // SizedBox(width: 5.w),
                  Expanded(
                    child: SizedBox(
                      height: 40.h,
                      child: TextField(
                        style: AppTextStyle.focusText(),
                        controller: _searchController,
                        decoration: AppCommonStyle.textFieldStyle(
                          hintText: 'Search foods you want',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    'Search',
                    style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Container(
              width: double.infinity,
              height: 1.h,
              color: const Color(0xFFD9D9D9),
            ),
          ],
        ),
        toolbarHeight: 75.h,
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
        child: length > 0
            ? ListView(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  ListView.builder(
                    itemCount: length,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      //Search Product Component
                      return InkWell(
                        onTap: () {
                          context.router.push(ProductDetailPageRoute(productId: 1, productName: ''));
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0XFF000000).withOpacity(0.25),
                                    blurRadius: 3,
                                    offset: const Offset(3, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10.r),
                                                  bottomLeft: Radius.circular(10.r),
                                                ),
                                                child: Image.asset(
                                                  Assets.images.foodImage.path,
                                                  height: 60.w,
                                                  width: 60.w,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            Expanded(
                                              child: SizedBox(
                                                height: 60.w,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(height: 4.h),
                                                    Expanded(
                                                      child: Text(
                                                        'Hamburger Cheese',
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: AppTextStyle.primaryText()
                                                            .copyWith(fontWeight: FontWeight.w500),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text.rich(
                                                            TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: 'by ',
                                                                  style: AppTextStyle.primaryText()
                                                                      .copyWith(fontWeight: FontWeight.w500),
                                                                ),
                                                                TextSpan(
                                                                  text: 'Foodiesfeed',
                                                                  style: AppTextStyle.primaryText().copyWith(
                                                                    color: const Color(0xFF03A33A),
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 5.w),
                                                        Text(
                                                          '235,000VND',
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: AppTextStyle.primaryText().copyWith(
                                                            color: AppColors.primaryBrand,
                                                          ),
                                                        ),
                                                        SizedBox(width: 8.w),
                                                      ],
                                                    ),
                                                    SizedBox(height: 4.h),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: AppSizes.paddingBottom),
                ],
              )
            : const SizedBox(),
      ),
    );
  }
}
