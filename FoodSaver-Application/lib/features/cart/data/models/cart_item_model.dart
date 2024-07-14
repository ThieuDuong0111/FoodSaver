import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/data_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/data/models/product_model.dart';

part 'cart_item_model.freezed.dart';
part 'cart_item_model.g.dart';

@freezed
class CartItemModel with _$CartItemModel implements DataModel {
  factory CartItemModel({
    required int id,
    required ProductModel cartProduct,
    required int unitQuantity,
    required int unitPrice,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) => _$CartItemModelFromJson(json);
}
