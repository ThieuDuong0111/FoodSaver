import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/validate_utils.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/user_info_notifier.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/resources/assets.gen.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_service.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_dialog.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyProfileBloc>(
      create: (context) => DependencyInjection.instance(),
      child: const MyProfileWrapper(),
    );
  }
}

class MyProfileWrapper extends StatefulWidget {
  const MyProfileWrapper({super.key});

  @override
  State<MyProfileWrapper> createState() => _MyProfileWrapperState();
}

class _MyProfileWrapperState extends State<MyProfileWrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyProfileBloc, MyProfileState>(
      listener: (context, state) {
        if (state is SignOutFinishedState) {
          context.router.replace(const SignInPageRoute());
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.primaryBrand,
          systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
          toolbarHeight: 0.h,
          titleSpacing: 0,
        ),
        body: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: AppSizes.paddingHorizontal,
                      right: AppSizes.paddingHorizontal,
                      top: 12.h,
                      bottom: 63.h,
                    ),
                    width: double.infinity,
                    color: AppColors.primaryBrand,
                    child: Text('My Profile', style: AppTextStyle.bigTitle().copyWith(color: Colors.white)),
                  ),
                  SizedBox(height: 62.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
                    child: Consumer(
                      builder: (context, ref, child) {
                        final UserEntity userinfo = ref.watch(UserInfoNotifier.provider).userInfo;

                        return Column(
                          children: [
                            //Order History
                            if (ValidateUtils.isLogined(userinfo))
                              InkWell(
                                onTap: () {
                                  context.router.push(const OrderHistoryPageRoute());
                                },
                                child: Column(
                                  children: [
                                    SizedBox(height: 18.h),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  Assets.images.activityHistory.path,
                                                  width: 24.w,
                                                  fit: BoxFit.fitWidth,
                                                ),
                                                SizedBox(width: 10.w),
                                                Text('Order History', style: AppTextStyle.primaryText()),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          Icon(
                                            Icons.navigate_next,
                                            size: 24.w,
                                            color: AppColors.greyColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Container(
                                      width: double.infinity,
                                      height: 1.h,
                                      color: const Color(0xFFD9D9D9),
                                    ),
                                  ],
                                ),
                              ),
                            //Customer support
                            InkWell(
                              onTap: () {
                                context.router.push(const CustomerSupportPageRoute());
                              },
                              child: Column(
                                children: [
                                  SizedBox(height: 18.h),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                Assets.images.helpingHand.path,
                                                width: 24.w,
                                                fit: BoxFit.fitWidth,
                                              ),
                                              SizedBox(width: 10.w),
                                              Text('Customer support', style: AppTextStyle.primaryText()),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 5.w),
                                        Icon(
                                          Icons.navigate_next,
                                          size: 24.w,
                                          color: AppColors.greyColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Container(
                                    width: double.infinity,
                                    height: 1.h,
                                    color: const Color(0xFFD9D9D9),
                                  ),
                                ],
                              ),
                            ),
                            // About this app
                            InkWell(
                              onTap: () {
                                context.router.push(const AboutPageRoute());
                              },
                              child: Column(
                                children: [
                                  SizedBox(height: 18.h),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                Assets.images.info.path,
                                                width: 24.w,
                                                fit: BoxFit.fitWidth,
                                              ),
                                              SizedBox(width: 10.w),
                                              Text('About this app', style: AppTextStyle.primaryText()),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 5.w),
                                        Icon(
                                          Icons.navigate_next,
                                          size: 24.w,
                                          color: AppColors.greyColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Container(
                                    width: double.infinity,
                                    height: 1.h,
                                    color: const Color(0xFFD9D9D9),
                                  ),
                                ],
                              ),
                            ),
                            //Sign out
                            if (ValidateUtils.isLogined(userinfo))
                              InkWell(
                                onTap: () {
                                  AppDialog.showAppDialog(
                                    context: context,
                                    content: 'Are you sure you want to sign out?',
                                    buttonName: 'Yes',
                                    action: () {
                                      BlocProvider.of<MyProfileBloc>(context).add(const SignOutEvent());
                                    },
                                  );
                                },
                                child: Column(
                                  children: [
                                    SizedBox(height: 18.h),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  Assets.images.logout.path,
                                                  width: 24.w,
                                                  fit: BoxFit.fitWidth,
                                                ),
                                                SizedBox(width: 10.w),
                                                Text('Sign out', style: AppTextStyle.primaryText()),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          Icon(
                                            Icons.navigate_next,
                                            size: 24.w,
                                            color: AppColors.greyColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Container(
                                      width: double.infinity,
                                      height: 1.h,
                                      color: const Color(0xFFD9D9D9),
                                    ),
                                  ],
                                ),
                              )
                            else
                              InkWell(
                                onTap: () {
                                  AppDialog.showAppDialog(
                                    context: context,
                                    content: 'Are you sure you want to log in?',
                                    buttonName: 'Yes',
                                    action: () {
                                      context.router.replace(const SignInPageRoute());
                                    },
                                  );
                                },
                                child: Column(
                                  children: [
                                    SizedBox(height: 18.h),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.login,
                                                  size: 24.w,
                                                  color: AppColors.greyColor,
                                                ),
                                                SizedBox(width: 10.w),
                                                Text('Login', style: AppTextStyle.primaryText()),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          Icon(
                                            Icons.navigate_next,
                                            size: 24.w,
                                            color: AppColors.greyColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Container(
                                      width: double.infinity,
                                      height: 1.h,
                                      color: const Color(0xFFD9D9D9),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: AppSizes.paddingBottom),
                ],
              ),
            ),
            Positioned(
              top: 60.h,
              left: AppSizes.paddingHorizontal,
              right: AppSizes.paddingHorizontal,
              child: Consumer(
                builder: (context, ref, child) {
                  final UserEntity userinfo = ref.watch(UserInfoNotifier.provider).userInfo;
                  return InkWell(
                    onTap: () {
                      if (ValidateUtils.isLogined(userinfo)) {
                        context.router.push(const EditProfilePageRoute());
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(offset: const Offset(0, 4), blurRadius: 4, color: Colors.black.withOpacity(0.25)),
                        ],
                      ),
                      // padding: EdgeInsets.symmetric(vertical: AppSizes.paddingHorizontal),
                      child: Column(
                        children: [
                          SizedBox(height: 6.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (ValidateUtils.isLogined(userinfo))
                                Icon(
                                  Icons.create_rounded,
                                  color: AppColors.greyColor,
                                  size: 20.w,
                                )
                              else
                                SizedBox(height: 20.w),
                              SizedBox(width: 10.h),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: 16.w),
                              if (ValidateUtils.isNotNullOrEmpty(userinfo.imageUrl))
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(65.w),
                                  child: ImageParse(width: 65.w, height: 65.w, url: userinfo.imageUrl, type: 'user'),
                                )
                              else
                                Icon(
                                  Icons.account_circle,
                                  size: 65.w,
                                  color: AppColors.greyColor,
                                ),
                              SizedBox(width: 7.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ValidateUtils.isLogined(userinfo) ? userinfo.name! : 'Your name',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyle.mediumTitle().copyWith(),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      ValidateUtils.isLogined(userinfo) ? userinfo.email! : 'Your email',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyle.primaryText().copyWith(color: AppColors.greyColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSizes.paddingHorizontal),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
