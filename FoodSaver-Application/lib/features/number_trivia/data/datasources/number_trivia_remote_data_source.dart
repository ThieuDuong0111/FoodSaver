import 'package:dio/dio.dart' hide Headers;
import 'package:funix_thieudvfx_foodsaver/core/http_client/dio_provider.dart';
import 'package:funix_thieudvfx_foodsaver/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'number_trivia_remote_data_source.g.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(String number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

@LazySingleton(as: NumberTriviaRemoteDataSource)
@RestApi()
abstract class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  @factoryMethod
  factory NumberTriviaRemoteDataSourceImpl(DioProvider dio) =>
      _NumberTriviaRemoteDataSourceImpl(dio.create('Web Service'), baseUrl: 'http://numbersapi.com');
  @override
  @GET('/{number}')
  @Headers(<String, String>{
    'Content-Type': 'application/json',
  })
  Future<NumberTriviaModel> getConcreteNumberTrivia(@Path() String number);

  @override
  @GET('/random')
  @Headers(<String, String>{
    'Content-Type': 'application/json',
  })
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
