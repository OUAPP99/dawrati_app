import 'package:flutter/material.dart';

import '../../../core/theme/app_color_scheme.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../l10n/app_localizations.dart';

class TodaysJourneySection extends StatelessWidget {
  const TodaysJourneySection({super.key});

  Widget tile(BuildContext context, IconData icon, String title) {
    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: const Color(0xFFFFE8F1),
            child: Icon(
              icon,
              color: const Color(0xFFE91E63),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: context.colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

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
            t.todaysJourney,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: colors.textPrimary,
            ),
          ),

          const SizedBox(height: 26),

          Row(
            children: [
              tile(context, Icons.mood, t.moodLabel),
              tile(context, Icons.water_drop, t.waterLabel),
              tile(context, Icons.nightlight_round, t.sleepLabel),
              tile(context, Icons.directions_walk, t.activityLabel),
            ],
          ),

          const SizedBox(height: 28),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(t.continueLabel),
            ),
          ),
        ],
      ),
    );
  }
}