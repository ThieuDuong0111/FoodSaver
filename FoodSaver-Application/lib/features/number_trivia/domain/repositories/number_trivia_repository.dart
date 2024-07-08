import 'package:funix_thieudvfx_foodsaver/features/number_trivia/domain/entities/number_trivia_entity.dart';

abstract class NumberTriviaRepository {
  Future<NumberTriviaEntity> getConcreteNumberTrivia(String number);
  Future<NumberTriviaEntity> getRandomNumberTrivia();
}
