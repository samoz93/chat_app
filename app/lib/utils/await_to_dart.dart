Future<(dynamic, T?)> to<T>(Future<T> future) async {
  try {
    var data = await future;
    return (null, data);
  } catch (e) {
    return (e, null);
  }
}
