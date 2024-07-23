import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/answer_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';

part 'feedback_entity.freezed.dart';

@freezed
class FeedBackEntity with _$FeedBackEntity implements DomainEntity {
  factory FeedBackEntity({
    required int id,
    required UserEntity userFeedBacks,
    required ProductEntity productFeedBacks,
    required List<AnswerEntity> answers,
    required String comment,
    required int rating,
    required DateTime publishedDate,
  }) = _FeedBackEntity;
  FeedBackEntity._();
}
