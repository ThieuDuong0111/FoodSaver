import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';

part 'answer_entity.freezed.dart';

@freezed
class AnswerEntity with _$AnswerEntity implements DomainEntity {
  factory AnswerEntity({
    required int id,
    required UserEntity userAnswer,
    required String answer,
    required bool isCreator,
    required DateTime publishedDate,
  }) = _AnswerEntity;
  AnswerEntity._();
}
