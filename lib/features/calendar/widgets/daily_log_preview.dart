import 'package:flutter/material.dart';

import '../../../core/theme/app_color_scheme.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../l10n/app_localizations.dart';
import '../../log/models/daily_log_entry.dart';

class DailyLogPreview extends StatelessWidget {
  final DailyLogEntry? entry;

  const DailyLogPreview({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.dailySummaryTitle,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 20),
          if (entry == null)
            _empty(context, t)
          else
            Row(
              children: [
                _metric(context, entry!.mood.split(" ").first, t.moodLabel),
                _metric(context, "${entry!.water.toStringAsFixed(1)}L", t.waterLabel),
                _metric(context, "${entry!.sleep.toStringAsFixed(1)}h", t.sleepLabel),
              ],
            ),
        ],
      ),
    );
  }

  Widget _empty(BuildContext context, AppLocalizations t) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colors.background,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        children: [
          const Icon(Icons.add_circle_outline, color: Color(0xFFE91E63)),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              t.noLogForDay,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _metric(BuildContext context, String value, String label) {
    final colors = context.colors;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: colors.background,
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
              style: TextStyle(
                color: colors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}