import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/presentation/bloc/category_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_service.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (context) => DependencyInjection.instance(),
      child: const CategoryWrapper(),
    );
  }
}

class CategoryWrapper extends StatefulWidget {
  const CategoryWrapper({
    super.key,
  });

  @override
  State<CategoryWrapper> createState() => _CategoryWrapperState();
}

class _CategoryWrapperState extends State<CategoryWrapper> {
  late CategoryBloc _categoryBloc;
  @override
  void initState() {
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    _categoryBloc.add(const CategoriesPageEvent());
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
        title: Center(child: Text('Categories', style: AppTextStyle.mediumTitle().copyWith(color: Colors.white))),
        toolbarHeight: 50.h,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<CategoryBloc, CategoryState>(
          bloc: _categoryBloc,
          builder: (context, state) {
            if (state is CategoriesPageFinishedState) {
              return Column(
                children: [
                  SizedBox(height: 24.h),
                  GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: AppSizes.categoryCrossAxisSpacing,
                      mainAxisSpacing: AppSizes.categoryMainAxisSpacing,
                      childAspectRatio: 153 / 201,
                    ),
                    itemCount: state.listCategories.length,
                    itemBuilder: (context, index) {
                      //Home Product Component
                      return InkWell(
                        onTap: () {
                          context.router.push(
                            ProductByCategoryPageRoute(
                              categoryId: state.listCategories[index].id,
                              categoryName: state.listCategories[index].name.toString(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                15.r,
                              ),
                              child: ImageParse(
                                width: AppSizes.homeProductImageSize(context),
                                height: AppSizes.homeProductImageSize(context),
                                url: state.listCategories[index].imageUrl,
                                type: 'category',
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
                                        state.listCategories[index].name.toString(),
                                        style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w400),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: AppSizes.paddingBottom),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
