import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/logging/app_logger.dart';
import 'package:injectable/injectable.dart';

abstract class DioProvider {
  Dio create(String apiName);
}

@Injectable(as: DioProvider)
class DioProviderImpl implements DioProvider {
  static const _requestTimeOutInMs = Duration(milliseconds: 30000);

  DioProviderImpl(this._logger);

  final AppLogger _logger;

  @override
  Dio create(String apiName) {
    final identityHash = describeIdentity(apiName).split('#').last;
    _logger.logFor('$apiName#$identityHash');

    return Dio(
      BaseOptions(
        connectTimeout: _requestTimeOutInMs,
        sendTimeout: _requestTimeOutInMs,
        receiveTimeout: _requestTimeOutInMs,
      ),
    )..interceptors.add(_DioLoggingInterceptor(_logger));
  }
}

class _DioLoggingInterceptor extends Interceptor {
  static const _jsonEncoder = JsonEncoder.withIndent('    ');

  _DioLoggingInterceptor(this._logger);

  final AppLogger _logger;
  late DateTime _startTime;
  late DateTime _endTime;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);

    _startTime = DateTime.now();
    final reqUuid = _createUuidFromRequest(options);
    final reqTag = '[REQ#$reqUuid]';
    final reqUri = options.uri;

    _logger.info('$reqTag Sending ${options.method.toUpperCase()} ${reqUri.path + reqUri.query}');
    _logger.info('$reqTag Host: ${reqUri.host}');
    _logger.info('$reqTag Scheme: ${reqUri.scheme.toUpperCase()}');

    if (options.headers.isNotEmpty) {
      options.headers.cast<String, String>().forEach((key, value) {
        _logger.info('$reqTag ${key.substring(0, 1).toUpperCase() + key.substring(1)}: $value');
      });
    }

    _logBody(reqTag, options.data);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);

    _logResponse(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);

    final reqUuid = _createUuidFromRequest(err.requestOptions);
    final resTag = '[RES#$reqUuid]';
    final response = err.response;

    if (response != null) {
      _logResponse(response);
    }

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        final timeOutMessage = 'Failed: ${err.type.name.split(RegExp('(?=[A-Z])')).join(' ')}';
        _logger.info('$resTag $timeOutMessage');
        throw TimeoutException(timeOutMessage);
      default:
        break;
    }
    APIException.handle(err);
    // _logger.severe('$resTag $e');

    // throw Exception();
  }

  void _logResponse(Response response) {
    final reqUuid = _createUuidFromRequest(response.requestOptions);
    final resTag = '[RES#$reqUuid]';
    _endTime = DateTime.now();

    final statusCode = response.statusCode ?? 0;
    final isSuccess = statusCode >= 200 && statusCode < 300;

    if (isSuccess) {
      _logger.info(
        '$resTag ${'Success'} ${response.statusCode} ${response.statusMessage}',
      );
    } else {
      _logger.severe(
        '$resTag ${'Failed'} ${response.statusCode} ${response.statusMessage}',
      );
    }
    _logger.info('$resTag Duration: ${_endTime.difference(_startTime)}');

    if (!response.headers.isEmpty) {
      response.headers.forEach((key, value) {
        _logger.info('$resTag ${key.substring(0, 1).toUpperCase() + key.substring(1)}: ${value.join(',')}');
      });
    }

    _logBody(resTag, response.data);
  }

  void _logBody(String tag, Object? body) {
    if ((body is Map && body.isNotEmpty) || body is List) {
      final json = _jsonEncoder.convert(body);
      _logger.info('$tag Content Map:\r\n$json');
    } else if (body is String && body.isNotEmpty) {
      _logger.info('$tag Content String: $body');
    }
  }

  static String _createUuidFromRequest(RequestOptions request) {
    final identity = describeIdentity(request);

    return identity.split('#').last;
  }
}
