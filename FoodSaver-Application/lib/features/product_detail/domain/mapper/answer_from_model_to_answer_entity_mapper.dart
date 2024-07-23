import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/mapper/user_from_model_to_user_entity_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/data/models/answer_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/answer_entity.dart';

abstract class AnswerFromModelToEntityMapper {
  AnswerEntity fromModel(AnswerModel model);
}

@LazySingleton(as: AnswerFromModelToEntityMapper)
class AnswerFromModelToEntityMapperImpl extends AnswerFromModelToEntityMapper {
  AnswerFromModelToEntityMapperImpl(this._userFromModelToEntityMapper) : super();

  final UserFromModelToEntityMapper _userFromModelToEntityMapper;
  @override
  AnswerEntity fromModel(AnswerModel model) {
    final AnswerEntity feedBackEntity = AnswerEntity(
      id: model.id,
      publishedDate: model.publishedDate,
      userAnswer: _userFromModelToEntityMapper.fromModel(model.userAnswer)!,
      answer: model.answer,
      isCreator: model.isCreator,
    );
    return feedBackEntity;
  }
}
