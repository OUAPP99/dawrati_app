import 'package:flutter/material.dart';

import '../screens/splash/splash_screen.dart';
import '../screens/language/language_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/questionnaire/questionnaire_screen.dart';
import '../features/main/main_navigation_screen.dart';
import '../features/premium/premium_screen.dart';
import '../features/ai/ai_coach_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String language = '/language';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String questionnaire = '/questionnaire';
  static const String home = '/home';
  static const String premium = '/premium';
  static const String aiCoach = '/ai-coach';

  static Map<String, WidgetBuilder> routes({
    required DateTime dateDebutRegles,
    required Map<String, String> textes,
    required ValueChanged<DateTime> onChangerDate,
    
  }
  ) {
    return {
      splash: (context) => const SplashScreen(),
      language: (context) => const LanguageScreen(),
      onboarding: (context) => const OnboardingScreen(),
      login: (context) => const LoginScreen(),
      questionnaire: (context) => const QuestionnaireScreen(),
      home: (context) => MainNavigationScreen(
            dateDebutRegles: dateDebutRegles,
            textes: textes,
            onChangerDate: onChangerDate,
          ),
          premium: (context) => const PremiumScreen(),
          aiCoach: (context) => const AiCoachScreen(),
    };
  }
}