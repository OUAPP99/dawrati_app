import 'package:flutter/material.dart';

import '../../../core/widgets/stat_chip.dart';

class CompactStatsSection extends StatelessWidget {
  final double water;
  final double sleep;
  final String mood;
  final String phase;

  const CompactStatsSection({
    super.key,
    required this.water,
    required this.sleep,
    required this.mood,
    required this.phase,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatChip(
          icon: Icons.water_drop,
          value: "${water.toStringAsFixed(1)}L",
          label: "Water",
          color: Colors.blue,
        ),

        const SizedBox(width: 10),

        StatChip(
          icon: Icons.bedtime,
          value: "${sleep.toStringAsFixed(1)}h",
          label: "Sleep",
          color: Colors.indigo,
        ),

        const SizedBox(width: 10),

        StatChip(
          icon: Icons.mood,
          value: mood.split(" ").first,
          label: "Mood",
          color: Colors.orange,
        ),

        const SizedBox(width: 10),

        StatChip(
          icon: Icons.favorite,
          value: phase == "Ovulation" ? "High" : "Normal",
          label: "Fertility",
          color: Colors.pink,
        ),
      ],
    );
  }
}