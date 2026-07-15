import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_color_scheme.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/label_translations.dart';
import '../../cycle/cycle_provider.dart';
import '../../log/provider/daily_log_provider.dart';
import '../../log/widgets/symptoms_selector.dart';
import '../../subscription/subscription_provider.dart';

/// Surfaces a "you often log X during your Y phase" insight by
/// cross-referencing already-logged symptoms with the cycle phase they
/// were logged in — no new data entry required from the user.
class SymptomInsightSection extends StatelessWidget {
  const SymptomInsightSection({super.key});

  static const int _minOccurrences = 3;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final log = context.watch<DailyLogProvider>();
    final cycle = context.watch<CycleProvider>();

    final counts = <String, Map<String, int>>{};
    for (final entry in log.history) {
      if (entry.symptoms.isEmpty) continue;
      final phase = cycle.phaseForDate(entry.date);
      final phaseCounts = counts.putIfAbsent(phase, () => {});
      for (final symptom in entry.symptoms) {
        phaseCounts[symptom] = (phaseCounts[symptom] ?? 0) + 1;
      }
    }

    String? bestPhase;
    String? bestSymptom;
    var bestCount = 0;
    counts.forEach((phase, symptomCounts) {
      symptomCounts.forEach((symptom, count) {
        if (count > bestCount) {
          bestCount = count;
          bestPhase = phase;
          bestSymptom = symptom;
        }
      });
    });

    if (bestSymptom == null || bestCount < _minOccurrences) {
      return const SizedBox.shrink();
    }

    final isPremium = context.watch<SubscriptionProvider>().isPremium;

    if (!isPremium) {
      return _lockedTeaser(context, t);
    }

    final symptomLabel = SymptomsSelector.label(t, bestSymptom!);
    final phaseLabel = translatePhase(t, bestPhase!);
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFEDE7FF),
            child: Icon(Icons.insights, color: Color(0xFF7C4DFF)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.symptomInsightTitle,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: colors.textPrimary),
                ),
                const SizedBox(height: 6),
                Text(
                  t.symptomInsightText(symptomLabel, phaseLabel),
                  style: TextStyle(color: colors.textSecondary, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _lockedTeaser(BuildContext context, AppLocalizations t) {
    final colors = context.colors;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/premium'),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: AppShadows.soft,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFFEDE7FF),
              child: Icon(Icons.lock, color: Color(0xFF7C4DFF)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.symptomInsightTitle,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: colors.textPrimary),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    t.symptomInsightLockedText,
                    style: TextStyle(color: colors.textSecondary, height: 1.4),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF7C4DFF)),
          ],
        ),
      ),
    );
  }
}
