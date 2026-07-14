import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/cloud_sync_service.dart';
import 'billing_service.dart';

enum SubscriptionPlan {
  free,
  premium,
}

class SubscriptionProvider extends ChangeNotifier {
  SubscriptionPlan plan = SubscriptionPlan.free;

  /// Temporary premium access earned from referral rewards, independent of
  /// any real subscription. Grants [isPremium] while still in the future.
  DateTime? bonusPremiumUntil;

  bool get _hasBonusPremium =>
      bonusPremiumUntil != null && bonusPremiumUntil!.isAfter(DateTime.now());

  bool get isFree => plan == SubscriptionPlan.free && !_hasBonusPremium;
  bool get isPremium => plan == SubscriptionPlan.premium || _hasBonusPremium;

  /// Real store products (price, title) once [loadProducts] has run.
  /// Empty until the store responds — the paywall should fall back to a
  /// loading state rather than showing stale hardcoded prices.
  List<ProductDetails> products = [];

  bool billingAvailable = false;
  bool purchaseInProgress = false;
  String? purchaseError;

  SubscriptionProvider() {
    load();
    _initBilling();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPlan = prefs.getString('subscription_plan');

    plan = savedPlan == 'premium' ? SubscriptionPlan.premium : SubscriptionPlan.free;

    final savedBonus = prefs.getString('bonus_premium_until');
    if (savedBonus != null) bonusPremiumUntil = DateTime.tryParse(savedBonus);

    notifyListeners();
  }

  /// Adds referral-earned premium days on top of whatever bonus time is
  /// already banked, rather than resetting it.
  Future<void> grantBonusPremiumDays(int days) async {
    final now = DateTime.now();
    final base = _hasBonusPremium ? bonusPremiumUntil! : now;
    bonusPremiumUntil = base.add(Duration(days: days));
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('bonus_premium_until', bonusPremiumUntil!.toIso8601String());

    unawaited(CloudSyncService.instance.pushBonusPremiumUntil(bonusPremiumUntil!));
  }

  /// Applies a cloud-synced bonus expiry without re-pushing it.
  Future<void> applyBonusPremiumFromCloud(DateTime until) async {
    if (bonusPremiumUntil != null && !until.isAfter(bonusPremiumUntil!)) return;

    bonusPremiumUntil = until;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('bonus_premium_until', until.toIso8601String());
  }

  Future<void> _initBilling() async {
    BillingService.instance.onPurchaseSuccess = (productId) {
      purchaseInProgress = false;
      purchaseError = null;
      setPlan(SubscriptionPlan.premium);
    };
    BillingService.instance.onPurchaseError = (message) {
      purchaseInProgress = false;
      purchaseError = message;
      notifyListeners();
    };
    BillingService.instance.onPurchaseCanceled = () {
      purchaseInProgress = false;
      notifyListeners();
    };

    billingAvailable = await BillingService.instance.initialize();
    notifyListeners();

    if (billingAvailable) {
      await loadProducts();
    }
  }

  Future<void> loadProducts() async {
    products = await BillingService.instance.queryProducts();
    notifyListeners();
  }

  Future<void> purchase(ProductDetails product) async {
    purchaseInProgress = true;
    purchaseError = null;
    notifyListeners();

    try {
      await BillingService.instance.buy(product);
    } catch (e) {
      purchaseInProgress = false;
      purchaseError = e.toString();
      notifyListeners();
    }
  }

  Future<void> restorePurchases() async {
    purchaseInProgress = true;
    purchaseError = null;
    notifyListeners();

    // Restored purchases arrive asynchronously via the purchase stream
    // (handled by onPurchaseSuccess); if there's nothing to restore the
    // stream stays silent, so clear the spinner once the request itself
    // has been submitted rather than waiting indefinitely.
    await BillingService.instance.restorePurchases();
    purchaseInProgress = false;
    notifyListeners();
  }

  Future<void> setPlan(SubscriptionPlan newPlan) async {
    plan = newPlan;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('subscription_plan', newPlan.name);

    unawaited(CloudSyncService.instance.pushSubscriptionPlan(newPlan.name));
  }

  @override
  void dispose() {
    BillingService.instance.dispose();
    super.dispose();
  }
}