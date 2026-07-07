import 'package:flutter/material.dart';

class CalendarHeader extends StatelessWidget {
  final String monthTitle;

  const CalendarHeader({
    super.key,
    required this.monthTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Calendar",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          monthTitle,
          style: const TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ],
    );
  }
}