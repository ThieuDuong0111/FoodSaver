class ApiException implements Exception {
  ApiException({
    required this.statusCode,
    required this.method,
    required this.requestUrl,
    required this.reasonPhrase,
    this.responseBody,
  });

  final int statusCode;
  final String method;
  final String requestUrl;
  final String reasonPhrase;
  final String? responseBody;

  Map<String, dynamic> toJson() {
    return <String, Object?>{
      'statusCode': statusCode,
      'method': method,
      'requestUrl': requestUrl,
      'reasonPhrase': reasonPhrase,
      'responseBody': responseBody,
    };
  }
}

class ServerUnavailableException extends ApiException {
  ServerUnavailableException({
    required int statusCode,
    required String method,
    required String requestUrl,
    required String reasonPhrase,
    String? responseBody,
  })  : assert(statusCode >= 500),
        super(
          statusCode: statusCode,
          method: method,
          requestUrl: requestUrl,
          reasonPhrase: reasonPhrase,
          responseBody: responseBody,
        );
}

class BadRequestException extends ApiException {
  BadRequestException({
    required int statusCode,
    required String method,
    required String requestUrl,
    required String reasonPhrase,
    String? responseBody,
  })  : assert(statusCode >= 400 && statusCode < 500),
        super(
          statusCode: statusCode,
          method: method,
          requestUrl: requestUrl,
          reasonPhrase: reasonPhrase,
          responseBody: responseBody,
        );
}

class UnauthorizedException extends BadRequestException {
  UnauthorizedException({
    required int statusCode,
    required String method,
    required String requestUrl,
    required String reasonPhrase,
    String? responseBody,
  })  : assert(statusCode == 401),
        super(
          statusCode: statusCode,
          method: method,
          requestUrl: requestUrl,
          reasonPhrase: reasonPhrase,
          responseBody: responseBody,
        );
}

//test
class ServerException implements Exception {}

class CacheException implements Exception {}
