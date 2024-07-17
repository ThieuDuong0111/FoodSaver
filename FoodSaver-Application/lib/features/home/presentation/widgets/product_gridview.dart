import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/parse_utils.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/validate_utils.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_service.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class ProductGridView extends StatelessWidget {
  final List<ProductEntity?> products;
  const ProductGridView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSizes.homeCrossAxisSpacing,
        mainAxisSpacing: AppSizes.homeMainAxisSpacing,
        childAspectRatio: 138 / 201,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        //Home Product Component
        return InkWell(
          onTap: () {
            context.router.push(
              ProductDetailPageRoute(
                productId: products[index]!.id,
                productName: products[index]!.name.toString(),
              ),
            );
          },
          child: Container(
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
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r),
                  ),
                  child: ImageParse(
                    width: AppSizes.homeProductImageSize(context),
                    height: AppSizes.homeProductImageSize(context),
                    url: products[index]!.imageUrl,
                    type: 'product',
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  products[index]!.name.toString(),
                                  style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16.w,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    products[index]!.rating.toString(),
                                    style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w400),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text.rich(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'bởi ',
                                      style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w400),
                                    ),
                                    TextSpan(
                                      text: products[index]!.creator.name,
                                      style: AppTextStyle.primaryText().copyWith(
                                        color: const Color(0xFF03A33A),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 3.w),
                            if (ValidateUtils.isNotNullOrEmpty(products[index]!.creator.imageUrl))
                              ClipRRect(
                                borderRadius: BorderRadius.circular(18.w),
                                child: ImageParse(
                                  width: 18.w,
                                  height: 18.w,
                                  url: products[index]!.creator.imageUrl,
                                  type: 'user',
                                ),
                              )
                            else
                              Icon(
                                Icons.account_circle,
                                size: 18.w,
                                color: AppColors.greyColor,
                              ),
                          ],
                        ),
                        SizedBox(height: 3.h),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                ParseUtils.formatCurrency(products[index]!.price.toDouble()),
                                style: AppTextStyle.primaryText()
                                    .copyWith(fontWeight: FontWeight.w500, color: AppColors.primaryBrand),
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              '(${products[index]!.unit.name})',
                              style:
                                  AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w400, color: Colors.black),
                            ),
                          ],
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
    );
  }
}
