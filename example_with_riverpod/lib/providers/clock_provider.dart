
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_clock/simple_clock.dart';


/// Dependency Injection for [SimpleClock], to avoid singleton pattern
final simpleClockProvider = Provider((ref) => SimpleClock());

/// StremProvider for the [SimpleClock.timeStream]
final clockProvider = StreamProvider<DateTime>((ref) {
  final clock = ref.watch(simpleClockProvider);
  ref.onDispose(clock.dispose);
  return clock.timeStream;
});
