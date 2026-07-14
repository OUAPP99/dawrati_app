import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/cloud_sync_service.dart';

class AppStateProvider extends ChangeNotifier {
  bool hasCompletedOnboarding = false;

  /// Defaults to Arabic. Changed only when the user explicitly taps
  /// "Change language" (splash screen or Profile > Settings > Language).
  String languageCode = 'ar';

  /// Onboarding answers, stored as stable keys (not localized text) so
  /// they stay meaningful regardless of the app's current language.
  /// Null until the user completes onboarding.
  String? userGoal; // trackCycle | getPregnant | avoidPregnancy | understandHealth
  String? contraceptionMethod; // none | pill | iud | implant | other
  String? stressLevel; // low | medium | high
  String? sleepQuality; // less6 | 6to8 | more8

  /// Self-reported weight from onboarding, in kilograms. Used to
  /// personalize the Nutrition Coach without asking again.
  double? weightKg;

  /// Self-reported age from onboarding. Used to personalize the Nutrition
  /// Coach without asking again.
  int? age;

  AppStateProvider() {
    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    hasCompletedOnboarding =
        prefs.getBool('hasCompletedOnboarding') ?? false;
    languageCode = prefs.getString('languageCode') ?? 'ar';
    userGoal = prefs.getString('userGoal');
    contraceptionMethod = prefs.getString('contraceptionMethod');
    stressLevel = prefs.getString('stressLevel');
    sleepQuality = prefs.getString('sleepQuality');
    weightKg = prefs.getDouble('weightKg');
    age = prefs.getInt('age');
    notifyListeners();
  }

  Future<void> setWeightKg(double kg) async {
    weightKg = kg;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('weightKg', kg);

    unawaited(CloudSyncService.instance.pushWeightKg(kg));
  }

  /// Applies a cloud-synced weight without re-pushing it.
  Future<void> applyWeightFromCloud(double? kg) async {
    if (kg == null) return;
    weightKg = kg;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('weightKg', kg);
  }

  Future<void> setAge(int years) async {
    age = years;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('age', years);

    unawaited(CloudSyncService.instance.pushAge(years));
  }

  /// Applies a cloud-synced age without re-pushing it.
  Future<void> applyAgeFromCloud(int? years) async {
    if (years == null) return;
    age = years;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('age', years);
  }

  /// Saves the questionnaire's goal/contraception/stress/sleep answers.
  /// Any argument left null leaves that field unchanged.
  Future<void> setProfileAnswers({
    String? goal,
    String? contraception,
    String? stress,
    String? sleep,
  }) async {
    if (goal != null) userGoal = goal;
    if (contraception != null) contraceptionMethod = contraception;
    if (stress != null) stressLevel = stress;
    if (sleep != null) sleepQuality = sleep;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    if (goal != null) await prefs.setString('userGoal', goal);
    if (contraception != null) await prefs.setString('contraceptionMethod', contraception);
    if (stress != null) await prefs.setString('stressLevel', stress);
    if (sleep != null) await prefs.setString('sleepQuality', sleep);

    unawaited(CloudSyncService.instance.pushProfileAnswers(
      goal: goal,
      contraception: contraception,
      stress: stress,
      sleepQuality: sleep,
    ));
  }

  /// Applies cloud-synced profile answers without re-pushing them.
  Future<void> applyProfileAnswersFromCloud({
    String? goal,
    String? contraception,
    String? stress,
    String? sleep,
  }) async {
    if (goal == null && contraception == null && stress == null && sleep == null) return;

    if (goal != null) userGoal = goal;
    if (contraception != null) contraceptionMethod = contraception;
    if (stress != null) stressLevel = stress;
    if (sleep != null) sleepQuality = sleep;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    if (goal != null) await prefs.setString('userGoal', goal);
    if (contraception != null) await prefs.setString('contraceptionMethod', contraception);
    if (stress != null) await prefs.setString('stressLevel', stress);
    if (sleep != null) await prefs.setString('sleepQuality', sleep);
  }

  Future<void> setLanguage(String code) async {
    languageCode = code;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', code);

    unawaited(CloudSyncService.instance.pushLanguageCode(code));
  }

  Future<void> completeOnboarding() async {
    hasCompletedOnboarding = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasCompletedOnboarding', true);
  }

  Future<void> resetOnboarding() async {
    hasCompletedOnboarding = false;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasCompletedOnboarding', false);
  }
}