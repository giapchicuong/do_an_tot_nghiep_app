class AppHelpFunction {
  static bool checkIsNumeric(String s) {
    return double.tryParse(s) != null;
  }
}
