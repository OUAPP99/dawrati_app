import 'package:flutter/material.dart';

import '../screens/splash/splash_screen.dart';
import '../screens/language/language_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/questionnaire/questionnaire_screen.dart';
import '../features/main/main_navigation_screen.dart';
import '../features/premium/premium_screen.dart';
import '../features/ai/ai_coach_screen.dart';
import '../features/notifications/notification_settings_screen.dart';
import '../features/profile/privacy_screen.dart';
import '../features/profile/cycle_settings_screen.dart';
import '../features/profile/help_support_screen.dart';
import '../features/referral/referral_screen.dart';
import '../features/security/app_lock_settings_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String language = '/language';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String questionnaire = '/questionnaire';
  static const String home = '/home';
  static const String premium = '/premium';
  static const String aiCoach = '/ai-coach';
  static const String notificationSettings = '/notification-settings';
  static const String privacy = '/privacy';
  static const String cycleSettings = '/cycle-settings';
  static const String helpSupport = '/help-support';
  static const String appLockSettings = '/app-lock-settings';
  static const String referral = '/referral';

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
          notificationSettings: (context) => const NotificationSettingsScreen(),
          privacy: (context) => const PrivacyScreen(),
          cycleSettings: (context) => const CycleSettingsScreen(),
          helpSupport: (context) => const HelpSupportScreen(),
          appLockSettings: (context) => const AppLockSettingsScreen(),
          referral: (context) => const ReferralScreen(),
    };
  }
}