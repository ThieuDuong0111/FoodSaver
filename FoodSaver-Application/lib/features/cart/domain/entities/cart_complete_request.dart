import 'package:json_annotation/json_annotation.dart';

part 'cart_complete_request.g.dart';

@JsonSerializable()
class CartCompleteRequest {
  final int paymentType;
  final int shippingType;

  CartCompleteRequest({
    required this.paymentType,
    required this.shippingType,
  });

  factory CartCompleteRequest.fromJson(Map<String, dynamic> json) => _$CartCompleteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CartCompleteRequestToJson(this);
}
