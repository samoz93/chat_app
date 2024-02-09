class Throttler {
  final Duration duration;

  int _lastActionTime;

  int get _millisecondsSinceEpoch => DateTime.now().millisecondsSinceEpoch;

  Throttler({required this.duration})
      : _lastActionTime = DateTime.now().millisecondsSinceEpoch;

  void run(void Function() action) {
    if (_millisecondsSinceEpoch - _lastActionTime > duration.inMilliseconds) {
      action();
      _lastActionTime = _millisecondsSinceEpoch;
    }
  }
}
