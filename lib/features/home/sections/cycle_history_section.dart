import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../cycle/cycle_provider.dart';
import '../../log/provider/daily_log_provider.dart';

class CycleHistorySection extends StatelessWidget {
  const CycleHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final cycle = context.watch<CycleProvider>();
    final log = context.watch<DailyLogProvider>();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("My Cycle", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
          const SizedBox(height: 18),
          _row("Current day", "Day ${cycle.cycleDay}"),
          _row("Current phase", cycle.phase),
          _row("Average cycle", "28 days"),
          _row("Logs saved", "${log.history.length}"),
        ],
      ),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontSize: 17, color: Colors.black54)),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}