import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_color_scheme.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/label_translations.dart';
import '../cycle/cycle_provider.dart';
import '../log/provider/daily_log_provider.dart';
import '../subscription/subscription_provider.dart';
import 'ai_chat_screen.dart';

class AiCoachScreen extends StatelessWidget {
  const AiCoachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cycle = context.watch<CycleProvider>();
    final log = context.watch<DailyLogProvider>();
    final subscription = context.watch<SubscriptionProvider>();
    final t = AppLocalizations.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 10, 22, 120),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 4),
                Text(
                  t.dawratiAiLabel,
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFEAF3),
                    Color(0xFFEDE7FF),
                  ],
                ),
                borderRadius: BorderRadius.circular(34),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/articles/coach.png'),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    t.personalAiCoach,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    t.dailyGuidanceDesc,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black54,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            _adviceCard(
              context,
              t.currentPhase,
              t.phaseDayCombo(translatePhase(t, cycle.phase), cycle.cycleDay),
              Icons.favorite,
            ),

            _adviceCard(
              context,
              t.todaysMood,
              translateMoodString(t, log.mood),
              Icons.mood,
            ),

            _adviceCard(
              context,
              t.hydrationTitle,
              t.hydrationTodayValue(log.water.toStringAsFixed(1)),
              Icons.water_drop,
            ),

            _adviceCard(
              context,
              t.sleepLabel,
              t.sleepHoursValue(log.sleep.toStringAsFixed(1)),
              Icons.bedtime,
            ),

            const SizedBox(height: 26),

            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        color: Color(0xFFE91E63),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        t.todaysAiInsight,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    _generateInsight(t, cycle.phase, log.water, log.sleep),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {
                  final languageName = switch (Localizations.localeOf(context).languageCode) {
                    'fr' => 'French',
                    'ar' => 'Arabic',
                    _ => 'English',
                  };

                  final systemContext =
                      'You are Dawrati AI, a warm and knowledgeable menstrual health and '
                      'wellness coach inside the Dawrati app. The user is on cycle day '
                      '${cycle.cycleDay}, currently in the ${cycle.phase} phase. Today they '
                      'logged: mood ${log.mood}, water intake ${log.water.toStringAsFixed(1)}L, '
                      'sleep ${log.sleep.toStringAsFixed(1)}h. Give supportive, practical '
                      'guidance about their cycle, symptoms, mood, hydration and sleep. Keep '
                      'answers concise (2-4 sentences) unless the user asks for more detail. '
                      'You are not a doctor — for medical concerns, gently suggest consulting '
                      'a healthcare professional. Always respond in $languageName.';

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AiChatScreen(
                        systemContext: systemContext,
                        isPremium: subscription.isPremium,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.chat_bubble_outline),
                label: Text(
                  t.startAiConversation,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _adviceCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    final colors = context.colors;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFFFEAF3),
            child: Icon(
              icon,
              color: const Color(0xFFE91E63),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _generateInsight(
    AppLocalizations t,
    String phase,
    double water,
    double sleep,
  ) {
    if (phase == "Ovulation") {
      return t.insightOvulation;
    }

    if (phase == "Menstruation") {
      return t.insightMenstruation;
    }

    if (water < 1.5) {
      return t.insightLowHydration;
    }

    if (sleep < 7) {
      return t.insightLowSleep;
    }

    return t.insightBalanced;
  }
}