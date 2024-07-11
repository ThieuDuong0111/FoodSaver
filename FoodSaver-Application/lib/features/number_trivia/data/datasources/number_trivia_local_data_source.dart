import 'package:funix_thieudvfx_foodsaver/core/storage/app_storage.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/json_converter.dart';
import 'package:funix_thieudvfx_foodsaver/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:injectable/injectable.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

// ignore: constant_identifier_names
const String CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

@LazySingleton(as: NumberTriviaLocalDataSource)
class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  NumberTriviaLocalDataSourceImpl(
    this._jsonConverter,
    this._appStorage,
  );
  final JsonConverter _jsonConverter;
  final AppStorage _appStorage;

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final jsonString = await _appStorage.readValue(key: CACHED_NUMBER_TRIVIA);

    if (jsonString != null) {
      return Future.value(_jsonConverter.decodeToObject(jsonString, converter: NumberTriviaModel.fromJson));
    } else {
      throw Exception();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) async {
    await _appStorage.writeValue(key: CACHED_NUMBER_TRIVIA, value: _jsonConverter.encode(triviaToCache.toJson()));
  }
}
