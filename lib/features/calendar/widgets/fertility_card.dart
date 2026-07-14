import 'package:flutter/material.dart';

import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/label_translations.dart';

class FertilityCard extends StatelessWidget {
  final String chance;
  final VoidCallback? onTap;

  const FertilityCard({
    super.key,
    required this.chance,
    this.onTap,
  });

  String description(AppLocalizations t) {
    if (chance == "Peak") return t.fertilityDescPeak;
    if (chance == "High") return t.fertilityDescHigh;
    if (chance == "Medium") return t.fertilityDescMedium;
    return t.fertilityDescLow;
  }

  Color get accentColor {
    if (chance == "Peak") return const Color(0xFF8E5BE8);
    if (chance == "High") return const Color(0xFF10A7B5);
    if (chance == "Medium") return const Color(0xFFFF9800);
    return const Color(0xFFE91E63);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.card),
      onTap: onTap,
      child: Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEAF2),
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.favorite,
              color: accentColor,
              size: 32,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.chanceOfPregnancy,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  translateFertilityChance(t, chance),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: accentColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description(t),
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.35,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
      ),
    );
  }
}