import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/data_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/data/models/cart_by_creator_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/data/models/user_model.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
class CartModel with _$CartModel implements DataModel {
  factory CartModel({
    required List<CartByCreatorModel> cartByCreator,
    required UserModel userCarts,
    required DateTime publishedDate,
    required bool isDone,
    required int totalAmount,
    required int itemsCount,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);
}
