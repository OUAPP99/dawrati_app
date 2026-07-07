import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateProvider extends ChangeNotifier {
  bool hasCompletedOnboarding = false;

  AppStateProvider() {
    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    hasCompletedOnboarding =
        prefs.getBool('hasCompletedOnboarding') ?? false;
    notifyListeners();
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