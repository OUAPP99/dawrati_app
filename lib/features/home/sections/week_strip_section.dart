import 'package:flutter/material.dart';

class WeekStripSection extends StatelessWidget {
  const WeekStripSection({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    const labels = ["M", "T", "W", "T", "F", "S", "S"];

    return Column(
      children: [
        Text(
          "${now.day} ${_month(now.month)}",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            final date = now.add(Duration(days: index));
            final isToday = index == 0;

            return Column(
              children: [
                Text(
                  labels[index],
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 54,
                  height: 54,
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
            );
          }),
        ),
      ],
    );
  }

  String _month(int month) {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December",
    ];
    return months[month - 1];
  }
}