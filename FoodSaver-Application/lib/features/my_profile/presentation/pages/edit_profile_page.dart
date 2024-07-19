import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/validate_utils.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/toast_widget.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/user_info_notifier.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_update_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/usecases/edit_info_usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/resources/assets.gen.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_common_style.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_component.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyProfileBloc>(
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
  XFile? _imageFile;
  late MyProfileBloc _myProfileBloc;
  late FToast fToast;
  @override
  void initState() {
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _myProfileBloc = BlocProvider.of<MyProfileBloc>(context);
    fToast = FToast();
    fToast.init(context);
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
        title: AppComponent.customAppBar(Colors.white, 'Cập nhật tài khoản', context),
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
            return BlocConsumer<MyProfileBloc, MyProfileState>(
              bloc: _myProfileBloc,
              listener: (context, state) {
                if (state is EditInfoFinishedState) {
                  final UserInfoNotifier userInfoUpdate = ref.read(UserInfoNotifier.provider);
                  userInfoUpdate.setUserInfo(
                    UserEntity(
                      id: state.userEntity.id,
                      name: state.userEntity.name,
                      imageUrl: state.userEntity.imageUrl,
                      email: state.userEntity.email,
                      phone: state.userEntity.phone,
                      address: state.userEntity.address,
                      storeName: '',
                      storeImageUrl: '',
                      storeDescription: '',
                    ),
                  );
                  setState(() {
                    _emailController.text = state.userEntity.email!;
                    _phoneController.text = state.userEntity.phone!;
                    _addressController.text = state.userEntity.address!;
                    _imageFile = null;
                  });
                  fToast.showToast(child: const ToastWidget(message: 'Cập nhật thông tin thành công.'));
                }
                if (state is EditInfoErrorState) {
                  setState(() {
                    _emailController.text = userinfo.email!;
                    _phoneController.text = userinfo.phone!;
                    _addressController.text = userinfo.address!;
                    _imageFile = null;
                  });
                  fToast.showToast(child: const ToastWidget(message: 'Đã có lỗi xảy ra. Vui lòng thử lại!'));
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(height: 15.h),
                    Align(
                      alignment: Alignment.topCenter,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.all(20.w),
                                width: double.infinity,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        final ImagePicker picker = ImagePicker();
                                        final XFile? image = await picker.pickImage(
                                          source: ImageSource.camera,
                                        );
                                        if (image != null) {
                                          setState(() {
                                            _imageFile = image;
                                          });
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(Icons.camera_alt),
                                          SizedBox(width: 10.w),
                                          Expanded(
                                            child: Text(
                                              'Chụp ảnh',
                                              style: AppTextStyle.primaryText(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15.h),
                                    InkWell(
                                      onTap: () async {
                                        final ImagePicker picker = ImagePicker();
                                        final XFile? image = await picker.pickImage(
                                          source: ImageSource.gallery,
                                        );
                                        if (image != null) {
                                          setState(() {
                                            _imageFile = image;
                                          });
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(Icons.image),
                                          SizedBox(width: 10.w),
                                          Expanded(
                                            child: Text(
                                              'Bộ sưu tập',
                                              style: AppTextStyle.primaryText(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.w),
                              child: _imageFile != null
                                  ? Image.file(File(_imageFile!.path), width: 100.w, height: 100.w)
                                  : ValidateUtils.isLogined(userinfo)
                                      ? ImageParse(width: 100.w, height: 100.w, url: userinfo.imageUrl, type: 'user')
                                      : Icon(
                                          Icons.account_circle,
                                          size: 40.w,
                                          color: AppColors.greyColor,
                                        ),
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
                            hintText: 'Nhập emial',
                          ),
                        ),
                        SizedBox(
                          height: AppSizes.spaceBetweenFormAndForm,
                        ),
                        Text(
                          'Số điện thoại',
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
                            hintText: 'Nhập số điện thoại',
                          ),
                        ),
                        SizedBox(
                          height: AppSizes.spaceBetweenFormAndForm,
                        ),
                        Text(
                          'Địa chỉ',
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
                            hintText: 'Nhập địa chỉ',
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
                        onPressed: () {
                          _myProfileBloc.add(
                            EditInfoEvent(
                              userUpdatePrams: UserUpdatePrams(
                                avatar: _imageFile == null ? null : File(_imageFile!.path),
                                userUpdateRequest: UserUpdateRequest(
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                  address: _addressController.text,
                                ),
                              ),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(AppColors.primaryBrand),
                          shape: WidgetStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius),
                            ),
                          ),
                        ),
                        child: Text('LƯU', style: AppTextStyle.primaryText().copyWith(color: Colors.white)),
                      ),
                    ),
                    SizedBox(height: AppSizes.paddingBottom),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
