import 'package:example_with_riverpod/providers/clock_provider.dart';
import 'package:example_with_riverpod/views/widgets/time_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTime = ref.watch(clockProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: asyncTime.when(
          data: (time) {
            final formattedTime = DateFormat.Hms().format(time);
            final formattedDate = DateFormat.yMMMMEEEEd().format(time);
            return TimeDisplay(context: context, formattedTime: formattedTime, formattedDate: formattedDate);
          },
          loading: () {
            final currentTime = ref.watch(simpleClockProvider).getCurrentTime();
            final formattedTime = DateFormat.Hms().format(currentTime);
            final formattedDate = DateFormat.yMMMMEEEEd().format(currentTime);
            return TimeDisplay(context: context, formattedTime: formattedTime, formattedDate: formattedDate);
          },
          error: (error, stack) => Text('Error: $error'),
        ),
      ),
    );
  }
}

