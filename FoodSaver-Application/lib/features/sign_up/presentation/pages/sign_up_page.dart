import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/validate_utils.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/toast_widget.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/domain/entities/sign_up_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/service/navigation_service.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_common_style.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => DependencyInjection.instance(),
      child: const SignUpWrapper(),
    );
  }
}

class SignUpWrapper extends StatefulWidget {
  const SignUpWrapper({super.key});

  @override
  State<SignUpWrapper> createState() => _SignUpWrapperState();
}

class _SignUpWrapperState extends State<SignUpWrapper> {
  late final TextEditingController _usernameController;
  bool hasUsernameError = false;
  String nameError = '';
  late final TextEditingController _passwordController;
  bool _isPasswordObscure = true;
  bool hasPasswordError = false;
  String passwordError = '';
  late final TextEditingController _rePasswordController;
  bool _isRePasswordObscure = true;
  bool hasRePasswordError = false;
  String rePasswordError = '';
  late final TextEditingController _emailController;
  bool hasEmailError = false;
  String emaildError = '';
  late final TextEditingController _phoneController;
  bool hasPhoneError = false;
  String phoneError = '';
  late final TextEditingController _addressController;
  bool hasAddressError = false;
  String addressError = '';
  late FToast fToast;
  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _rePasswordController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
        ),
      ),
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSubmitLoadingState) {}
          if (state is SignUpSubmitErrorState) {
            setState(() {
              //name
              hasUsernameError = ValidateUtils.isNotNullOrEmpty(state.signUpEntity.nameError);
              nameError = ValidateUtils.parseError(state.signUpEntity.nameError);
              //password
              hasPasswordError = ValidateUtils.isNotNullOrEmpty(state.signUpEntity.passwordError);
              passwordError = ValidateUtils.parseError(state.signUpEntity.passwordError);
              //confirm-password
              hasRePasswordError = ValidateUtils.isNotNullOrEmpty(state.signUpEntity.confirmPasswordError);
              rePasswordError = ValidateUtils.parseError(state.signUpEntity.confirmPasswordError);
              //email
              hasEmailError = ValidateUtils.isNotNullOrEmpty(state.signUpEntity.emailError);
              emaildError = ValidateUtils.parseError(state.signUpEntity.emailError);
              //phone
              hasPhoneError = ValidateUtils.isNotNullOrEmpty(state.signUpEntity.phoneError);
              phoneError = ValidateUtils.parseError(state.signUpEntity.phoneError);
              //address
              hasAddressError = ValidateUtils.isNotNullOrEmpty(state.signUpEntity.addressError);
              addressError = ValidateUtils.parseError(state.signUpEntity.addressError);
            });
          }
          if (state is SignUpSubmitFinishedState) {
            setState(() {
              hasUsernameError = false;
              hasPasswordError = false;
              hasRePasswordError = false;
              hasEmailError = false;
              hasPhoneError = false;
              hasAddressError = false;
            });
            fToast.showToast(child: const ToastWidget(message: 'Đăng ký thành công'));
            context.router.replace(const SignInPageRoute());
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.paddingHorizontal),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Đăng ký',
                  style: AppTextStyle.bigTitle(),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Tên',
                  style: AppTextStyle.labelText().copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: AppSizes.spaceBetweenLabelAndForm,
                ),
                TextField(
                  style: AppTextStyle.focusText(),
                  controller: _usernameController,
                  decoration: AppCommonStyle.textFieldStyle(
                    hasError: hasUsernameError,
                    hintText: 'Nhập tên người dùng',
                  ),
                ),
                if (hasUsernameError)
                  Text(nameError, style: AppTextStyle.primaryText().copyWith(color: AppColors.textFieldError))
                else
                  const SizedBox(),
                SizedBox(
                  height: AppSizes.spaceBetweenFormAndForm,
                ),
                Text(
                  'Mật khẩu',
                  style: AppTextStyle.labelText().copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: AppSizes.spaceBetweenLabelAndForm,
                ),
                TextField(
                  obscureText: _isPasswordObscure,
                  style: AppTextStyle.focusText(),
                  controller: _passwordController,
                  decoration: AppCommonStyle.textFieldStyle(
                    hasError: hasPasswordError,
                    hintText: 'Nhập mật khẩu',
                    isPassword: true,
                    suffixIcon: IconButton(
                      icon: Icon(
                        !_isPasswordObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: AppColors.greyColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordObscure = !_isPasswordObscure;
                        });
                      },
                    ),
                  ),
                ),
                if (hasPasswordError)
                  Text(passwordError, style: AppTextStyle.primaryText().copyWith(color: AppColors.textFieldError))
                else
                  const SizedBox(),
                SizedBox(
                  height: AppSizes.spaceBetweenFormAndForm,
                ),
                Text(
                  'Xác nhận mật khẩu',
                  style: AppTextStyle.labelText().copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: AppSizes.spaceBetweenLabelAndForm,
                ),
                TextField(
                  obscureText: _isRePasswordObscure,
                  style: AppTextStyle.focusText(),
                  controller: _rePasswordController,
                  decoration: AppCommonStyle.textFieldStyle(
                    hasError: hasRePasswordError,
                    hintText: 'Nhập xác nhận mật khẩu',
                    isPassword: true,
                    suffixIcon: IconButton(
                      icon: Icon(
                        !_isRePasswordObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: AppColors.greyColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isRePasswordObscure = !_isRePasswordObscure;
                        });
                      },
                    ),
                  ),
                ),
                if (hasRePasswordError)
                  Text(rePasswordError, style: AppTextStyle.primaryText().copyWith(color: AppColors.textFieldError))
                else
                  const SizedBox(),
                SizedBox(
                  height: AppSizes.spaceBetweenFormAndForm,
                ),
                Text(
                  'Email',
                  style: AppTextStyle.labelText().copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: AppSizes.spaceBetweenLabelAndForm,
                ),
                TextField(
                  style: AppTextStyle.focusText(),
                  controller: _emailController,
                  decoration: AppCommonStyle.textFieldStyle(
                    hasError: hasEmailError,
                    hintText: 'Nhập email',
                  ),
                ),
                if (hasEmailError)
                  Text(emaildError, style: AppTextStyle.primaryText().copyWith(color: AppColors.textFieldError))
                else
                  const SizedBox(),
                SizedBox(
                  height: AppSizes.spaceBetweenFormAndForm,
                ),
                Text(
                  'Số điện thoại',
                  style: AppTextStyle.labelText().copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: AppSizes.spaceBetweenLabelAndForm,
                ),
                TextField(
                  style: AppTextStyle.focusText(),
                  controller: _phoneController,
                  decoration: AppCommonStyle.textFieldStyle(
                    hasError: hasPhoneError,
                    hintText: 'Nhập số điện thoại',
                  ),
                ),
                if (hasPhoneError)
                  Text(phoneError, style: AppTextStyle.primaryText().copyWith(color: AppColors.textFieldError))
                else
                  const SizedBox(),
                SizedBox(
                  height: AppSizes.spaceBetweenFormAndForm,
                ),
                Text(
                  'Địa chỉ',
                  style: AppTextStyle.labelText().copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: AppSizes.spaceBetweenLabelAndForm,
                ),
                TextField(
                  style: AppTextStyle.focusText(),
                  controller: _addressController,
                  decoration: AppCommonStyle.textFieldStyle(
                    hasError: hasAddressError,
                    hintText: 'Nhập địa chỉ',
                  ),
                ),
                if (hasAddressError)
                  Text(addressError, style: AppTextStyle.primaryText().copyWith(color: AppColors.textFieldError))
                else
                  const SizedBox(),
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
                      BlocProvider.of<SignUpBloc>(context).add(
                        SignUpSubmitEvent(
                          signUpRequest: SignUpRequest(
                            name: _usernameController.text,
                            password: _passwordController.text,
                            confirmPassword: _rePasswordController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                            address: _addressController.text,
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
                    child: Text('ĐĂNG KÝ', style: AppTextStyle.primaryText().copyWith(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Đã có tài khoản? ', style: AppTextStyle.primaryText()),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.router.replace(const SignInPageRoute());
                          },
                        text: 'Đăng nhập',
                        style: AppTextStyle.primaryText().copyWith(color: AppColors.primaryBrand),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.paddingBottom),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
