import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/home_widget_service.dart';
import '../../l10n/app_localizations.dart';
import '../cycle/cycle_provider.dart';
import '../log/provider/daily_log_provider.dart';
import '../subscription/subscription_provider.dart';

/// Keeps the Android home screen widget's cycle day/phase up to date
/// whenever it changes or the app's language changes. Must live inside
/// MaterialApp (unlike SyncGate/PartnerViewSync) since it needs
/// AppLocalizations, which isn't available above the Localizations widget.
class HomeWidgetSync extends StatefulWidget {
  final Widget child;

  const HomeWidgetSync({super.key, required this.child});

  @override
  State<HomeWidgetSync> createState() => _HomeWidgetSyncState();
}

class _HomeWidgetSyncState extends State<HomeWidgetSync> {
  String? _lastSignature;

  @override
  Widget build(BuildContext context) {
    final cycle = context.watch<CycleProvider>();
    final isPremium = context.watch<SubscriptionProvider>().isPremium;
    final streak = context.watch<DailyLogProvider>().currentStreak;
    final t = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;

    final signature = '${cycle.cycleDay}-${cycle.phase}-$languageCode-$isPremium-$streak';
    if (signature != _lastSignature) {
      _lastSignature = signature;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        HomeWidgetService.update(cycle, t, isPremium: isPremium, streak: streak);
      });
    }

    return widget.child;
  }
}
