class ValidateUtils {
  static bool isNullOrEmpty(String? input) {
    if (input == null || input.isEmpty) {
      return false;
    }
    return true;
  }

  static String parseError(String? input) {
    if (input == null || input.isEmpty) {
      return '';
    }
    return input;
  }
}
