import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';

import '../../l10n/app_localizations.dart';
import '../../l10n/label_translations.dart';
import '../../features/cycle/cycle_provider.dart';

/// Pushes the current cycle day/phase to the Android home screen widget.
/// Text is pre-formatted and localized here so the native widget code
/// stays a dumb display layer. Premium users get extra rows (days until
/// next period, days until ovulation, logging streak) — free users only
/// see the day and phase.
class HomeWidgetService {
  HomeWidgetService._();

  static const String _androidProviderName = 'CycleWidgetProvider';

  static Future<void> update(
    CycleProvider cycle,
    AppLocalizations t, {
    required bool isPremium,
    int? streak,
  }) async {
    if (kIsWeb) return;

    try {
      await HomeWidget.saveWidgetData('cycleDay', t.dayLabel(cycle.cycleDay));
      await HomeWidget.saveWidgetData('cyclePhase', translatePhase(t, cycle.phase));
      await HomeWidget.saveWidgetData('isPremium', isPremium);

      if (isPremium) {
        await HomeWidget.saveWidgetData('periodCountdown', '🩸 ${cycle.daysUntilNextPeriod}');
        await HomeWidget.saveWidgetData('ovulationCountdown', '✨ ${cycle.daysUntilOvulation}');
        final streakValue = streak ?? 0;
        await HomeWidget.saveWidgetData(
          'streakText',
          streakValue >= 2 ? '🔥 $streakValue' : '',
        );
      } else {
        await HomeWidget.saveWidgetData('periodCountdown', '');
        await HomeWidget.saveWidgetData('ovulationCountdown', '');
        await HomeWidget.saveWidgetData('streakText', '');
      }

      await HomeWidget.updateWidget(androidName: _androidProviderName);
    } catch (_) {
      // Widget not pinned, or platform doesn't support it — non-fatal.
    }
  }
}
