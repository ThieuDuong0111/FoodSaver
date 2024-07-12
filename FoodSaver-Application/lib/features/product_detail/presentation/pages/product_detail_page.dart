import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/presentation/bloc/product_detail_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/resources/assets.gen.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_component.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class ProductDetailPage extends StatelessWidget {
  final int productId;
  final String productName;
  const ProductDetailPage({
    Key? key,
    required this.productId,
    required this.productName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductDetailBloc>(
      create: (context) => DependencyInjection.instance(),
      child: ProductDetailWrapper(
        productId: productId,
        productName: productName,
      ),
    );
  }
}

class ProductDetailWrapper extends StatefulWidget {
  final int productId;
  final String productName;
  const ProductDetailWrapper({super.key, required this.productId, required this.productName});

  @override
  State<ProductDetailWrapper> createState() => _ProductDetailWrapperState();
}

class _ProductDetailWrapperState extends State<ProductDetailWrapper> {
  int count = 1;
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
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
        title: AppComponent.customAppBar(Colors.black, widget.productName, context),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.asset(
                      Assets.images.foodImage.path,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text('Hamburger Cheese', style: AppTextStyle.mediumTitle()),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Text(
                      '235,000VND',
                      style: AppTextStyle.mediumTitle().copyWith(color: AppColors.primaryBrand),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'by ',
                              style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text: 'Foodiesfeed',
                              style: AppTextStyle.primaryText()
                                  .copyWith(color: const Color(0xFF03A33A), fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (count > 1) {
                                  count--;
                                }
                              });
                            },
                            child: const Icon(
                              Icons.remove_circle,
                              color: AppColors.primaryBrand,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            count.toString(),
                            style: AppTextStyle.primaryText().copyWith(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 8.w),
                          InkWell(
                            onTap: () {
                              setState(() {
                                count++;
                              });
                            },
                            child: const Icon(
                              Icons.add_circle,
                              color: AppColors.primaryBrand,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  style: AppTextStyle.primaryText(),
                ),
                SizedBox(
                  height: AppSizes.buttonHeight + 24.h,
                ),
                SizedBox(height: AppSizes.paddingBottom),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: AppColors.greyColor,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: AppSizes.paddingHorizontal,
              ),
              height: AppSizes.buttonHeight + 24.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(AppColors.primaryBrand),
                  shape: WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius),
                    ),
                  ),
                ),
                child: Text('ADD TO CART', style: AppTextStyle.primaryText().copyWith(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
