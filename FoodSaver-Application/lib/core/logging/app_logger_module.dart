import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class AppLoggerModule {
  @lazySingleton
  Logger setupLogger() => Logger(
        printer: PrettyPrinter(
          methodCount: 0,
          printTime: true,
        ),
      );
}
