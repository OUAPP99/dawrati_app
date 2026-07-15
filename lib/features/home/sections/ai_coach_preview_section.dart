import 'package:flutter/material.dart';

import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/widgets/animated_tap.dart';
import '../../../l10n/app_localizations.dart';

class AiCoachPreviewSection extends StatelessWidget {
  const AiCoachPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return AnimatedTap(
      onTap: () {
        Navigator.pushNamed(context, '/ai-coach');
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFFEAF3),
              Color(0xFFEDE7FF),
            ],
          ),
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: AppShadows.soft,
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/articles/coach.png'),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.aiCoachCardTitle,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    t.aiCoachCardSubtitle,
                    style: const TextStyle(color: Color(0xFF1F2937)),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF1F2937)),
          ],
        ),
      ),
    );
  }
}