import 'package:funix_thieudvfx_foodsaver/dependency_injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(
  asExtension: false,
)
abstract class DependencyInjection {
  static final instance = GetIt.instance..allowReassignment = true;

  static Future<void> registerDependecies() async => init(instance);
}
