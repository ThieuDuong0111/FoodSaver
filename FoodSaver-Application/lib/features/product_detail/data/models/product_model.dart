import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/data_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/data/models/category_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/data/models/user_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/data/models/unit_model.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel implements DataModel {
  factory ProductModel({
    required int id,
    required CategoryModel category,
    required UserModel creator,
    required UnitModel unit,
    required String? name,
    required String? description,
    required int price,
    required int discountPrice,
    required int quantity,
    required double? rating,
    required int commentsCount,
    required String? imageUrl,
    required DateTime? expiredDate,
    required bool? isExpired,
    required int ratingsCount,
    required int rating5Count,
    required int rating4Count,
    required int rating3Count,
    required int rating2Count,
    required int rating1Count,
    required int soldCount,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
}
