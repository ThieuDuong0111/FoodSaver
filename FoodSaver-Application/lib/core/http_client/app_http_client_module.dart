import 'dart:io';

import 'package:http/io_client.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppHttpClientModule {
  static const _requestTimeOutInMs = Duration(milliseconds: 30000);
  @lazySingleton
  IOClient get ioClient => IOClient(
        HttpClient()
          ..badCertificateCallback = ((cert, host, port) => true)
          ..connectionTimeout = _requestTimeOutInMs,
      );
}
