import 'package:flutter/material.dart';

class CalendarMonthSelector extends StatelessWidget {
  final DateTime currentMonth;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const CalendarMonthSelector({
    super.key,
    required this.currentMonth,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onPrevious,
          icon: const Icon(Icons.chevron_left, size: 32),
        ),
        Expanded(
          child: Text(
            "${_monthName(currentMonth.month)} ${currentMonth.year}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        IconButton(
          onPressed: onNext,
          icon: const Icon(Icons.chevron_right, size: 32),
        ),
      ],
    );
  }

  String _monthName(int month) {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December",
    ];
    return months[month - 1];
  }
}