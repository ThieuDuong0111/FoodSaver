import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/data_model.dart';

part 'sign_up_model.freezed.dart';
part 'sign_up_model.g.dart';

@freezed
class SignUpModel with _$SignUpModel implements DataModel {
  factory SignUpModel({
    required String? name,
    required String? password,
    required String? confirmPassword,
    required String? email,
    required String? phone,
    required String? address,
    required String? nameError,
    required String? passwordError,
    required String? confirmPasswordError,
    required String? emailError,
    required String? phoneError,
    required String? addressError,
    required bool hasError,
  }) = _SignUpModel;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => _$SignUpModelFromJson(json);
}
