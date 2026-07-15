import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_color_scheme.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../l10n/app_localizations.dart';
import '../../cycle/cycle_provider.dart';
import '../../log/provider/daily_log_provider.dart';

class CycleHistorySection extends StatelessWidget {
  const CycleHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final cycle = context.watch<CycleProvider>();
    final log = context.watch<DailyLogProvider>();
    final t = AppLocalizations.of(context);
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                t.myCycleTitle,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: colors.textPrimary),
              ),
              if (log.currentStreak >= 2) ...[
                const SizedBox(width: 10),
                _streakBadge(t, log.currentStreak),
              ],
            ],
          ),
          const SizedBox(height: 18),
          _row(context, t.currentDay, t.dayLabel(cycle.cycleDay)),
          _row(context, t.currentPhase, cycle.phase),
          _row(context, t.averageCycle, t.daysCount(cycle.averageCycleLength)),
          _row(context, t.logsSaved, "${log.history.length}"),
          if (cycle.isIrregular) ...[
            const SizedBox(height: 6),
            _irregularityNotice(t),
          ],
        ],
      ),
    );
  }

  Widget _streakBadge(AppLocalizations t, int streak) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔥', style: TextStyle(fontSize: 14)),
          const SizedBox(width: 4),
          Text(
            t.streakBannerText(streak),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFFE65100)),
          ),
        ],
      ),
    );
  }

  Widget _irregularityNotice(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: const Color(0xFFFFB74D).withValues(alpha: .4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: Color(0xFFE65100)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.cycleIrregularWarningTitle,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFFE65100)),
                ),
                const SizedBox(height: 4),
                Text(
                  t.cycleIrregularWarningDesc,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade800, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, String title, String value) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        children: [
          Text(title, style: TextStyle(fontSize: 17, color: colors.textSecondary)),
          const Spacer(),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: colors.textPrimary)),
        ],
      ),
    );
  }
}