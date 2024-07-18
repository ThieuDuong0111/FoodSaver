import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/data_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/data/models/cart_item_model.dart';

part 'cart_by_creator_model.freezed.dart';
part 'cart_by_creator_model.g.dart';

@freezed
class CartByCreatorModel with _$CartByCreatorModel implements DataModel {
  factory CartByCreatorModel({
    required List<CartItemModel> cartItems,
  }) = _CartByCreatorModel;

  factory CartByCreatorModel.fromJson(Map<String, dynamic> json) => _$CartByCreatorModelFromJson(json);
}
