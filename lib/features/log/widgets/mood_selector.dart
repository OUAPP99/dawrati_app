import 'package:flutter/material.dart';

import '../../../core/theme/app_color_scheme.dart';
import '../../../l10n/app_localizations.dart';

class MoodSelector extends StatelessWidget {
  final String? selectedMood;
  final ValueChanged<String> onChanged;

  const MoodSelector({
    super.key,
    required this.selectedMood,
    required this.onChanged,
  });

  static const moods = [
    ("😍", "Amazing"),
    ("😊", "Good"),
    ("😐", "Okay"),
    ("😔", "Sad"),
    ("😭", "Awful"),
  ];

  static String label(AppLocalizations t, String key) {
    switch (key) {
      case "Amazing":
        return t.moodAmazing;
      case "Good":
        return t.moodGood;
      case "Okay":
        return t.moodOkay;
      case "Sad":
        return t.moodSad;
      case "Awful":
        return t.moodAwful;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.howDoYouFeelToday,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),

        const SizedBox(height: 18),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: moods.map((mood) {
            final selected = selectedMood == "${mood.$1} ${mood.$2}";

            return GestureDetector(
              onTap: () => onChanged("${mood.$1} ${mood.$2}"),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: 62,
                height: 82,
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFFFFEAF3)
                      : colors.surface,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: selected
                        ? const Color(0xFFE91E63)
                        : colors.divider,
                    width: 2,
                  ),
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: const Color(0xFFE91E63)
                                .withValues(alpha: .18),
                            blurRadius: 18,
                          )
                        ]
                      : [],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      mood.$1,
                      style: const TextStyle(fontSize: 28),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      label(t, mood.$2),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: selected
                            ? const Color(0xFFE91E63)
                            : colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}