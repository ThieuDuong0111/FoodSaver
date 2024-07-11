abstract class OptionSelect {
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
