import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_color_scheme.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadows.dart';
import '../../l10n/app_localizations.dart';
import '../cycle/cycle_provider.dart';

class CycleSettingsScreen extends StatelessWidget {
  const CycleSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final cycle = context.watch<CycleProvider>();
    final locale = Localizations.localeOf(context).toString();
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 40),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 4),
                Text(t.cycleSettingsTitle, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
              ],
            ),
            const SizedBox(height: 22),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(AppRadius.card),
                boxShadow: AppShadows.soft,
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFFFFEAF3),
                    child: Icon(Icons.calendar_month, color: Color(0xFFE91E63)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.periodStartDateLabel, style: TextStyle(color: colors.textSecondary)),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat.yMMMMd(locale).format(cycle.periodStartDate),
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: cycle.periodStartDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        await cycle.updatePeriodStartDate(picked);
                      }
                    },
                    child: Text(t.changeDate),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(AppRadius.card),
                boxShadow: AppShadows.soft,
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFFFFEAF3),
                    child: Icon(Icons.timeline, color: Color(0xFFE91E63)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.averageCycle, style: TextStyle(color: colors.textSecondary)),
                        const SizedBox(height: 4),
                        Text(
                          t.daysCount(cycle.averageCycleLength),
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(AppRadius.card),
                boxShadow: AppShadows.soft,
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFFFFEAF3),
                    child: Icon(Icons.water_drop, color: Color(0xFFE91E63)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.averagePeriodLength, style: TextStyle(color: colors.textSecondary)),
                        const SizedBox(height: 4),
                        Text(
                          t.daysCount(cycle.periodLength),
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            Text(t.cycleAssumptionsTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            Text(
              cycle.hasRealCycleData
                  ? t.cycleBasedOnHistory(cycle.periodHistory.length, cycle.averageCycleLength, cycle.periodLength)
                  : t.cycleBasedOnEstimate(cycle.averageCycleLength),
              style: TextStyle(color: colors.textSecondary, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
