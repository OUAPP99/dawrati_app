import 'package:flutter/material.dart';

class CycleCard extends StatelessWidget {
  final int cycleDay;
  final String phase;
  final double progress;
  final VoidCallback onChangeDate;

  const CycleCard({
    super.key,
    required this.cycleDay,
    required this.phase,
    required this.progress,
    required this.onChangeDate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChangeDate,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          children: [
            const Icon(Icons.favorite, color: Color(0xFFE91E63)),
            const SizedBox(height: 16),
            const Text("Today"),
            const SizedBox(height: 8),
            Text(
              "Day $cycleDay",
              style: const TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(phase),
            const SizedBox(height: 22),
            LinearProgressIndicator(
              value: progress,
              minHeight: 9,
              color: const Color(0xFFE91E63),
              backgroundColor: const Color(0xFFFFC1D6),
              borderRadius: BorderRadius.circular(20),
            ),
            const SizedBox(height: 18),
            TextButton.icon(
              onPressed: onChangeDate,
              icon: const Icon(Icons.calendar_month),
              label: const Text("Change period date"),
            ),
          ],
        ),
      ),
    );
  }
}