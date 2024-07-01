import 'package:flutter/material.dart';

class TimeDisplay extends StatelessWidget {
  const TimeDisplay({
    super.key,
    required this.context,
    required this.formattedTime,
    required this.formattedDate,
  });

  final BuildContext context;
  final String formattedTime;
  final String formattedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          formattedTime,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text(
          formattedDate,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}