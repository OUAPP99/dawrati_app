import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_radius.dart';
import '../../core/widgets/fade_slide.dart';
import '../../l10n/app_localizations.dart';
import '../ai/ai_chat_screen.dart';
import '../app_state/app_state_provider.dart';
import '../app_state/profile_context.dart';
import '../cycle/cycle_provider.dart';
import '../log/provider/daily_log_provider.dart';
import '../partner/partner_code_screen.dart';
import '../subscription/subscription_provider.dart';
import 'sections/flo_header_section.dart';
import 'sections/week_strip_section.dart';
import 'sections/cycle_prediction_section.dart';
import 'sections/home_actions_section.dart';
import 'sections/todays_journey_section.dart';
import 'sections/daily_articles_section.dart';
import 'sections/symptom_checker_section.dart';
import 'sections/symptom_insight_section.dart';
import 'sections/recommendation_section.dart';
import 'sections/cycle_history_section.dart';
import 'sections/ai_coach_preview_section.dart';
import 'sections/subscription_preview_section.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onChangerDate;
  final VoidCallback? onOpenCalendar;
  final VoidCallback? onOpenLog;
  final VoidCallback? onOpenProfile;
  final VoidCallback? onOpenInsights;
  final VoidCallback? onOpenArticles;

  const HomeScreen({
    super.key,
    required this.onChangerDate,
    this.onOpenCalendar,
    this.onOpenLog,
    this.onOpenProfile,
    this.onOpenInsights,
    this.onOpenArticles,
  });

  void _openQuickChat(BuildContext context) {
    final cycle = context.read<CycleProvider>();
    final log = context.read<DailyLogProvider>();
    final subscription = context.read<SubscriptionProvider>();
    final appState = context.read<AppStateProvider>();

    final languageName = switch (Localizations.localeOf(context).languageCode) {
      'fr' => 'French',
      'ar' => 'Arabic',
      _ => 'English',
    };

    final goalNote = goalContext(appState.userGoal);
    final contraceptionNote = contraceptionContext(appState.contraceptionMethod);

    final systemContext =
        'You are Dawrati AI, a warm and knowledgeable menstrual health and '
        'wellness coach inside the Dawrati app. The user is on cycle day '
        '${cycle.cycleDay}, currently in the ${cycle.phase} phase. Today they '
        'logged: mood ${log.mood}, water intake ${log.water.toStringAsFixed(1)}L, '
        'sleep ${log.sleep.toStringAsFixed(1)}h. '
        '${goalNote != null ? '$goalNote ' : ''}'
        '${contraceptionNote != null ? '$contraceptionNote ' : ''}'
        'Give supportive, practical '
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
  }

  void _openRelationshipCoach(BuildContext context) {
    final t = AppLocalizations.of(context);
    final subscription = context.read<SubscriptionProvider>();

    final languageName = switch (Localizations.localeOf(context).languageCode) {
      'fr' => 'French',
      'ar' => 'Arabic',
      _ => 'English',
    };

    final systemContext =
        "You are Dawrati's Relationship Coach, a warm and thoughtful assistant "
        'inside the Dawrati app. Your ONLY topic is helping the user connect '
        'with and communicate with her partner — emotional intimacy, explaining '
        'how her cycle affects her mood and energy, and practical relationship '
        'communication tips. Politely decline and redirect if asked about '
        'anything unrelated, including explicit sexual content, medical '
        'questions, or unrelated topics. Keep answers concise, warm and '
        'practical. You are not a therapist — for serious relationship or '
        'mental health concerns, suggest professional support. Always respond '
        'in $languageName.';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AiChatScreen(
          systemContext: systemContext,
          isPremium: subscription.isPremium,
          title: t.relationshipCoachTitle,
          starterMessage: t.relationshipCoachStarterMessage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final isPremium = context.watch<SubscriptionProvider>().isPremium;
    final cycle = context.watch<CycleProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 90),
        child: FloatingActionButton(
          heroTag: 'quickChatFab',
          onPressed: () => _openQuickChat(context),
          backgroundColor: Colors.white,
          elevation: 4,
          child: const CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xFFFFEAF3),
            backgroundImage: AssetImage('assets/images/articles/coach.png'),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 120),
          children: [
            FadeSlide(
              delay: 0,
              child: FloHeaderSection(
                onProfileTap: onOpenProfile,
                onCalendarTap: onOpenCalendar,
              ),
            ),

            const SizedBox(height: 18),

            const FadeSlide(
              delay: 80,
              child: WeekStripSection(),
            ),

            const SizedBox(height: 30),

            FadeSlide(
              delay: 160,
              child: CyclePredictionSection(
                phase: cycle.phase,
                daysUntilOvulation: cycle.daysUntilOvulation,
                onSeeInsights: onOpenInsights,
              ),
            ),

            const SizedBox(height: 30),

            FadeSlide(
              delay: 240,
              child: HomeActionsSection(
                onLogPeriod: onOpenCalendar ?? onChangerDate,
                onSymptoms: onOpenLog,
                onSex: () => _openRelationshipCoach(context),
              ),
            ),

            const SizedBox(height: 18),

            FadeSlide(
              delay: 280,
              child: InkWell(
                borderRadius: BorderRadius.circular(AppRadius.card),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PartnerCodeScreen()),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEDE7FF), Color(0xFFFFEAF3)],
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    border: Border.all(color: const Color(0xFF7C4DFF).withValues(alpha: .25)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.favorite_border, color: Color(0xFF7C4DFF)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.settingsPartner,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              t.settingsPartnerDesc,
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Color(0xFF7C4DFF)),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const FadeSlide(
              delay: 320,
              child: TodaysJourneySection(),
            ),

            const SizedBox(height: 30),

            const FadeSlide(
              delay: 400,
              child: DailyArticlesSection(),
            ),

            const SizedBox(height: 18),

            FadeSlide(
              delay: 440,
              child: InkWell(
                borderRadius: BorderRadius.circular(AppRadius.card),
                onTap: onOpenArticles,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEAF3),
                    borderRadius: BorderRadius.circular(AppRadius.card),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.menu_book_rounded, color: Color(0xFFE91E63)),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          t.browseAllArticles,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Color(0xFFE91E63)),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const FadeSlide(
              delay: 480,
              child: SymptomCheckerSection(),
            ),

            const SizedBox(height: 18),

            const FadeSlide(
              delay: 520,
              child: SymptomInsightSection(),
            ),

            const SizedBox(height: 30),

            const FadeSlide(
              delay: 560,
              child: RecommendationSection(),
            ),

            const SizedBox(height: 30),

            const FadeSlide(
              delay: 720,
              child: CycleHistorySection(),
            ),

            const SizedBox(height: 30),

            const FadeSlide(
              delay: 780,
              child: AiCoachPreviewSection(),
            ),

            if (!isPremium) ...[
              const SizedBox(height: 30),
              FadeSlide(
                delay: 860,
                child: SubscriptionPreviewSection(
                  onTap: () {
                    Navigator.pushNamed(context, '/premium');
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}