import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/data_model.dart';

part 'sign_in_model.freezed.dart';
part 'sign_in_model.g.dart';

@freezed
class SignInModel with _$SignInModel implements DataModel {
  factory SignInModel({
    required String? name,
    required String? password,
    required String? nameError,
    required String? passwordError,
    required bool hasError,
    required String? token,
  }) = _SignInModel;

  factory SignInModel.fromJson(Map<String, dynamic> json) => _$SignInModelFromJson(json);
}
