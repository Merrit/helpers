extension StringHelper on String {
  /// Returns the string with the first letter capitalized.
  ///
  /// Example: capital => Capital
  String capitalized() => this[0].toUpperCase() + substring(1);
}
