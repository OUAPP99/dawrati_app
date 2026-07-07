import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/daily_log_entry.dart';

class DailyLogProvider extends ChangeNotifier {
  List<DailyLogEntry> history = [];

  double water = 0.0;
  double sleep = 8.0;
  String mood = "😊 Happy";

  DailyLogProvider() {
    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    water = prefs.getDouble('water') ?? 0.0;
    sleep = prefs.getDouble('sleep') ?? 8.0;
    mood = prefs.getString('mood') ?? "😊 Happy";

    final savedHistory = prefs.getStringList("daily_history");

    if (savedHistory != null) {
      history = savedHistory
          .map((e) => DailyLogEntry.fromJson(jsonDecode(e)))
          .toList();
    }

    notifyListeners();
  }

Future<void> saveLog(DateTime date) async {
  history.removeWhere(
    (e) =>
        e.date.year == date.year &&
        e.date.month == date.month &&
        e.date.day == date.day,
  );

  history.add(
    DailyLogEntry(
      date: date,
      water: water,
      sleep: sleep,
      mood: mood,
    ),
  );

  final prefs = await SharedPreferences.getInstance();

  final jsonList = history.map((e) => jsonEncode(e.toJson())).toList();

  await prefs.setStringList("daily_history", jsonList);

  notifyListeners();
}
  

  Future<void> setWater(double value) async {
    water = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('water', water);
  }

  Future<void> setSleep(double value) async {
    sleep = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('sleep', sleep);
  }

  Future<void> setMood(String value) async {
    mood = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('mood', mood);
  }
}