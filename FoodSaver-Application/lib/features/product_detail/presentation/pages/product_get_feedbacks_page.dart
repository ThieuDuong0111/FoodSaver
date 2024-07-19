import 'package:auto_route/auto_route.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/parse_utils.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/validate_utils.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/loading_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/no_data_found.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/toast_widget.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/user_info_notifier.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/add_feedback_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/presentation/bloc/product_detail_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_service.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_component.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_dialog.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class ProductGetFeedBacksPage extends StatelessWidget {
  final int productId;

  const ProductGetFeedBacksPage({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductDetailBloc>(
      create: (context) => DependencyInjection.instance(),
      child: ProductGetFeedBacksWrapper(
        productId: productId,
      ),
    );
  }
}

class ProductGetFeedBacksWrapper extends StatefulWidget {
  final int productId;

  const ProductGetFeedBacksWrapper({super.key, required this.productId});

  @override
  State<ProductGetFeedBacksWrapper> createState() => _ProductGetFeedBacksWrapperState();
}

class _ProductGetFeedBacksWrapperState extends State<ProductGetFeedBacksWrapper> {
  late TextEditingController _feedBackController;
  late ProductDetailBloc _productDetailBloc;
  late FToast fToast;
  double rating = 1;

  @override
  void initState() {
    _productDetailBloc = BlocProvider.of<ProductDetailBloc>(context);
    _productDetailBloc.add(ProductGetFeedBacksEvent(widget.productId));
    _feedBackController = TextEditingController();
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
        titleSpacing: AppSizes.paddingHorizontal,
        backgroundColor: AppColors.primaryBrand,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
        title: AppComponent.customAppBar(Colors.white, 'Feedbacks', context),
        toolbarHeight: 50.h,
      ),
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, ref, child) {
            final UserEntity userinfo = ref.watch(UserInfoNotifier.provider).userInfo;
            return BlocConsumer<ProductDetailBloc, ProductDetailState>(
              listener: (context, state) {
                if (state is ProductAddFeedBackFinishedState) {
                  _productDetailBloc.add(ProductGetFeedBacksEvent(widget.productId));
                  _feedBackController.text = '';
                  context.router.pop();
                  fToast.showToast(child: const ToastWidget(message: 'Thêm bình luận thành công'));
                }
                if (state is ProductAddFeedBackErrorState) {
                  _productDetailBloc.add(ProductGetFeedBacksEvent(widget.productId));
                  _feedBackController.text = '';
                  context.router.pop();
                  fToast.showToast(child: const ToastWidget(message: 'Đã có lỗi xảy ra. Vui lòng thử lại!'));
                }
              },
              bloc: _productDetailBloc,
              builder: (context, state) {
                if (state is ProductGetFeedBacksFinishedState) {
                  return Column(
                    children: [
                      SizedBox(height: 15.h),
                      InkWell(
                        onTap: () {
                          if (ValidateUtils.isLogined(userinfo)) {
                            final AlertDialog alert = AlertDialog(
                              insetPadding: EdgeInsets.zero,
                              titlePadding: EdgeInsets.zero,
                              buttonPadding: EdgeInsets.zero,
                              actionsPadding: EdgeInsets.zero,
                              contentPadding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              content: Padding(
                                padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  padding: EdgeInsets.all(20.w),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: _feedBackController,
                                      ),
                                      SizedBox(height: 18.h),
                                      RatingBar(
                                        size: 20.w,
                                        filledIcon: Icons.star,
                                        emptyIcon: Icons.star_border,
                                        onRatingChanged: (value) {
                                          rating = value;
                                        },
                                        initialRating: rating,
                                      ),
                                      SizedBox(height: 18.h),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              height: 30.h,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  _productDetailBloc.add(
                                                    ProductAddFeedBackEvent(
                                                      AddFeedBackRequest(
                                                        userId: userinfo.id,
                                                        productId: widget.productId,
                                                        comment: _feedBackController.text,
                                                        rating: rating.toInt(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStateProperty.all<Color>(AppColors.primaryBrand),
                                                  shape: WidgetStateProperty.all<OutlinedBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius),
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Xác nhận',
                                                  style: AppTextStyle.primaryText().copyWith(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            SizedBox(
                                              width: double.infinity,
                                              height: 30.h,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  context.router.pop();
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                                                  shape: WidgetStateProperty.all<OutlinedBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius),
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Quay lại',
                                                  style: AppTextStyle.primaryText().copyWith(color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );

                            showDialog(
                              context: context,
                              builder: (context) {
                                return alert;
                              },
                            );
                          } else {
                            AppDialog.showAppDialog(
                              context: context,
                              content: 'Bạn hãy đăng nhập để sử dụng tính năng này. Quay lại trang đăng nhập?',
                              buttonName: 'Đồng ý',
                              action: () {
                                context.router.pushAndPopUntil(
                                  const SignInPageRoute(),
                                  predicate: (_) => false,
                                );
                              },
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
                          child: Text(
                            'Viết bình luận cho sản phẩm này',
                            style: AppTextStyle.primaryText().copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      if (state.listFeedBacksEntity.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 15.h),
                            ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: state.listFeedBacksEntity.length,
                              itemBuilder: (context, index) {
                                //Home Product Component
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              if (ValidateUtils.isNotNullOrEmpty(
                                                state.listFeedBacksEntity[index].userFeedBacks.imageUrl,
                                              ))
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(20.w),
                                                  child: ImageParse(
                                                    width: 35.w,
                                                    height: 35.w,
                                                    url: state.listFeedBacksEntity[index].userFeedBacks.imageUrl,
                                                    type: 'user',
                                                  ),
                                                )
                                              else
                                                Icon(
                                                  Icons.account_circle,
                                                  size: 35.w,
                                                  color: AppColors.greyColor,
                                                ),
                                              SizedBox(width: 8.w),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      state.listFeedBacksEntity[index].userFeedBacks.name.toString(),
                                                      style: AppTextStyle.smallText()
                                                          .copyWith(fontWeight: FontWeight.w500),
                                                    ),
                                                    Row(
                                                      children: [
                                                        IgnorePointer(
                                                          child: RatingBar(
                                                            size: 15.w,
                                                            filledIcon: Icons.star,
                                                            emptyIcon: Icons.star_border,
                                                            onRatingChanged: (value) {},
                                                            initialRating:
                                                                state.listFeedBacksEntity[index].rating.toDouble(),
                                                          ),
                                                        ),
                                                        SizedBox(width: 2.w),
                                                        Text(
                                                          '(${state.listFeedBacksEntity[index].rating.toInt()}/5)',
                                                          style: AppTextStyle.smallText()
                                                              .copyWith(fontWeight: FontWeight.w400),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          ParseUtils.formatDateTime(
                                            state.listFeedBacksEntity[index].publishedDate.toString(),
                                          ),
                                          style: AppTextStyle.smallText().copyWith(fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      state.listFeedBacksEntity[index].comment.toString(),
                                      style: AppTextStyle.smallText().copyWith(fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(height: 15.h),
                                  ],
                                );
                              },
                            ),
                            SizedBox(height: AppSizes.paddingBottom),
                          ],
                        )
                      else
                        const NoDataFound(),
                    ],
                  );
                } else if (state is ProductGetFeedBacksLoadingState) {
                  return const LoadingPage();
                } else {
                  return const SizedBox();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
