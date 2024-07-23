import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/data_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/data/models/user_model.dart';

part 'answer_model.freezed.dart';
part 'answer_model.g.dart';

@freezed
class AnswerModel with _$AnswerModel implements DataModel {
  factory AnswerModel({
    required int id,
    required UserModel userAnswer,
    required String answer,
    required bool isCreator,
    required DateTime publishedDate,
  }) = _AnswerModel;

  factory AnswerModel.fromJson(Map<String, dynamic> json) => _$AnswerModelFromJson(json);
}
