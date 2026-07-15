import 'package:flutter/material.dart';

import '../../../core/theme/app_color_scheme.dart';
import '../../../l10n/app_localizations.dart';

class SymptomsSelector extends StatelessWidget {
  final Set<String> selectedSymptoms;
  final ValueChanged<String> onToggle;

  const SymptomsSelector({
    super.key,
    required this.selectedSymptoms,
    required this.onToggle,
  });

  static const symptoms = [
    ("Cramps", Icons.flash_on),
    ("Bloating", Icons.bubble_chart),
    ("Headache", Icons.psychology),
    ("Back pain", Icons.accessibility_new),
    ("Acne", Icons.face_retouching_natural),
    ("Fatigue", Icons.battery_2_bar),
    ("Nausea", Icons.sick),
    ("Breast pain", Icons.favorite_border),
  ];

  static String label(AppLocalizations t, String key) {
    switch (key) {
      case "Cramps":
        return t.symptomCramps;
      case "Bloating":
        return t.symptomBloating;
      case "Headache":
        return t.symptomHeadache;
      case "Back pain":
        return t.symptomBackPain;
      case "Acne":
        return t.symptomAcne;
      case "Fatigue":
        return t.symptomFatigue;
      case "Nausea":
        return t.symptomNausea;
      case "Breast pain":
        return t.symptomBreastPain;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final colors = context.colors;

    return _section(
      context,
      title: t.homeSymptoms,
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: symptoms.map((item) {
          final selected = selectedSymptoms.contains(item.$1);

          return FilterChip(
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
            onSelected: (_) => onToggle(item.$1),
          );
        }).toList(),
      ),
    );
  }

  Widget _section(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    final colors = context.colors;
    return Container(
      width: double.infinity,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: colors.textPrimary),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}