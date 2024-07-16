import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/data_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/data/models/user_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/data/models/product_model.dart';

part 'feedback_model.freezed.dart';
part 'feedback_model.g.dart';

@freezed
class FeedBackModel with _$FeedBackModel implements DataModel {
  factory FeedBackModel({
    required int id,
    required UserModel userFeedBacks,
    required ProductModel productFeedBacks,
    required String comment,
    required int rating,
    required DateTime publishedDate,
  }) = _FeedBackModel;

  factory FeedBackModel.fromJson(Map<String, dynamic> json) => _$FeedBackModelFromJson(json);
}
