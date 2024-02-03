extension StringExtensions on String {
  String capitalize() {
    if (isEmpty || length < 2) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
