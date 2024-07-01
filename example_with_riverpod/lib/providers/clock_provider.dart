
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_clock/simple_clock.dart';


/// Dependency Injection for [FlutterClock], to avoid singleton pattern
final flutterClockProvider = Provider((ref) => SimpleClock());

/// StremProvider for the [FlutterClock.timeStream]
final clockProvider = StreamProvider<DateTime>((ref) {
  final clock = ref.watch(flutterClockProvider);
  ref.onDispose(clock.dispose);
  return clock.timeStream;
});
