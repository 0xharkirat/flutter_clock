library flutter_clock;

import 'dart:async';

class FlutterClock {
  DateTime _currentTime;
  final StreamController<DateTime> _timeController = StreamController<DateTime>.broadcast();
  late Timer _timer;

  FlutterClock() : _currentTime = DateTime.now() {
    _startClock();
  }

  void _startClock() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentTime = DateTime.now();
      _timeController.add(_currentTime);
    });
  }

  DateTime getCurrentTime() {
    return _currentTime;
  }

  Stream<DateTime> get timeStream => _timeController.stream;

  void dispose() {
    _timer.cancel();
    _timeController.close();
  }
}
