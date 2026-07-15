import 'package:flutter/material.dart';

import '../../../core/theme/app_color_scheme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/label_translations.dart';

class CalendarPhaseCard extends StatelessWidget {
  final int cycleDay;
  final String phase;
  final VoidCallback? onTap;

  const CalendarPhaseCard({
    super.key,
    required this.cycleDay,
    required this.phase,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final colors = context.colors;

    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xFFFFE4EC),
            child: Icon(Icons.spa, color: Color(0xFFE91E63), size: 30),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.cycleDayLabel(cycleDay),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  translatePhase(t, phase),
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
      ),
    );
  }
}