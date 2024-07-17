import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/data_model.dart';

part 'banner_model.freezed.dart';
part 'banner_model.g.dart';

@freezed
class BannerModel with _$BannerModel implements DataModel {
  factory BannerModel({
    required int id,
    required String? name,
    required String? imageUrl,
  }) = _BannerModel;

  factory BannerModel.fromJson(Map<String, dynamic> json) => _$BannerModelFromJson(json);
}
