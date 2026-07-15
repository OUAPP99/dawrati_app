import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class CyclePredictionSection extends StatelessWidget {
  final String phase;
  final int daysUntilOvulation;
  final VoidCallback? onSeeInsights;

  const CyclePredictionSection({
    super.key,
    required this.phase,
    required this.daysUntilOvulation,
    this.onSeeInsights,
  });

  int get ovulationIn => daysUntilOvulation;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
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
            isOvulation ? t.ovulationToday : t.ovulationIn,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            isOvulation ? t.todayLabel : t.daysCount(ovulationIn),
            style: const TextStyle(
              fontSize: 68,
              fontWeight: FontWeight.w900,
              height: 1,
              color: Color(0xFF1F2937),
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
                  ? t.highChancePregnancy
                  : ovulationIn <= 3
                      ? t.fertilityIncreasing
                      : t.lowChancePregnancy,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          const SizedBox(height: 28),
          TextButton(
            onPressed: onSeeInsights,
            child: Text(
              t.seeDailyInsights,
              style: const TextStyle(
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