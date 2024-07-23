import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/loading_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/features/store/presentation/bloc/store_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_service.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class StorePage extends StatelessWidget {
  const StorePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StoreBloc>(
      create: (context) => DependencyInjection.instance(),
      child: const StoreWrapper(),
    );
  }
}

class StoreWrapper extends StatefulWidget {
  const StoreWrapper({
    super.key,
  });

  @override
  State<StoreWrapper> createState() => _StoreWrapperState();
}

class _StoreWrapperState extends State<StoreWrapper> {
  late StoreBloc _storeBloc;
  @override
  void initState() {
    super.initState();
    _storeBloc = BlocProvider.of<StoreBloc>(context);
    _storeBloc.add(const StoresPageEvent());
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
        title:
            Center(child: Text('Danh sách cửa hàng', style: AppTextStyle.mediumTitle().copyWith(color: Colors.white))),
        toolbarHeight: 50.h,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<StoreBloc, StoreState>(
          bloc: _storeBloc,
          builder: (context, state) {
            if (state is StoresPageFinishedState) {
              return Column(
                children: [
                  SizedBox(height: 12.h),
                  GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppSizes.storeCrossAxisSpacing,
                      mainAxisSpacing: AppSizes.storeMainAxisSpacing,
                      childAspectRatio: 150 / 201,
                    ),
                    itemCount: state.listStores.length,
                    itemBuilder: (context, index) {
                      //Home Product Component
                      return InkWell(
                        onTap: () {
                          context.router.push(ProductByStorePageRoute(storeId: state.listStores[index].id));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
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
                                Align(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.r),
                                      topRight: Radius.circular(12.r),
                                    ),
                                    child: ImageParse(
                                      width: AppSizes.storeImageSize(context),
                                      height: AppSizes.storeImageSize(context),
                                      url: state.listStores[index].storeImageUrl,
                                      type: 'store',
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.verified_user,
                                          color: Colors.orangeAccent,
                                          size: 15.w,
                                        ),
                                        SizedBox(width: 5.w),
                                        Flexible(
                                          child: Text(
                                            '${state.listStores[index].storeName}',
                                            style: AppTextStyle.primaryText()
                                                .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: AppSizes.paddingBottom),
                ],
              );
            } else if (state is StoresPageLoadingState) {
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
