import 'package:auto_route/auto_route.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/parse_utils.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/loading_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/no_data_found.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/presentation/bloc/product_detail_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_service.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_component.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class ProductByCategoryPage extends StatelessWidget {
  final int categoryId;
  final String categoryName;
  const ProductByCategoryPage({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductDetailBloc>(
      create: (context) => DependencyInjection.instance(),
      child: ProductByCategoryWrapper(
        categoryId: categoryId,
        categoryName: categoryName,
      ),
    );
  }
}

class ProductByCategoryWrapper extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  const ProductByCategoryWrapper({super.key, required this.categoryId, required this.categoryName});

  @override
  State<ProductByCategoryWrapper> createState() => _ProductByCategoryWrapperState();
}

class _ProductByCategoryWrapperState extends State<ProductByCategoryWrapper> {
  late ProductDetailBloc _productDetailBloc;

  @override
  void initState() {
    _productDetailBloc = BlocProvider.of<ProductDetailBloc>(context);
    _productDetailBloc.add(ProductByCategoryPageEvent(widget.categoryId));
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
        title: AppComponent.customAppBar(Colors.white, widget.categoryName, context),
        toolbarHeight: 50.h,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          bloc: _productDetailBloc,
          builder: (context, state) {
            if (state is ProductByCategoryPageFinishedState) {
              return state.listProductEntity.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 24.h),
                        GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: AppSizes.homeCrossAxisSpacing,
                            mainAxisSpacing: AppSizes.homeMainAxisSpacing,
                            childAspectRatio: 138 / 201,
                          ),
                          itemCount: state.listProductEntity.length,
                          itemBuilder: (context, index) {
                            //Home Product Component
                            return InkWell(
                              onTap: () {
                                context.router.push(
                                  ProductDetailPageRoute(
                                    productId: state.listProductEntity[index].id,
                                    productName: state.listProductEntity[index].name.toString(),
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
                                        url: state.listProductEntity[index].imageUrl,
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
                                                state.listProductEntity[index].name.toString(),
                                                style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w400),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            IgnorePointer(
                                              child: RatingBar(
                                                alignment: Alignment.center,
                                                size: 15.w,
                                                filledIcon: Icons.star,
                                                emptyIcon: Icons.star_border,
                                                onRatingChanged: (value) {},
                                                initialRating: state.listProductEntity[index].rating!,
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            Text(
                                              ParseUtils.formatCurrency(
                                                state.listProductEntity[index].price.toDouble(),
                                              ),
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
                    )
                  : const NoDataFound();
            } else if (state is ProductByCategoryPageLoadingState) {
              return const LoadingPage();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
