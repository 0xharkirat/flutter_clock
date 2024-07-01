<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# FlutterClock
FlutterClock is a simple package that provides a stream of the current time. You can use this stream to display the current time and date in your Flutter applications. This package is especially useful when you need to update the time displayed in your app in real-time.

## Features

+ Stream of the current time, updated every second.
+ Easy to integrate with Riverpod or use standalone.
+ Example usage included.

## Getting started
To start using FlutterClock in your project, follow these steps:

1. Add the package to your `pubspec.yaml` file:
    ```yaml
    dependencies:
        flutter_clock: <latest_version>
    ```
2. Run flutter pub get to install the package.
3. Import the package in your Dart code:
    ```dart
    import 'package:flutter_clock/flutter_clock.dart';
    ```

## Usage
### Standalone Example
Here is a standalone example of using FlutterClock:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_clock/flutter_clock.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clock Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'FlutterClock Example'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FlutterClock _flutterClock;
  late DateTime _currentTime;

  // initialize the clock & stream
  @override
  void initState() {
    super.initState();
    _flutterClock = FlutterClock();
    _currentTime = _flutterClock.getCurrentTime();
    _flutterClock.timeStream.listen((event) {
      setState(() {
        _currentTime = event;
      });
    });
  }


  @override
  void dispose() {
    _flutterClock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String currentTime = DateFormat('HH:mm:ss').format(_currentTime);
    final String today = DateFormat("yMMMMEEEEd").format(_currentTime);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              currentTime,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              today,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
```

### Example with Riverpod
For a more advanced usage with Riverpod, refer to the `/example_with_riverpod` directory in the repository.
1. Define the providers:
    ```dart
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
    ```
2. Wrap your app with `ProviderScope` to use Riverpod Providers:
    ```dart
    void main() {
        runApp(const ProviderScope(child: MyApp()));
    }
    ```
3. Watch the provider using `ref.watch()`:
    ```dart
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
                        final currentTime = ref.watch(flutterClockProvider).getCurrentTime();
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
    ```
4. See full `/example_with_riverpod` for more complete implementation.

## Additional information
+ `intl` package: If you need to format the the time and date, you need to add the `intl` package to format the time and date. 
    ```yaml
    dependencies:
        intl: ^0.17.0
    ```
+ Examples: Check the /example and /example_with_riverpod directories for complete examples on how to use this package in your projects.
+ Contributions: Contributions are welcome. Please open an issue or submit a pull request.
+ Bugs: If you encounter any bugs, please report them in the issue tracker.

Thank you for using FlutterClock!