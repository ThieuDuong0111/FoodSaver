import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/data_model.dart';

part 'number_trivia_model.freezed.dart';
part 'number_trivia_model.g.dart';

@freezed
class NumberTriviaModel with _$NumberTriviaModel implements DataModel {
  factory NumberTriviaModel({
    required String text,
    required int number,
  }) = _NumberTriviaModel;

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) => _$NumberTriviaModelFromJson(json);
}
