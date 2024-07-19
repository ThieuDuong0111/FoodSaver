import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/parse_utils.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/loading_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/no_data_found.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/features/search/presentation/bloc/search_bloc.dart';
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
  late SearchBloc _searchBloc;
  @override
  void initState() {
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backGroundColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
        title: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      context.router.pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: SizedBox(
                      height: 40.h,
                      child: TextField(
                        style: AppTextStyle.focusText(),
                        controller: _searchController,
                        decoration: AppCommonStyle.textFieldStyle(
                          hintText: 'Tìm sản phẩm',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  InkWell(
                    onTap: () {
                      _searchBloc.add(SearchByNamePageEvent(_searchController.text));
                    },
                    child: Text(
                      'Tìm',
                      style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w500),
                    ),
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
        child: ListView(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 10.h),
            BlocBuilder<SearchBloc, SearchState>(
              bloc: _searchBloc,
              builder: (context, state) {
                if (state is SearchByNamePageFinishedState) {
                  return state.listProductEntity.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.listProductEntity.length,
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            //Search Product Component
                            return InkWell(
                              onTap: () {
                                context.router.push(
                                  ProductDetailPageRoute(
                                    productId: state.listProductEntity[index].id,
                                    productName: state.listProductEntity[index].name!,
                                  ),
                                );
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
                                                      child: ImageParse(
                                                        width: 75.w,
                                                        height: 75.w,
                                                        url: state.listProductEntity[index].imageUrl,
                                                        type: 'product',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10.w),
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: 75.w,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          SizedBox(height: 3.h),
                                                          Expanded(
                                                            child: Text(
                                                              state.listProductEntity[index].name!.toString(),
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: AppTextStyle.primaryText()
                                                                  .copyWith(fontWeight: FontWeight.w500),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              state.listProductEntity[index].description!,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: AppTextStyle.primaryText().copyWith(
                                                                color: AppColors.greyColor,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: Text.rich(
                                                                    TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text: 'by ',
                                                                          style: AppTextStyle.primaryText()
                                                                              .copyWith(fontWeight: FontWeight.w400),
                                                                        ),
                                                                        TextSpan(
                                                                          text: state
                                                                              .listProductEntity[index].creator.name,
                                                                          style: AppTextStyle.primaryText().copyWith(
                                                                            color: const Color(0xFF03A33A),
                                                                            fontWeight: FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(width: 5.w),
                                                                Text(
                                                                  ParseUtils.formatCurrency(
                                                                    state.listProductEntity[index].price.toDouble(),
                                                                  ),
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: AppTextStyle.primaryText().copyWith(
                                                                    color: AppColors.primaryBrand,
                                                                  ),
                                                                ),
                                                                SizedBox(width: 8.w),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 3.h),
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
                        )
                      : const NoDataFound();
                } else if (state is SearchByNamePageLoadingState) {
                  return const LoadingPage();
                } else {
                  return const SizedBox();
                }
              },
            ),
            SizedBox(height: AppSizes.paddingBottom),
          ],
        ),
      ),
    );
  }
}
