import 'package:flutter/material.dart';

import '../../../core/theme/app_color_scheme.dart';
import '../../../l10n/app_localizations.dart';

class WeightCard extends StatelessWidget {
  final double? weight;
  final ValueChanged<double?> onChanged;

  const WeightCard({
    super.key,
    required this.weight,
    required this.onChanged,
  });

  static const double defaultValue = 60.0;
  static const double min = 30.0;
  static const double max = 150.0;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final value = weight ?? defaultValue;
    final colors = context.colors;

    return _card(
      context,
      title: t.weightTitle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => onChanged((value - 0.1).clamp(min, max)),
            icon: const Icon(Icons.remove_circle_outline, size: 34),
          ),
          Container(
            width: 140,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                Text(
                  weight == null ? "—" : "${value.toStringAsFixed(1)} kg",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
                if (weight == null)
                  Text(t.notRecorded, style: TextStyle(fontSize: 11, color: colors.textSecondary)),
              ],
            ),
          ),
          IconButton(
            onPressed: () => onChanged((value + 0.1).clamp(min, max)),
            icon: const Icon(Icons.add_circle_outline, size: 34),
          ),
        ],
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
