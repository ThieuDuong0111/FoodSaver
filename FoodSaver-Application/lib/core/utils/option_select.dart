abstract class OptionSelect {
  ///
  /// It checks if the [selectedOption] exists as a key in the [options] Map.
  /// If it does, it returns the associated value. If it doesn't, it returns the [defaultValue].
  ///
  static T map<E, T>({
    required E selectedOption,
    required Map<E, T> options,
    required T defaultValue,
  }) {
    if (!options.containsKey(selectedOption)) {
      return defaultValue;
    }

    return options[selectedOption] as T;
  }
}
