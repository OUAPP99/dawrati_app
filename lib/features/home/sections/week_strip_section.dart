import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekStripSection extends StatelessWidget {
  const WeekStripSection({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final locale = Localizations.localeOf(context).toString();

    return Column(
      children: [
        Text(
          DateFormat.MMMMd(locale).format(now),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 22),
        LayoutBuilder(
          builder: (context, constraints) {
            final circleSize = (constraints.maxWidth / 7).clamp(40.0, 54.0);

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                final date = now.add(Duration(days: index));
                final isToday = index == 0;

                return SizedBox(
                  width: circleSize,
                  child: Column(
                    children: [
                      Text(
                        DateFormat.EEEEE(locale).format(date),
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: circleSize,
                        height: circleSize,
                        decoration: BoxDecoration(
                          color: isToday ? const Color(0xFFE91E63) : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "${date.day}",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: isToday ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}