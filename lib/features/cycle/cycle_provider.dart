import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/cloud_sync_service.dart';

class CycleProvider extends ChangeNotifier {
  static const int defaultCycleLength = 28;
  static const int _minValidCycleLength = 21;
  static const int _maxValidCycleLength = 45;

  static const int defaultPeriodLength = 5;
  static const int _minValidPeriodLength = 1;
  static const int _maxValidPeriodLength = 10;

  DateTime periodStartDate = DateTime(2026, 7, 1);

  /// Every period start date the user has logged or corrected, oldest
  /// first. Used to compute a real, personalized average cycle length.
  List<DateTime> periodHistory = [];

  /// Self-reported cycle length from onboarding, used as the prediction
  /// basis until enough real history (2+ logged periods) is available.
  int estimatedCycleLength = defaultCycleLength;

  /// Self-reported period length from onboarding, used everywhere the app
  /// needs to know how many days a period lasts.
  int periodLength = defaultPeriodLength;

  CycleProvider() {
    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDate = prefs.getString('periodStartDate');
    final savedHistory = prefs.getStringList('periodHistory');
    final savedEstimate = prefs.getInt('estimatedCycleLength');
    final savedPeriodLength = prefs.getInt('periodLength');

    if (savedDate != null) {
      periodStartDate = DateTime.parse(savedDate);
    }

    if (savedHistory != null && savedHistory.isNotEmpty) {
      periodHistory = savedHistory.map(DateTime.parse).toList()..sort();
    } else if (savedDate != null) {
      // Migrate accounts that only ever had a single date: seed history.
      periodHistory = [periodStartDate];
    }

    if (savedEstimate != null) {
      estimatedCycleLength = savedEstimate;
    }

    if (savedPeriodLength != null) {
      periodLength = savedPeriodLength;
    }

    notifyListeners();
  }

  Future<void> updatePeriodStartDate(DateTime date) async {
    periodStartDate = date;
    _recordHistory(date);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('periodStartDate', date.toIso8601String());
    await _persistHistory(prefs);

    unawaited(CloudSyncService.instance.pushPeriodStartDate(date));
    unawaited(CloudSyncService.instance.pushPeriodHistory(periodHistory));
  }

  /// Sets the user's self-reported average cycle length (collected during
  /// onboarding). Only used as the prediction basis before real history
  /// builds up.
  Future<void> setEstimatedCycleLength(int days) async {
    estimatedCycleLength = days.clamp(_minValidCycleLength, _maxValidCycleLength);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('estimatedCycleLength', estimatedCycleLength);

    unawaited(CloudSyncService.instance.pushEstimatedCycleLength(estimatedCycleLength));
  }

  /// Sets the user's self-reported period length (collected during
  /// onboarding).
  Future<void> setPeriodLength(int days) async {
    periodLength = days.clamp(_minValidPeriodLength, _maxValidPeriodLength);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('periodLength', periodLength);

    unawaited(CloudSyncService.instance.pushPeriodLength(periodLength));
  }

  void _recordHistory(DateTime date) {
    periodHistory.removeWhere(
      (d) => d.year == date.year && d.month == date.month && d.day == date.day,
    );
    periodHistory.add(date);
    periodHistory.sort();

    // Cap history length so this never grows unbounded for long-time users.
    if (periodHistory.length > 12) {
      periodHistory = periodHistory.sublist(periodHistory.length - 12);
    }
  }

  Future<void> _persistHistory(SharedPreferences prefs) async {
    await prefs.setStringList(
      'periodHistory',
      periodHistory.map((d) => d.toIso8601String()).toList(),
    );
  }

  /// Applies cloud-synced cycle data without re-pushing it (avoids a
  /// redundant write right after a pull).
  Future<void> applyFromCloud(
    DateTime date, {
    List<DateTime>? history,
    int? estimatedLength,
    int? periodLengthDays,
  }) async {
    periodStartDate = date;
    if (history != null && history.isNotEmpty) {
      periodHistory = [...history]..sort();
    }
    if (estimatedLength != null) {
      estimatedCycleLength = estimatedLength;
    }
    if (periodLengthDays != null) {
      periodLength = periodLengthDays;
    }
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('periodStartDate', date.toIso8601String());
    if (history != null) {
      await _persistHistory(prefs);
    }
    if (estimatedLength != null) {
      await prefs.setInt('estimatedCycleLength', estimatedCycleLength);
    }
    if (periodLengthDays != null) {
      await prefs.setInt('periodLength', periodLength);
    }
  }

