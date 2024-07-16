import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/data_model.dart';

part 'unit_model.freezed.dart';
part 'unit_model.g.dart';

@freezed
class UnitModel with _$UnitModel implements DataModel {
  factory UnitModel({
    required int id,
    required String name,
  }) = _UnitModel;

  factory UnitModel.fromJson(Map<String, dynamic> json) => _$UnitModelFromJson(json);
}
