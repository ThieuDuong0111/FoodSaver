import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/user_info_notifier.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/resources/assets.gen.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_common_style.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_component.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditProfileBloc>(
      create: (context) => DependencyInjection.instance(),
      child: const EditProfileWrapper(),
    );
  }
}

class EditProfileWrapper extends StatefulWidget {
  const EditProfileWrapper({super.key});

  @override
  State<EditProfileWrapper> createState() => _EditProfileWrapperState();
}

class _EditProfileWrapperState extends State<EditProfileWrapper> {
  late final TextEditingController _emailController;
  final bool _hasEmailError = false;
  late final TextEditingController _phoneController;
  final bool _hasPhoneError = false;
  late final TextEditingController _addressController;
  final bool _hasAddressError = false;
  @override
  void initState() {
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
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
        title: AppComponent.customAppBar(Colors.white, 'Edit Profile', context),
        toolbarHeight: 50.h,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal),
        child: Consumer(
          builder: (context, ref, child) {
            final UserEntity userinfo = ref.watch(UserInfoNotifier.provider).userInfo;
            _emailController.text = userinfo.email!;
            _phoneController.text = userinfo.phone!;
            _addressController.text = userinfo.address!;
            return Column(
              children: [
                SizedBox(height: 15.h),
                Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.w),
                        child: ImageParse(width: 100.w, height: 100.w, url: userinfo.imageUrl, type: 'user'),
                      ),
                      Positioned(
                        bottom: 2.h,
                        right: 2.h,
                        child: Container(
                          height: 24.w,
                          width: 24.w,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(80.w),
                          ),
                          padding: EdgeInsets.all(5.w),
                          child: Image.asset(
                            Assets.images.camera.path,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: AppTextStyle.labelText(),
                    ),
                    SizedBox(
                      height: AppSizes.spaceBetweenLabelAndForm,
                    ),
                    TextField(
                      style: AppTextStyle.focusText(),
                      controller: _emailController,
                      decoration: AppCommonStyle.textFieldStyle(
                        hasError: _hasEmailError,
                        hintText: 'Enter your email',
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.spaceBetweenFormAndForm,
                    ),
                    Text(
                      'Phone Number',
                      style: AppTextStyle.labelText(),
                    ),
                    SizedBox(
                      height: AppSizes.spaceBetweenLabelAndForm,
                    ),
                    TextField(
                      style: AppTextStyle.focusText(),
                      controller: _phoneController,
                      decoration: AppCommonStyle.textFieldStyle(
                        hasError: _hasPhoneError,
                        hintText: 'Enter your phone number',
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.spaceBetweenFormAndForm,
                    ),
                    Text(
                      'Address',
                      style: AppTextStyle.labelText(),
                    ),
                    SizedBox(
                      height: AppSizes.spaceBetweenLabelAndForm,
                    ),
                    TextField(
                      style: AppTextStyle.focusText(),
                      controller: _addressController,
                      decoration: AppCommonStyle.textFieldStyle(
                        hasError: _hasAddressError,
                        hintText: 'Enter your address',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppSizes.spaceBetweenFormAndForm,
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  width: double.infinity,
                  height: AppSizes.buttonHeight,
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
                    child: Text('SAVE CHANGES', style: AppTextStyle.primaryText().copyWith(color: Colors.white)),
                  ),
                ),
                SizedBox(height: AppSizes.paddingBottom),
              ],
            );
          },
        ),
      ),
    );
  }
}
