import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekHeader extends StatelessWidget {
  const WeekHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    // Sunday-first week starting reference, matching CalendarGrid's layout.
    final sunday = DateTime(2024, 1, 7);
    final days = List.generate(7, (i) => DateFormat.EEEEE(locale).format(sunday.add(Duration(days: i))));

    return Row(
      children: days.map((day){
        return Expanded(
          child: Center(
            child: Text(
              day,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}