import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';

class ValidateUtils {
  static bool isNotNullOrEmpty(String? input) {
    if (input == null || input.isEmpty) {
      return false;
    }
    return true;
  }

  static bool isLogined(UserEntity userEntity) {
    if (userEntity.id != 0) {
      return true;
    }
    return false;
  }

  static String parseError(String? input) {
    if (input == null || input.isEmpty) {
      return '';
    }
    return input;
  }
}
