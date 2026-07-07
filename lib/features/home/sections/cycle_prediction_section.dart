import 'package:flutter/material.dart';

class CyclePredictionSection extends StatelessWidget {
  final int cycleDay;
  final String phase;

  const CyclePredictionSection({
    super.key,
    required this.cycleDay,
    required this.phase,
  });

  int get ovulationIn {
    final days = 14 - cycleDay;
    return days < 0 ? 0 : days;
  }

  @override
  Widget build(BuildContext context) {
    final isOvulation = phase == "Ovulation";

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 44, 28, 38),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(38),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFF1F6),
            Color(0xFFFFC9DD),
            Color(0xFFFFEAF2),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withValues(alpha: .12),
            blurRadius: 30,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.auto_awesome,
            color: Color(0xFFE91E63),
            size: 28,
          ),
          const SizedBox(height: 16),
          Text(
            isOvulation ? "Ovulation today" : "Ovulation in",
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            isOvulation ? "Today" : "$ovulationIn Days",
            style: const TextStyle(
              fontSize: 68,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .75),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Text(
              isOvulation
                  ? "High chance of pregnancy"
                  : ovulationIn <= 3
                      ? "Fertility is increasing"
                      : "Low chance of getting pregnant",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 28),
          TextButton(
            onPressed: () {},
            child: const Text(
              "See your daily insights",
              style: TextStyle(
                color: Color(0xFFE91E63),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}