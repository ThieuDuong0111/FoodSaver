import 'dart:convert';

import 'package:injectable/injectable.dart';

abstract class JsonConverter {
  T decodeToObject<T extends Object>(
    String decodable, {
    required T Function(Map<String, dynamic> json) converter,
    T Function(Object error)? onError,
  });

  Iterable<T> decodeToCollection<T extends Object>(
    String decodable, {
    required T Function(Map<String, dynamic> json) itemConverter,
    Iterable<T> Function(Object error)? onError,
  });

  String encode(Object encodable);
}

@LazySingleton(as: JsonConverter)
class JsonConverterImpl implements JsonConverter {
  @override
  T decodeToObject<T extends Object>(
    String decodable, {
    required T Function(Map<String, dynamic> json) converter,
    T Function(Object error)? onError,
  }) {
    assert(decodable.isNotEmpty);

    try {
      final json = jsonDecode(decodable) as Object;

      if (json is List) {
        throw FormatException(
          'The decoded JSON is a List, use `decodeToList` instead',
          json,
        );
      } else if (json is Map<String, dynamic>) {
        return converter(json);
      } else {
        return json as T;
      }
    } catch (err) {
      if (onError != null) {
        return onError(err);
      }

      if (err is FormatException) {
        throw FormatException('Cannot decode String to JSON', decodable);
      }

      rethrow;
    }
  }

  @override
  Iterable<T> decodeToCollection<T extends Object>(
    String decodable, {
    required T Function(Map<String, dynamic> json)? itemConverter,
    Iterable<T> Function(Object error)? onError,
  }) {
    assert(decodable.isNotEmpty);

    try {
      final json = jsonDecode(decodable) as Object;

      if (json is Iterable<Map> && itemConverter != null) {
        return json
            .cast<Map>()
            .map<T>((e) => itemConverter(e.cast<String, Object>()));
      } else if (json is Iterable<T>) {
        return json;
      } else {
        throw FormatException(
          'The decoded JSON is not a List, use `decodeToObject` instead',
          json,
        );
      }
    } on FormatException catch (err) {
      if (onError != null) {
        return onError(err);
      }

      throw FormatException('Cannot decode String to JSON', decodable);
    }
  }

  @override
  String encode(Object encodable) => jsonEncode(encodable);
}
