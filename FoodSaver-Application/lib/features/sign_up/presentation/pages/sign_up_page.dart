import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/presentation/bloc/sign_up_bloc.dart';
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
  final bool _hasUsernameError = false;
  late final TextEditingController _passwordController;
  bool _isPasswordObscure = true;
  final bool _hasPasswordError = false;
  late final TextEditingController _rePasswordController;
  bool _isRePasswordObscure = true;
  final bool _hasRePasswordError = false;
  late final TextEditingController _emailController;
  final bool _hasEmailError = false;
  late final TextEditingController _phoneController;
  final bool _hasPhoneError = false;
  late final TextEditingController _addressController;
  final bool _hasAddressError = false;
  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _rePasswordController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.paddingHorizontal),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Sign Up',
                style: AppTextStyle.bigTitle(),
              ),
              SizedBox(height: 24.h),
              Text(
                'Username',
                style: AppTextStyle.labelText(),
              ),
              SizedBox(
                height: AppSizes.spaceBetweenLabelAndForm,
              ),
              TextField(
                style: AppTextStyle.focusText(),
                controller: _usernameController,
                decoration: AppCommonStyle.textFieldStyle(
                  hasError: _hasUsernameError,
                  hintText: 'Enter your username',
                ),
              ),
              SizedBox(
                height: AppSizes.spaceBetweenFormAndForm,
              ),
              Text(
                'Password',
                style: AppTextStyle.labelText(),
              ),
              SizedBox(
                height: AppSizes.spaceBetweenLabelAndForm,
              ),
              TextField(
                obscureText: _isPasswordObscure,
                style: AppTextStyle.focusText(),
                controller: _passwordController,
                decoration: AppCommonStyle.textFieldStyle(
                  hasError: _hasPasswordError,
                  hintText: 'Enter your password',
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
              SizedBox(
                height: AppSizes.spaceBetweenFormAndForm,
              ),
              Text(
                'Confirm Password',
                style: AppTextStyle.labelText(),
              ),
              SizedBox(
                height: AppSizes.spaceBetweenLabelAndForm,
              ),
              TextField(
                obscureText: _isRePasswordObscure,
                style: AppTextStyle.focusText(),
                controller: _rePasswordController,
                decoration: AppCommonStyle.textFieldStyle(
                  hasError: _hasRePasswordError,
                  hintText: 'Enter your confirm password',
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
              SizedBox(
                height: AppSizes.spaceBetweenFormAndForm,
              ),
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
                  child: Text('SIGN UP', style: AppTextStyle.primaryText().copyWith(color: Colors.white)),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Already have an account? ', style: AppTextStyle.primaryText()),
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () async {},
                      text: 'Sign in',
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
    );
  }
}
