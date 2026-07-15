import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_color_scheme.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/widgets/animated_tap.dart';
import '../../../l10n/app_localizations.dart';
import '../../ai/ai_chat_screen.dart';
import '../../app_state/app_state_provider.dart';
import '../../subscription/subscription_provider.dart';

class RecommendationSection extends StatelessWidget {
  const RecommendationSection({super.key});

  void _openNutritionCoach(BuildContext context) {
    final t = AppLocalizations.of(context);
    final isPremium = context.read<SubscriptionProvider>().isPremium;
    final appState = context.read<AppStateProvider>();
    final weightKg = appState.weightKg;
    final age = appState.age;

    final languageName = switch (Localizations.localeOf(context).languageCode) {
      'fr' => 'French',
      'ar' => 'Arabic',
      _ => 'English',
    };

    final knownWeightNote = weightKg != null ? 'Their weight is already known: ${weightKg.round()}kg. ' : '';
    final knownAgeNote = age != null ? 'Their age is already known: $age. ' : '';

    final systemContext =
        "You are Dawrati's Nutrition Coach, a knowledgeable and encouraging "
        'nutrition assistant inside the Dawrati app. Your ONLY topic is food, '
        'nutrition, and calorie/goal calculations — politely decline and redirect '
        'if the user asks about anything unrelated to nutrition (including general '
        'cycle, symptom or medical questions). $knownWeightNote$knownAgeNote'
        'If you do not yet have their height, activity level, and goal '
        '(lose, maintain, or gain weight), ask for whichever of those you are '
        'missing. Once you have enough information, estimate their daily '
        'calorie needs and suggest a simple, practical eating approach to '
        'reach their goal. Keep answers concise and practical. You are not a '
        'doctor or registered dietitian — for medical conditions or '
        'restrictive diets, suggest consulting a professional. Always '
        'respond in $languageName.';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AiChatScreen(
          systemContext: systemContext,
          isPremium: isPremium,
          title: t.nutritionCoachTitle,
          starterMessage: t.nutritionCoachStarterMessage,
        ),
      ),
    );
  }

  void _openSleepCoach(BuildContext context) {
    final t = AppLocalizations.of(context);
    final isPremium = context.read<SubscriptionProvider>().isPremium;

    final languageName = switch (Localizations.localeOf(context).languageCode) {
      'fr' => 'French',
      'ar' => 'Arabic',
      _ => 'English',
    };

    final systemContext =
        "You are Dawrati's Sleep Coach, a calm and knowledgeable sleep "
        'assistant inside the Dawrati app. Your ONLY topic is sleep — falling '
        'asleep, staying asleep, sleep hygiene, and how the menstrual cycle '
        'affects sleep — politely decline and redirect if the user asks about '
        'anything unrelated to sleep. Ask follow-up questions about their sleep '
        'habits and symptoms, then give practical, gentle suggestions to help '
        'them sleep better. Keep answers concise and practical. You are not a '
        'doctor — for a suspected sleep disorder, suggest consulting a '
        'healthcare professional. Always respond in $languageName.';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AiChatScreen(
          systemContext: systemContext,
          isPremium: isPremium,
          title: t.sleepCoachTitle,
          starterMessage: t.sleepCoachStarterMessage,
          premiumOnly: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.recommendedForYou,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: context.colors.textPrimary,
          ),
        ),

        const SizedBox(height: 20),

        _card(
          Colors.pink.shade50,
          Icons.auto_awesome,
          t.dawratiAiLabel,
          t.aiRecommendationText,
          avatarImage: 'assets/images/articles/coach.png',
          onTap: () => Navigator.pushNamed(context, '/ai-coach'),
        ),

        const SizedBox(height: 18),

        _card(
          Colors.orange.shade50,
          Icons.restaurant,
          t.nutritionLabel,
          t.nutritionRecommendationText,
          avatarImage: 'assets/images/articles/Nutrition.png',
          onTap: () => _openNutritionCoach(context),
        ),

        const SizedBox(height: 18),

        _card(
          Colors.blue.shade50,
          Icons.nightlight_round,
          t.sleepLabel,
          t.sleepRecommendationText,
          avatarImage: 'assets/images/articles/Sleep.png',
          onTap: () => _openSleepCoach(context),
        ),
      ],
    );
  }

  Widget _card(
    Color color,
    IconData icon,
    String title,
    String text, {
    VoidCallback? onTap,
    String? avatarImage,
  }) {
    final content = Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: AppShadows.soft,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.white,
              backgroundImage: avatarImage != null ? AssetImage(avatarImage) : null,
              child: avatarImage != null ? null : Icon(icon),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    text,
                    style: const TextStyle(
                      height: 1.4,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

    if (onTap == null) return content;

    return AnimatedTap(onTap: onTap, child: content);
  }
}