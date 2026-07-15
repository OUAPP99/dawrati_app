import 'package:flutter/material.dart';

import '../../../core/theme/app_color_scheme.dart';
import '../../../l10n/app_localizations.dart';

class WaterCard extends StatelessWidget {
  final double water;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const WaterCard({
    super.key,
    required this.water,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    return _card(
      context,
      title: AppLocalizations.of(context).waterLabel,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: water > 0 ? onMinus : null,
            icon: const Icon(Icons.remove_circle_outline, size: 34),
          ),
          Container(
            width: 130,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: context.colors.background,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Text(
              "${water.toStringAsFixed(2)} L",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
            ),
          ),
          IconButton(
            onPressed: onPlus,
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