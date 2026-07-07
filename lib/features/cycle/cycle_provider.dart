import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CycleProvider extends ChangeNotifier {
  DateTime periodStartDate = DateTime(2026, 7, 1);

  CycleProvider() {
    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDate = prefs.getString('periodStartDate');

    if (savedDate != null) {
      periodStartDate = DateTime.parse(savedDate);
      notifyListeners();
    }
  }

  Future<void> updatePeriodStartDate(DateTime date) async {
    periodStartDate = date;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('periodStartDate', date.toIso8601String());
  }

  int get cycleDay {
    return DateTime.now().difference(periodStartDate).inDays + 1;
  }

  int get daysUntilNextPeriod {
    const cycleLength = 28;
    final remaining = cycleLength - cycleDay;
    return remaining < 0 ? 0 : remaining;
  }

  String get phase {
    if (cycleDay <= 5) return "Menstruation";
    if (cycleDay <= 13) return "Follicular Phase";
    if (cycleDay <= 16) return "Ovulation";
    return "Luteal Phase";
  }

  double get progress {
    return (cycleDay / 28).clamp(0.0, 1.0);
  }
}