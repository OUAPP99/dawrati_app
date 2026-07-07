import 'package:flutter/material.dart';

class CalendarLegend extends StatelessWidget {
  const CalendarLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _LegendItem(
            color: Color(0xFFF8A5C2),
            label: "Period",
          ),
          _LegendItem(
            color: Color(0xFFB39DDB),
            label: "Ovulation",
          ),
          _LegendItem(
            color: Color(0xFFE91E63),
            label: "Today",
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 6,
          backgroundColor: color,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 13),
        ),
      ],
    );
  }
}