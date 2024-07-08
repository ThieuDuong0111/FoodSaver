import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:funix_thieudvfx_foodsaver/core/logging/app_logger.dart';
import 'package:injectable/injectable.dart';

abstract class AppStorage {
  Future<void> writeValue({
    required String key,
    required String? value,
  });

  Future<String?> readValue({
    required String key,
  });

  Future<Map<String, String>> readAllValues();

  Future<void> deleteValue({
    required String key,
  });

  Future<void> deleteAllValues();
}

@Injectable(as: AppStorage)
class AppStorageImpl implements AppStorage {
  AppStorageImpl(this._secureStorage, this._appLogger) {
    _appLogger.logFor(this);
  }

  final FlutterSecureStorage _secureStorage;
  final AppLogger _appLogger;

  @override
  Future<void> writeValue({required String key, required String? value}) async {
    await _secureStorage.write(key: key, value: value);
    _appLogger.info('write to storage | key: $key | value: $value');
  }

  @override
  Future<String?> readValue({required String key}) async {
    final String? value = await _secureStorage.read(key: key);
    _appLogger.info('read from storage | key: $key | value: $value');

    return value;
  }

  @override
  Future<Map<String, String>> readAllValues() async {
    final Map<String, String> values = await _secureStorage.readAll();
    _appLogger.info('read all values from storage | value: $values');

    return values;
  }

  @override
  Future<void> deleteValue({required String key}) async {
    await _secureStorage.delete(key: key);
    _appLogger.info('delete value from storage | key: $key');
  }

  @override
  Future<void> deleteAllValues() async {
    await _secureStorage.deleteAll();
    _appLogger.info('delete all values from storage');
  }
}
