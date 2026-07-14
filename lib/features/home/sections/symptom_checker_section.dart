import 'package:flutter/material.dart';

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

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(t.symptomCheckerTitle, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
              ),
              InkWell(
                onTap: () => _openChecker(context),
                child: Row(
                  children: [
                    Text(t.seeAll, style: const TextStyle(fontSize: 17, color: Colors.grey, fontWeight: FontWeight.w700)),
                    const SizedBox(width: 4),
                    const Icon(Icons.chevron_right, color: Colors.grey),
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
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, height: 1.25),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            t.symptomHelpText,
            style: TextStyle(fontSize: 17, color: Colors.grey.shade700, height: 1.35),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF6E6),
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
                      child: Text(t.quickSelfCheck, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                    ),
                    const Icon(Icons.timer_outlined, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(t.minutesReadLabel(5), style: const TextStyle(color: Colors.grey)),
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
            style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
          ),
        ],
      ),
    );
  }
}