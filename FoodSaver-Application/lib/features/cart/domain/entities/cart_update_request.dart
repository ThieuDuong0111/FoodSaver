import 'package:json_annotation/json_annotation.dart';

part 'cart_update_request.g.dart';

@JsonSerializable()
class CartUpdateRequest {
  final int id;
  final int quantity;

  CartUpdateRequest({
    required this.id,
    required this.quantity,
  });

  factory CartUpdateRequest.fromJson(Map<String, dynamic> json) => _$CartUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CartUpdateRequestToJson(this);
}
