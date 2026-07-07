import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/hayati_info_card.dart';
import '../../log/provider/daily_log_provider.dart';

class HealthGrid extends StatelessWidget {
  const HealthGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final log = context.watch<DailyLogProvider>();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: HayatiInfoCard(
                icon: Icons.water_drop,
                title: "Water",
                value: "${log.water.toStringAsFixed(2)} L",
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: HayatiInfoCard(
                icon: Icons.bedtime,
                title: "Sleep",
                value: "${log.sleep.toStringAsFixed(1)} h",
                color: Colors.indigo,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: HayatiInfoCard(
                icon: Icons.mood,
                title: "Mood",
                value: log.mood.replaceAll("😊 ", "").replaceAll("😐 ", "").replaceAll("😢 ", "").replaceAll("😠 ", "").replaceAll("😴 ", ""),
                color: Colors.orange,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: HayatiInfoCard(
                icon: Icons.favorite,
                title: "Fertility",
                value: "High",
                color: Colors.pink,
              ),
            ),
          ],
        ),
      ],
    );
  }
}