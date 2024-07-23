import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/mapper/user_from_model_to_user_entity_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/data/models/feedback_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/feedback_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/mapper/answer_from_model_to_answer_entity_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/mapper/product_from_model_to_product_entity_mapper.dart';

abstract class FeedBackFromModelToEntityMapper {
  FeedBackEntity fromModel(FeedBackModel model);
}

@LazySingleton(as: FeedBackFromModelToEntityMapper)
class FeedBackFromModelToEntityMapperImpl extends FeedBackFromModelToEntityMapper {
  FeedBackFromModelToEntityMapperImpl(
    this._productFromModelToEntityMapper,
    this._userFromModelToEntityMapper,
    this._answerFromModelToEntityMapper,
  ) : super();

  final ProductFromModelToEntityMapper _productFromModelToEntityMapper;
  final UserFromModelToEntityMapper _userFromModelToEntityMapper;
  final AnswerFromModelToEntityMapper _answerFromModelToEntityMapper;
  @override
  FeedBackEntity fromModel(FeedBackModel model) {
    final FeedBackEntity feedBackEntity = FeedBackEntity(
      id: model.id,
      userFeedBacks: _userFromModelToEntityMapper.fromModel(model.userFeedBacks)!,
      productFeedBacks: _productFromModelToEntityMapper.fromModel(model.productFeedBacks),
      comment: model.comment,
      rating: model.rating,
      publishedDate: model.publishedDate,
      answers: model.answers.map(_answerFromModelToEntityMapper.fromModel).toList(),
    );
    return feedBackEntity;
  }
}
