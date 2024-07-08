import 'package:funix_thieudvfx_foodsaver/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/number_trivia/domain/mapper/number_trivia_from_model_to_entity_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NumberTriviaRepository)
class NumberTriviaRepositoryImpl extends NumberTriviaRepository {
  NumberTriviaRepositoryImpl(
    this._numberTriviaRemoteDataSource,
    this._numberTriviaFromModelToEntityMapper,
  );
  final NumberTriviaRemoteDataSource _numberTriviaRemoteDataSource;
  final NumberTriviaFromModelToEntityMapper _numberTriviaFromModelToEntityMapper;

  @override
  Future<NumberTriviaEntity> getConcreteNumberTrivia(String number) async {
    try {
      final NumberTriviaModel models = await _numberTriviaRemoteDataSource.getConcreteNumberTrivia(
        number,
      );

      return _numberTriviaFromModelToEntityMapper.fromModel(models)!;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<NumberTriviaEntity> getRandomNumberTrivia() async {
    try {
      final NumberTriviaModel models = await _numberTriviaRemoteDataSource.getRandomNumberTrivia();

      return _numberTriviaFromModelToEntityMapper.fromModel(models)!;
    } catch (error) {
      rethrow;
    }
  }
}
