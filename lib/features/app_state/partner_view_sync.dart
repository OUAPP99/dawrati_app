import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/cloud_sync_service.dart';
import '../cycle/cycle_provider.dart';
import '../log/provider/daily_log_provider.dart';
import '../subscription/subscription_provider.dart';

/// Keeps the signed-in user's curated partner-view snapshot in Firestore up
/// to date whenever their cycle, today's log, or subscription tier changes.
class PartnerViewSync extends StatefulWidget {
  final Widget child;

  const PartnerViewSync({super.key, required this.child});

  @override
  State<PartnerViewSync> createState() => _PartnerViewSyncState();
}

class _PartnerViewSyncState extends State<PartnerViewSync> {
  String? _lastSignature;

  @override
  Widget build(BuildContext context) {
    final cycle = context.watch<CycleProvider>();
    final log = context.watch<DailyLogProvider>();
    final sub = context.watch<SubscriptionProvider>();

    final data = <String, dynamic>{
      'phase': cycle.phase,
      'cycleDay': cycle.cycleDay,
      'nextPeriodDate': cycle.nextPeriodStartDate.toIso8601String(),
      'nextOvulationDate': cycle.nextOvulationDate.toIso8601String(),
      'mood': log.mood,
      'water': log.water,
      'sleep': log.sleep,
      'isPremium': sub.isPremium,
      // Only used to render the Premium month calendar — same inputs
      // already implied by nextPeriodDate/nextOvulationDate above, so
      // this doesn't expose anything new.
      'periodStartDate': cycle.periodStartDate.toIso8601String(),
      'averageCycleLength': cycle.averageCycleLength,
      'periodLength': cycle.periodLength,
    };

    final signature = data.toString();
    if (signature != _lastSignature) {
      _lastSignature = signature;
      scheduleMicrotask(() => unawaited(CloudSyncService.instance.pushPartnerView(data)));
    }

    return widget.child;
  }
}
