import 'package:flutter/material.dart';

class MiniBarChart extends StatelessWidget {
  final List<double> values;
  final Color color;

  const MiniBarChart({
    super.key,
    required this.values,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    const labels = ["M", "T", "W", "T", "F", "S", "S"];

    // Toujours afficher 7 jours
    final data = List<double>.filled(7, 0);

    for (int i = 0; i < values.length && i < 7; i++) {
      data[7 - values.length + i] = values[i];
    }

    double maxValue = 1;

    for (final value in data) {
      if (value > maxValue) {
        maxValue = value;
      }
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: SizedBox(
        height: 170,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(7, (index) {
            final value = data[index];
            final barHeight = value == 0
                ? 10.0
                : ((value / maxValue) * 100).clamp(18.0, 100.0);

            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOutCubic,
                    width: 22,
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: value == 0
                          ? Colors.grey.shade200
                          : color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    labels[index],
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}