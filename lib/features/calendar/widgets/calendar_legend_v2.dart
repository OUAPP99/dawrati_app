import 'package:flutter/material.dart';

class CalendarLegendV2 extends StatelessWidget {
  const CalendarLegendV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: const [
        _Item(color: Color(0xFFFFB6CF), text: "Period"),
        _Item(color: Color(0xFFDDF8FB), text: "Fertile"),
        _Item(color: Color(0xFFDCC6FF), text: "Ovulation"),
        _Item(color: Color(0xFFE91E63), text: "Selected"),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final Color color;
  final String text;

  const _Item({
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}