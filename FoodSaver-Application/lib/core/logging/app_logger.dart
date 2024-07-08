import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

abstract class AppLogger {
  void logFor(Object owner);

  void debug(String message);

  void info(String message);

  void warning(String message);

  void error(String message);

  void severe(
    String message, [
    Object? exception,
    StackTrace? stackTrace,
  ]);
}

@Injectable(as: AppLogger)
class AppLoggerImpl implements AppLogger {
  AppLoggerImpl(this._logger);

  final Logger _logger;

  String _loggerOwner = 'General';

  @override
  void logFor(Object owner) => _loggerOwner = (owner.runtimeType).toString();

  @override
  void debug(String message) => _logger.d('$_loggerOwner | $message');

  @override
  void info(String message) => _logger.i('$_loggerOwner | $message');

  @override
  void warning(String message) => _logger.w('$_loggerOwner | $message');
  @override
  void error(String message) => _logger.e('$_loggerOwner | $message');

  @override
  void severe(
    String message, [
    Object? exception,
    StackTrace? stackTrace,
  ]) =>
      _logger.e('$_loggerOwner | $message', error: exception, stackTrace: stackTrace);
}
