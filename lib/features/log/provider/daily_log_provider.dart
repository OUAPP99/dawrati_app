import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/cloud_sync_service.dart';
import '../models/daily_log_entry.dart';

class DailyLogProvider extends ChangeNotifier {
  List<DailyLogEntry> history = [];

  double water = 0.0;
  double sleep = 8.0;
  String mood = "😊 Good";

  DailyLogProvider() {
    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    water = prefs.getDouble('water') ?? 0.0;
    sleep = prefs.getDouble('sleep') ?? 8.0;
    mood = prefs.getString('mood') ?? "😊 Good";

    final savedHistory = prefs.getStringList("daily_history");

    if (savedHistory != null) {
      history = savedHistory
          .map((e) => DailyLogEntry.fromJson(jsonDecode(e)))
          .toList();
    }

    notifyListeners();
  }

Future<void> saveLog(
  DateTime date, {
  List<String> symptoms = const [],
  String? flow,
  double energy = 5,
  String? activity,
  String notes = '',
  double? weight,
  List<String> medications = const [],
}) async {
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
      symptoms: symptoms,
      flow: flow,
      energy: energy,
      activity: activity,
      notes: notes,
      weight: weight,
      medications: medications,
    ),
  );

  final prefs = await SharedPreferences.getInstance();

  final jsonList = history.map((e) => jsonEncode(e.toJson())).toList();

  await prefs.setStringList("daily_history", jsonList);

  notifyListeners();

  unawaited(CloudSyncService.instance.pushDailyLog(history.last));
}

  /// Merges cloud daily logs into local history (cloud entries take
  /// precedence for matching dates) without re-pushing them to Firestore.
  Future<void> mergeCloudLogs(List<DailyLogEntry> cloudLogs) async {
    for (final cloudEntry in cloudLogs) {
      history.removeWhere(
        (e) =>
            e.date.year == cloudEntry.date.year &&
            e.date.month == cloudEntry.date.month &&
            e.date.day == cloudEntry.date.day,
      );
      history.add(cloudEntry);
    }

    final prefs = await SharedPreferences.getInstance();
    final jsonList = history.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList("daily_history", jsonList);

    notifyListeners();
  }

  DailyLogEntry? entryFor(DateTime date) {
    for (final entry in history) {
      if (entry.date.year == date.year &&
          entry.date.month == date.month &&
          entry.date.day == date.day) {
        return entry;
      }
    }
    return null;
  }

  /// Number of consecutive days (ending today or yesterday) with a saved
  /// daily log. Counting from yesterday too keeps the streak alive for
  /// the rest of today even before it's been logged yet.
  int get currentStreak {
    final today = DateTime.now();
    var cursor = DateTime(today.year, today.month, today.day);

    if (entryFor(cursor) == null) {
      cursor = cursor.subtract(const Duration(days: 1));
      if (entryFor(cursor) == null) return 0;
    }

    var streak = 0;
    while (entryFor(cursor) != null) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
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