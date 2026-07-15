import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../log/models/daily_log_entry.dart';
import '../../../core/theme/app_color_scheme.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/label_translations.dart';

class BottomSheetDay extends StatelessWidget {
  final DateTime date;
  final int cycleDay;
  final String phase;
  final DailyLogEntry? entry;
  final VoidCallback onSetPeriodStart;

  const BottomSheetDay({
    super.key,
    required this.date,
    required this.cycleDay,
    required this.phase,
    required this.entry,
    required this.onSetPeriodStart,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();
    final colors = context.colors;

    return DraggableScrollableSheet(
      initialChildSize: .82,
      maxChildSize: .95,
      minChildSize: .55,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.hero),
            ),
          ),
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.all(26),
            children: [

              Center(
                child: Container(
                  width: 55,
                  height: 6,
                  decoration: BoxDecoration(
                    color: colors.divider,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Center(
                child: Hero(
                  tag: 'calendarDay-${date.year}-${date.month}-${date.day}',
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE91E63),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x4DE91E63),
                          blurRadius: 22,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${date.day}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Text(
                DateFormat.yMd(locale).format(date),
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                t.cycleDayLabel(cycleDay),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                translatePhase(t, phase),
                style: const TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 28),

              _InfoCard(
                icon: Icons.favorite,
                title: t.chanceOfPregnancy,
                value: translateFertilityChance(
                  t,
                  cycleDay == 14
                      ? "Peak"
                      : cycleDay >= 11 && cycleDay <= 15
                          ? "High"
                          : "Low",
                ),
              ),

              const SizedBox(height: 18),

              _InfoCard(
                icon: Icons.psychology,
                title: t.currentPhaseShort,
                value: translatePhase(t, phase),
              ),

              const SizedBox(height: 18),

              _InfoCard(
                icon: Icons.water_drop,
                title: t.cycleDayShort,
                value: "$cycleDay",
              ),

              const SizedBox(height: 28),

              Text(
                t.dailyLogLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),

              const SizedBox(height: 18),

              if (entry == null)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colors.background,
                    borderRadius:
                        BorderRadius.circular(AppRadius.card),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        size: 55,
                        color: Colors.pink.shade400,
                      ),

                      const SizedBox(height: 18),

                      Text(
                        t.noLogForDayShort,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        t.trackMoreDetails,
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(t.addDailyLog),
                        ),
                      ),

                      const SizedBox(height: 10),

                      OutlinedButton(
                        onPressed: onSetPeriodStart,
                        child: Text(
                          t.setAsPeriodStart,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: colors.background,
                    borderRadius:
                        BorderRadius.circular(AppRadius.card),
                    boxShadow: AppShadows.soft,
                  ),
                  child: Column(
                    children: [

                            _Row(t.moodLabel, translateMoodString(t, entry!.mood)),
                            _Row(t.sleepLabel, "${entry!.sleep.toStringAsFixed(1)} h"),
                            _Row(t.waterLabel, "${entry!.water.toStringAsFixed(1)} L"),
                            if (entry!.weight != null)
                              _Row(t.weightTitle, "${entry!.weight!.toStringAsFixed(1)} kg"),
                            if (entry!.medications.isNotEmpty)
                              _Row(t.medicationsTitle, entry!.medications.join(', ')),
                            _Row(t.notesLabel, entry!.notes.isEmpty ? "-" : entry!.notes),

                    ],
                  ),
                ),

              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [

          CircleAvatar(
            radius: 24,
            backgroundColor: colors.surface,
            child: Icon(icon, color: Colors.pink),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: TextStyle(
                    color: colors.textSecondary,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String title;
  final String value;

  const _Row(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [

          Text(title),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),
    );
  }
}