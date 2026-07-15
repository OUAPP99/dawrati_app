import 'package:flutter/material.dart';

import '../../../core/theme/app_color_scheme.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../l10n/app_localizations.dart';
import '../symptom_checker_screen.dart';

class SymptomCheckerSection extends StatelessWidget {
  const SymptomCheckerSection({super.key});

  void _openChecker(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SymptomCheckerScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  t.symptomCheckerTitle,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: colors.textPrimary),
                ),
              ),
              InkWell(
                onTap: () => _openChecker(context),
                child: Row(
                  children: [
                    Text(t.seeAll, style: TextStyle(fontSize: 17, color: colors.textSecondary, fontWeight: FontWeight.w700)),
                    const SizedBox(width: 4),
                    Icon(Icons.chevron_right, color: colors.textSecondary),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: Image.asset(
              "assets/images/articles/symptoms.png",
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 30),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  t.symptomTrackText,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, height: 1.25, color: colors.textPrimary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            t.symptomHelpText,
            style: TextStyle(fontSize: 17, color: colors.textSecondary, height: 1.35),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colors.surfaceAlt,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 26,
                      backgroundColor: Color(0xFFFFE4EC),
                      child: Icon(Icons.health_and_safety, color: Color(0xFFE91E63)),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        t.quickSelfCheck,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: colors.textPrimary),
                      ),
                    ),
                    Icon(Icons.timer_outlined, color: colors.textSecondary),
                    const SizedBox(width: 4),
                    Text(t.minutesReadLabel(5), style: TextStyle(color: colors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () => _openChecker(context),
                    child: Text(t.checkMySymptoms, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            t.notDiagnosisTool,
            style: TextStyle(color: colors.textSecondary, fontSize: 13),
          ),
        ],
      ),
    );
  }
}