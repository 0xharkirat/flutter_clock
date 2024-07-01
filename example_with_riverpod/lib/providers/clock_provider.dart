import 'package:flutter_clock/flutter_clock.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// Dependency Injection for [FlutterClock], to avoid singleton pattern
final flutterClockProvider = Provider((ref) => FlutterClock());

/// StremProvider for the [FlutterClock.timeStream]
final clockProvider = StreamProvider<DateTime>((ref) {
  final clock = ref.watch(flutterClockProvider);
  ref.onDispose(clock.dispose);
  return clock.timeStream;
});
