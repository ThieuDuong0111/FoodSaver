import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_common_style.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (context) => DependencyInjection.instance(),
      child: const SignInWrapper(),
    );
  }
}

class SignInWrapper extends StatefulWidget {
  const SignInWrapper({super.key});

  @override
  State<SignInWrapper> createState() => _SignInWrapperState();
}

class _SignInWrapperState extends State<SignInWrapper> {
  late final TextEditingController _usernameController;
  bool hasUsernameError = false;
  late final TextEditingController _passwordController;
  bool _isPasswordObscure = true;
  bool hasPasswordError = false;
  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
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
                'Sign In',
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
                  hasError: hasUsernameError,
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
                  hasError: hasPasswordError,
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
                  child: Text('SIGN IN', style: AppTextStyle.primaryText().copyWith(color: Colors.white)),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Don’t have an account? ', style: AppTextStyle.primaryText()),
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () async {},
                      text: 'Sign up',
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
