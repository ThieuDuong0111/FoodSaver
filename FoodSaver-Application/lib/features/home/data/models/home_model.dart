import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/data_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/data/models/category_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/data/models/product_model.dart';

part 'home_model.freezed.dart';
part 'home_model.g.dart';

@freezed
class HomeModel with _$HomeModel implements DataModel {
  factory HomeModel({
    required List<CategoryModel> categories,
    required List<ProductModel> products,
  }) = _HomeModel;

  factory HomeModel.fromJson(Map<String, dynamic> json) => _$HomeModelFromJson(json);
}
