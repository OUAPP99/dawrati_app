import 'package:flutter/material.dart';

import '../../core/widgets/fade_slide.dart';
import 'sections/flo_header_section.dart';
import 'sections/week_strip_section.dart';
import 'sections/cycle_prediction_section.dart';
import 'sections/home_actions_section.dart';
import 'sections/todays_journey_section.dart';
import 'sections/daily_articles_section.dart';
import 'sections/symptom_checker_section.dart';
import 'sections/cycle_learning_section.dart';
import 'sections/recommendation_section.dart';
import 'sections/cycle_history_section.dart';
import 'sections/ai_coach_preview_section.dart';
import 'sections/subscription_preview_section.dart';

class HomeScreen extends StatelessWidget {
  final DateTime dateDebutRegles;
  final VoidCallback onChangerDate;
  final VoidCallback? onOpenCalendar;
  final VoidCallback? onOpenLog;

  const HomeScreen({
    super.key,
    required this.dateDebutRegles,
    required this.onChangerDate,
    this.onOpenCalendar,
    this.onOpenLog,
  });

  int get cycleDay {
    return DateTime.now().difference(dateDebutRegles).inDays + 1;
  }

  String get phase {
    if (cycleDay <= 5) return "Menstruation";
    if (cycleDay <= 13) return "Follicular";
    if (cycleDay <= 16) return "Ovulation";
    return "Luteal";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 120),
          children: [
            const FadeSlide(
              delay: 0,
              child: FloHeaderSection(),
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
                cycleDay: cycleDay,
                phase: phase,
              ),
            ),

            const SizedBox(height: 30),

            FadeSlide(
              delay: 240,
              child: HomeActionsSection(
                onLogPeriod: onOpenCalendar ?? onChangerDate,
                onSymptoms: onOpenLog,
                onSex: onOpenLog,
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

            const SizedBox(height: 30),

            const FadeSlide(
              delay: 480,
              child: SymptomCheckerSection(),
            ),

            const SizedBox(height: 30),

            const FadeSlide(
              delay: 560,
              child: CycleLearningSection(),
            ),

            const SizedBox(height: 30),

            const FadeSlide(
              delay: 640,
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
        ),
      ),
    );
  }
}