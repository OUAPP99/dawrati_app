import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SubscriptionPlan {
  free,
  premium,
  premiumPlus,
}

class SubscriptionProvider extends ChangeNotifier {
  SubscriptionPlan plan = SubscriptionPlan.free;

  bool get isFree => plan == SubscriptionPlan.free;
  bool get isPremium =>
      plan == SubscriptionPlan.premium || plan == SubscriptionPlan.premiumPlus;
  bool get isPremiumPlus => plan == SubscriptionPlan.premiumPlus;

  SubscriptionProvider() {
    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPlan = prefs.getString('subscription_plan');

    if (savedPlan == 'premium') {
      plan = SubscriptionPlan.premium;
    } else if (savedPlan == 'premiumPlus') {
      plan = SubscriptionPlan.premiumPlus;
    } else {
      plan = SubscriptionPlan.free;
    }

    notifyListeners();
  }

  Future<void> setPlan(SubscriptionPlan newPlan) async {
    plan = newPlan;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('subscription_plan', newPlan.name);
  }
}