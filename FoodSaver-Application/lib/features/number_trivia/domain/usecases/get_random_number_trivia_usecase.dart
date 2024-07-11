// import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
// import 'package:funix_thieudvfx_foodsaver/features/number_trivia/domain/entities/number_trivia_entity.dart';
// import 'package:funix_thieudvfx_foodsaver/features/number_trivia/domain/repositories/number_trivia_repository.dart';
// import 'package:injectable/injectable.dart';

// @lazySingleton
// class GetRandomNumberTriviaUsecase extends UseCase<NumberTriviaEntity, NoParams> {
//   GetRandomNumberTriviaUsecase(this._numberTriviaRepository);

//   final NumberTriviaRepository _numberTriviaRepository;

//   @override
//   Future<NumberTriviaEntity> call(NoParams param) async {
//     final NumberTriviaEntity repo = await _numberTriviaRepository.getRandomNumberTrivia();

//     return repo;
//   }
// }
