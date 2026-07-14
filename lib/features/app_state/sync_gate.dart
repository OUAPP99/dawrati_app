import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/cloud_sync_service.dart';
import '../auth/auth_provider.dart';
import '../cycle/cycle_provider.dart';
import '../log/provider/daily_log_provider.dart';
import '../subscription/subscription_provider.dart';
import 'app_state_provider.dart';

/// Watches sign-in state and syncs local data with Firestore the moment a
/// user signs in. Brand-new accounts get seeded with whatever's already on
/// the device; returning accounts pull their cloud data down (cloud wins).
/// Guests (signed out) are untouched — everything stays local-only.
class SyncGate extends StatefulWidget {
  final Widget child;

  const SyncGate({super.key, required this.child});

  @override
  State<SyncGate> createState() => _SyncGateState();
}

class _SyncGateState extends State<SyncGate> {
  String? _lastSyncedUid;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final uid = auth.user?.uid;

    if (uid != null && uid != _lastSyncedUid) {
      _lastSyncedUid = uid;
      WidgetsBinding.instance.addPostFrameCallback((_) => _sync());
    }

    return widget.child;
  }

  Future<void> _sync() async {
    if (!mounted) return;

    final cycle = context.read<CycleProvider>();
    final dailyLog = context.read<DailyLogProvider>();
    final subscription = context.read<SubscriptionProvider>();
    final appState = context.read<AppStateProvider>();

    final cloudProfile = await CloudSyncService.instance.pullProfile();
    if (!mounted) return;

    if (cloudProfile == null) {
      // Brand-new account: seed the cloud with what's already on this device.
      await CloudSyncService.instance.pushPeriodStartDate(cycle.periodStartDate);
      await CloudSyncService.instance.pushPeriodHistory(cycle.periodHistory);
      await CloudSyncService.instance.pushEstimatedCycleLength(cycle.estimatedCycleLength);
      await CloudSyncService.instance.pushPeriodLength(cycle.periodLength);
      await CloudSyncService.instance.pushLanguageCode(appState.languageCode);
      await CloudSyncService.instance.pushSubscriptionPlan(subscription.plan.name);
      await CloudSyncService.instance.pushAllDailyLogs(dailyLog.history);
      await CloudSyncService.instance.pushProfileAnswers(
        goal: appState.userGoal,
        contraception: appState.contraceptionMethod,
        stress: appState.stressLevel,
        sleepQuality: appState.sleepQuality,
      );
      if (appState.weightKg != null) {
        await CloudSyncService.instance.pushWeightKg(appState.weightKg!);
      }
      if (appState.age != null) {
        await CloudSyncService.instance.pushAge(appState.age!);
      }
      return;
    }

    final cloudDateStr = cloudProfile['periodStartDate'] as String?;
    if (cloudDateStr != null) {
      final cloudHistory = (cloudProfile['periodHistory'] as List?)
          ?.map((e) => DateTime.parse(e as String))
          .toList();
      final cloudEstimate = cloudProfile['estimatedCycleLength'] as int?;
      final cloudPeriodLength = cloudProfile['periodLength'] as int?;
      await cycle.applyFromCloud(
        DateTime.parse(cloudDateStr),
        history: cloudHistory,
        estimatedLength: cloudEstimate,
        periodLengthDays: cloudPeriodLength,
      );
    }

    final cloudLang = cloudProfile['languageCode'] as String?;
    if (cloudLang != null && cloudLang != appState.languageCode) {
      await appState.setLanguage(cloudLang);
    }

    final cloudPlanName = cloudProfile['subscriptionPlan'] as String?;
    if (cloudPlanName != null) {
      final cloudPlan = SubscriptionPlan.values.firstWhere(
        (p) => p.name == cloudPlanName,
        orElse: () => SubscriptionPlan.free,
      );
      if (cloudPlan != subscription.plan) {
        await subscription.setPlan(cloudPlan);
      }
    }

    final cloudLogs = await CloudSyncService.instance.pullDailyLogs();
    if (cloudLogs.isNotEmpty) {
      await dailyLog.mergeCloudLogs(cloudLogs);
    }

    await appState.applyProfileAnswersFromCloud(
      goal: cloudProfile['userGoal'] as String?,
      contraception: cloudProfile['contraceptionMethod'] as String?,
      stress: cloudProfile['stressLevel'] as String?,
      sleep: cloudProfile['sleepQuality'] as String?,
    );
    await appState.applyWeightFromCloud((cloudProfile['weightKg'] as num?)?.toDouble());
    await appState.applyAgeFromCloud((cloudProfile['age'] as num?)?.toInt());

    final cloudBonusStr = cloudProfile['bonusPremiumUntil'] as String?;
    if (cloudBonusStr != null) {
      final cloudBonus = DateTime.tryParse(cloudBonusStr);
      if (cloudBonus != null) {
        await subscription.applyBonusPremiumFromCloud(cloudBonus);
      }
    }

    await _claimReferralCredits(subscription);
  }

  /// Applies any referral rewards earned while this user was the referrer
  /// (credited to their account by someone else's device on redemption)
  /// and clears them once applied.
  Future<void> _claimReferralCredits(SubscriptionProvider subscription) async {
    final credits = await CloudSyncService.instance.pullReferralCredits();
    if (credits.isEmpty) return;

    final totalDays = credits.fold<int>(0, (sum, c) => sum + c.value);
    if (totalDays > 0) {
      await subscription.grantBonusPremiumDays(totalDays);
    }
    for (final credit in credits) {
      await CloudSyncService.instance.deleteReferralCredit(credit.key);
    }
  }
}
