import 'package:flutter/material.dart';

import '../../../core/theme/app_color_scheme.dart';
import '../../../l10n/app_localizations.dart';

class ActivityCard extends StatelessWidget {
  final String? selectedActivity;
  final ValueChanged<String> onChanged;

  const ActivityCard({
    super.key,
    required this.selectedActivity,
    required this.onChanged,
  });

  static const activities = [
    ("None", Icons.block),
    ("Walk", Icons.directions_walk),
    ("Run", Icons.directions_run),
    ("Gym", Icons.fitness_center),
    ("Yoga", Icons.self_improvement),
  ];

  static String label(AppLocalizations t, String key) {
    switch (key) {
      case "None":
        return t.activityNone;
      case "Walk":
        return t.activityWalk;
      case "Run":
        return t.activityRun;
      case "Gym":
        return t.activityGym;
      case "Yoga":
        return t.activityYoga;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final colors = context.colors;

    return _card(
      context,
      title: t.activityLabel,
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: activities.map((item) {
          final selected = selectedActivity == item.$1;

          return ChoiceChip(
            selected: selected,
            label: Text(label(t, item.$1)),
            avatar: Icon(
              item.$2,
              size: 18,
              color: selected ? Colors.white : const Color(0xFFE91E63),
            ),
            selectedColor: const Color(0xFFE91E63),
            backgroundColor: colors.surface,
            labelStyle: TextStyle(
              color: selected ? Colors.white : colors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
            side: BorderSide(
              color: selected ? const Color(0xFFE91E63) : colors.divider,
            ),
            onSelected: (_) => onChanged(item.$1),
          );
        }).toList(),
      ),
    );
  }

  Widget _card(BuildContext context, {required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        const SizedBox(height: 18),
        child,
      ]),
    );
  }
}