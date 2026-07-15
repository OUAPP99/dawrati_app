import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_color_scheme.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/label_translations.dart';

class CalendarHeroHeader extends StatelessWidget {
  final DateTime currentMonth;
  final int cycleDay;
  final String phase;

  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const CalendarHeroHeader({
    super.key,
    required this.currentMonth,
    required this.cycleDay,
    required this.phase,
    required this.onPrevious,
    required this.onNext,
  });

  String fertility(AppLocalizations t) {
    if (cycleDay == 14) return t.peakFertility;
    if (cycleDay >= 11 && cycleDay <= 15) return t.highFertility;
    return t.lowFertility;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.hero),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        children: [

          Row(
            children: [

              IconButton(
                onPressed: onPrevious,
                icon: const Icon(Icons.chevron_left),
              ),

              Expanded(
                child: Column(
                  children: [

                    Text(
                      DateFormat.yMMMM(locale).format(currentMonth),
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        color: colors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      t.goodMorning,
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: onNext,
                icon: const Icon(Icons.chevron_right),
              ),

            ],
          ),

          const SizedBox(height: 22),

          Row(
            children: [

              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEAF3),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Color(0xFFE91E63),
                  size: 36,
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      t.cycleDayLabel(cycleDay),
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: colors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      translatePhase(t, phase),
                      style: TextStyle(
                        fontSize: 18,
                        color: colors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [

                        Container(
                          width: 9,
                          height: 9,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE91E63),
                            shape: BoxShape.circle,
                          ),
                        ),

                        const SizedBox(width: 8),

                        Text(
                          fertility(t),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: colors.textPrimary,
                          ),
                        ),

                      ],
                    )

                  ],
                ),
              )

            ],
          )

        ],
      ),
    );
  }
}