import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/data_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel implements DataModel {
  factory UserModel({
    required int id,
    required String? name,
    required String? imageUrl,
    required String? storeName,
    required String? storeImageUrl,
    required String? storeDescription,
    required String? email,
    required String? phone,
    required String? address,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