  /// True once there's enough logged history (2+ periods) to base
  /// predictions on real data instead of the onboarding estimate.
  bool get hasRealCycleData => periodHistory.length >= 2;

  /// Day-to-day gaps between consecutive logged periods, filtered to a
  /// plausible cycle-length range and capped to the most recent 6 — the
  /// shared basis for both the average cycle length and the irregularity
  /// check below.
  List<int> get _recentCycleLengthDiffs {
    if (periodHistory.length < 2) return [];

    final sorted = [...periodHistory]..sort();
    final diffs = <int>[];
    for (var i = 1; i < sorted.length; i++) {
      final diff = sorted[i].difference(sorted[i - 1]).inDays;
      if (diff >= _minValidCycleLength && diff <= _maxValidCycleLength) {
        diffs.add(diff);
      }
    }

    return diffs.length > 6 ? diffs.sublist(diffs.length - 6) : diffs;
  }

  /// The average cycle length to use for every prediction: computed from
  /// real logged history when there's enough of it, otherwise falls back
  /// to the user's onboarding estimate (or the 28-day default).
  int get averageCycleLength {
    final recent = _recentCycleLengthDiffs;
    if (recent.isEmpty) return estimatedCycleLength;

    final avg = recent.reduce((a, b) => a + b) / recent.length;
    return avg.round();
  }

  /// True once there are enough logged cycles (4+ periods, 3+ gaps) to
  /// meaningfully judge whether the cycle is regular.
  bool get hasEnoughDataForRegularityCheck => _recentCycleLengthDiffs.length >= 3;

  /// True when recent cycle lengths swing by more than a week from one
  /// cycle to the next — worth a gentle nudge to mention to a doctor.
  /// Purely informational, not a diagnosis.
  bool get isIrregular {
    final diffs = _recentCycleLengthDiffs;
    if (diffs.length < 3) return false;

    final maxDiff = diffs.reduce((a, b) => a > b ? a : b);
    final minDiff = diffs.reduce((a, b) => a < b ? a : b);
    return (maxDiff - minDiff) >= 8;
  }

  int get cycleDay {
    return DateTime.now().difference(periodStartDate).inDays + 1;
  }

  int get daysUntilNextPeriod {
    final remaining = averageCycleLength - cycleDay;
    return remaining < 0 ? 0 : remaining;
  }

  /// Days until the next predicted ovulation (always ~14 days before the
  /// next period, whatever the overall cycle length is).
  int get daysUntilOvulation {
    final ovulationDay = averageCycleLength - 14;
    final remaining = ovulationDay - cycleDay;
    return remaining < 0 ? 0 : remaining;
  }

  String get phase {
    final ovulationDay = averageCycleLength - 14;
    if (cycleDay <= periodLength) return "Menstruation";
    if (cycleDay <= ovulationDay - 1) return "Follicular Phase";
    if (cycleDay <= ovulationDay + 2) return "Ovulation";
    return "Luteal Phase";
  }

  /// Best-effort cycle phase for an arbitrary past date, using today's
  /// average cycle length as an approximation for every past cycle. Used
  /// to correlate historical daily logs with the phase they were logged in.
  String phaseForDate(DateTime date) {
    final length = averageCycleLength;
    final ovulationDay = length - 14;
    final rawDay = date.difference(periodStartDate).inDays + 1;
    final day = ((rawDay - 1) % length) + 1;

    if (day <= periodLength) return "Menstruation";
    if (day <= ovulationDay - 1) return "Follicular Phase";
    if (day <= ovulationDay + 2) return "Ovulation";
    return "Luteal Phase";
  }

  double get progress {
    return (cycleDay / averageCycleLength).clamp(0.0, 1.0);
  }

  DateTime get nextPeriodStartDate {
    return DateTime.now().add(Duration(days: daysUntilNextPeriod));
  }

  DateTime get nextOvulationDate {
    final cycleLength = averageCycleLength;
    final currentCycleStart = periodStartDate.add(
      Duration(days: ((cycleDay - 1) ~/ cycleLength) * cycleLength),
    );
    var ovulation = currentCycleStart.add(Duration(days: cycleLength - 14));

    if (ovulation.isBefore(DateTime.now())) {
      ovulation = ovulation.add(Duration(days: cycleLength));
    }

    return ovulation;
  }
}
