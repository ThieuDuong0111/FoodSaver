import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request.g.dart';

@JsonSerializable()
class SignUpRequest {
  final String name;
  final String password;
  final String confirmPassword;
  final String email;
  final String phone;
  final String address;

  SignUpRequest({
    required this.name,
    required this.password,
    required this.confirmPassword,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => _$SignUpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}
