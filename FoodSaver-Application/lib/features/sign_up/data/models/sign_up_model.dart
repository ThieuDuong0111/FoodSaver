import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/data_model.dart';

part 'sign_up_model.freezed.dart';
part 'sign_up_model.g.dart';

@freezed
class SignUpModel with _$SignUpModel implements DataModel {
  factory SignUpModel({
    required String name,
    required String password,
    required String confirmPassword,
    required String email,
    required String phone,
    required String address,
    required String nameError,
    required bool passwordError,
    required bool confirmPasswordError,
    required bool emailError,
    required bool phoneError,
    required bool addressError,
    required bool hasError,
  }) = _SignUpModel;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => _$SignUpModelFromJson(json);
}
