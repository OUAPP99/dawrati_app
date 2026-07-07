import 'package:flutter/material.dart';

import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../log/models/daily_log_entry.dart';

class DailyLogPreview extends StatelessWidget {
  final DailyLogEntry? entry;

  const DailyLogPreview({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Daily Summary",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 20),
          if (entry == null)
            _empty()
          else
            Row(
              children: [
                _metric(entry!.mood.split(" ").first, "Mood"),
                _metric("${entry!.water.toStringAsFixed(1)}L", "Water"),
                _metric("${entry!.sleep.toStringAsFixed(1)}h", "Sleep"),
              ],
            ),
        ],
      ),
    );
  }

  Widget _empty() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7FA),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: const Row(
        children: [
          Icon(Icons.add_circle_outline, color: Color(0xFFE91E63)),
          SizedBox(width: 14),
          Expanded(
            child: Text(
              "No log for this day. Add mood, water, sleep and symptoms.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _metric(String value, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF7FA),
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}