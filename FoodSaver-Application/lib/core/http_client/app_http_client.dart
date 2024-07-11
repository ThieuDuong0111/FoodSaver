import 'dart:convert';
import 'dart:typed_data';

import 'package:funix_thieudvfx_foodsaver/core/logging/app_logger.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:injectable/injectable.dart';

abstract class AppHttpClient {
  Future<Response> head(Uri url, {Map<String, String>? headers});

  Future<Response> get(Uri url, {Map<String, String>? headers});

  Future<Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });

  Future<Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });

  Future<Response> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });

  Future<Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });

  Future<String> read(Uri url, {Map<String, String>? headers});

  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers});
}

@Injectable(as: AppHttpClient)
class AppHttpClientImpl implements AppHttpClient {
  AppHttpClientImpl(this._iOClient, this._appLogger) {
    _appLogger.logFor(this);
  }

  final IOClient _iOClient;
  final AppLogger _appLogger;

  @override
  Future<Response> head(Uri url, {Map<String, String>? headers}) async {
    final Response response = await _iOClient.head(url, headers: headers);
    _appLogger.info(
      'Method: HEAD\nUrl: $url\nHeaders: $headers\n==> Status CODE: ${response.statusCode}\n==> RESPONE:\n${response.body}',
    );

    return response;
  }

  @override
  Future<Response> get(Uri url, {Map<String, String>? headers}) async {
    final Response response = await _iOClient.get(url, headers: headers);
    _appLogger.info(
      'Method: GET\nUrl: $url\nHeaders: $headers\n==> Status CODE: ${response.statusCode}\n==> RESPONE:\n${response.body}',
    );

    return response;
  }

  @override
  Future<Response> patch(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final Response response = await _iOClient.patch(url, headers: headers, body: jsonEncode(body), encoding: encoding);
    _appLogger.info(
      'Method: PATCH\nUrl: $url\nHeaders: $headers\nBody: $jsonEncode(body),\nEncoding: $encoding\n==> Status CODE: ${response.statusCode}\n==> RESPONE:\n${response.body}',
    );

    return response;
  }

  @override
  Future<Response> post(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final Response response = await _iOClient.post(url, headers: headers, body: jsonEncode(body), encoding: encoding);
    _appLogger.info(
      'Method: POST  Url: $url\nHeaders: $headers\nBody: $jsonEncode(body),\nEncoding: $encoding\n==> Status CODE: ${response.statusCode}\n==> RESPONE:\n${response.body}',
    );

    return response;
  }

  @override
  Future<Response> put(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final Response response = await _iOClient.put(url, headers: headers, body: jsonEncode(body), encoding: encoding);
    _appLogger.info(
      'Method: PUT\nUrl: $url\nHeaders: $headers\nBody: $jsonEncode(body),\nEncoding: $encoding\n==> Status CODE: ${response.statusCode}\n==> RESPONE:\n${response.body}',
    );

    return response;
  }

  @override
  Future<Response> delete(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final Response response = await _iOClient.delete(url, headers: headers, body: jsonEncode(body), encoding: encoding);
    _appLogger.info(
      'Method: DELETE\nUrl: $url\nHeaders: $headers\nBody: $jsonEncode(body),\nEncoding: $encoding\n==> Status CODE: ${response.statusCode}\n==> RESPONE:\n${response.body}',
    );

    return response;
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) async {
    final String response = await _iOClient.read(url, headers: headers);
    _appLogger.info('Method: READ\nUrl: $url\nHeaders: $headers');

    return response;
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) async {
    final Uint8List response = await _iOClient.readBytes(url, headers: headers);
    _appLogger.info('Method: READBYTES\nUrl: $url\nHeaders: $headers');

    return response;
  }
}
