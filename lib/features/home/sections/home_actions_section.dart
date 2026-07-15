import 'package:flutter/material.dart';

import '../../../core/theme/app_color_scheme.dart';
import '../../../l10n/app_localizations.dart';

class HomeActionsSection extends StatelessWidget {
  final VoidCallback? onLogPeriod;
  final VoidCallback? onSymptoms;
  final VoidCallback? onSex;

  const HomeActionsSection({
    super.key,
    this.onLogPeriod,
    this.onSymptoms,
    this.onSex,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final colors = context.colors;

    return Row(
      children: [
        _action(
          context,
          icon: Icons.water_drop,
          label: t.homeLogPeriod,
          color: const Color(0xFFE91E63),
          filled: true,
          onTap: onLogPeriod,
        ),
        const SizedBox(width: 18),
        _action(
          context,
          icon: Icons.add,
          label: t.homeSymptoms,
          color: colors.textPrimary,
          onTap: onSymptoms,
        ),
        const SizedBox(width: 18),
        _action(
          context,
          icon: Icons.favorite_border,
          label: t.homeSex,
          color: colors.textPrimary,
          onTap: onSex,
        ),
      ],
    );
  }

  Widget _action(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    bool filled = false,
    VoidCallback? onTap,
  }) {
    final colors = context.colors;
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 74,
              height: 74,
              decoration: BoxDecoration(
                color: filled ? color : colors.surface,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .07),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: filled ? Colors.white : color,
                size: 34,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}