import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/notification_service.dart';

class NotificationSettingsProvider extends ChangeNotifier {
  bool periodReminder = true;
  bool ovulationReminder = true;
  bool waterReminder = false;
  bool sleepReminder = false;
  bool dailyLogReminder = false;
  bool pillReminder = false;

  TimeOfDay waterTime = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay sleepTime = const TimeOfDay(hour: 21, minute: 30);
  TimeOfDay dailyLogTime = const TimeOfDay(hour: 20, minute: 0);
  TimeOfDay pillTime = const TimeOfDay(hour: 9, minute: 0);

  NotificationSettingsProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();

    periodReminder = prefs.getBool('notif_period') ?? true;
    ovulationReminder = prefs.getBool('notif_ovulation') ?? true;
    waterReminder = prefs.getBool('notif_water') ?? false;
    sleepReminder = prefs.getBool('notif_sleep') ?? false;
    dailyLogReminder = prefs.getBool('notif_dailyLog') ?? false;
    pillReminder = prefs.getBool('notif_pill') ?? false;

    waterTime = _decodeTime(prefs.getString('notif_water_time')) ?? waterTime;
    sleepTime = _decodeTime(prefs.getString('notif_sleep_time')) ?? sleepTime;
    dailyLogTime = _decodeTime(prefs.getString('notif_dailyLog_time')) ?? dailyLogTime;
    pillTime = _decodeTime(prefs.getString('notif_pill_time')) ?? pillTime;

    notifyListeners();

    if (waterReminder) {
      await NotificationService.instance.scheduleDaily(
        id: NotificationService.waterReminderId,
        title: 'Dawrati',
        body: 'water',
        hour: waterTime.hour,
        minute: waterTime.minute,
      );
    }
    if (sleepReminder) {
      await NotificationService.instance.scheduleDaily(
        id: NotificationService.sleepReminderId,
        title: 'Dawrati',
        body: 'sleep',
        hour: sleepTime.hour,
        minute: sleepTime.minute,
      );
    }
    if (dailyLogReminder) {
      await NotificationService.instance.scheduleDaily(
        id: NotificationService.dailyLogReminderId,
        title: 'Dawrati',
        body: 'dailyLog',
        hour: dailyLogTime.hour,
        minute: dailyLogTime.minute,
      );
    }
    if (pillReminder) {
      await NotificationService.instance.scheduleDaily(
        id: NotificationService.pillReminderId,
        title: 'Dawrati',
        body: 'pill',
        hour: pillTime.hour,
        minute: pillTime.minute,
      );
    }
  }

  TimeOfDay? _decodeTime(String? raw) {
    if (raw == null) return null;
    final parts = raw.split(':');
    if (parts.length != 2) return null;
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  String _encodeTime(TimeOfDay time) => '${time.hour}:${time.minute}';

  Future<void> setPeriodReminder(
    bool value, {
    required String title,
    required String body,
    DateTime? predictedPeriodStart,
  }) async {
    periodReminder = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_period', value);

    if (value && predictedPeriodStart != null) {
      final reminderDate = predictedPeriodStart.subtract(const Duration(days: 2));
      await NotificationService.instance.scheduleOneOff(
        id: NotificationService.periodReminderId,
        title: title,
        body: body,
        date: DateTime(reminderDate.year, reminderDate.month, reminderDate.day, 9, 0),
      );
    } else {
      await NotificationService.instance.cancel(NotificationService.periodReminderId);
    }
  }

  Future<void> setOvulationReminder(
    bool value, {
    required String title,
    required String body,
    DateTime? predictedOvulationDate,
  }) async {
    ovulationReminder = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_ovulation', value);

    if (value && predictedOvulationDate != null) {
      await NotificationService.instance.scheduleOneOff(
        id: NotificationService.ovulationReminderId,
        title: title,
        body: body,
        date: DateTime(
          predictedOvulationDate.year,
          predictedOvulationDate.month,
          predictedOvulationDate.day,
          9,
          0,
        ),
      );
    } else {
      await NotificationService.instance.cancel(NotificationService.ovulationReminderId);
    }
  }

  Future<void> setWaterReminder(bool value, {required String title, required String body}) async {
    waterReminder = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_water', value);

    if (value) {
      await NotificationService.instance.scheduleDaily(
        id: NotificationService.waterReminderId,
        title: title,
        body: body,
        hour: waterTime.hour,
        minute: waterTime.minute,
      );
    } else {
      await NotificationService.instance.cancel(NotificationService.waterReminderId);
    }
  }

  Future<void> setSleepReminder(bool value, {required String title, required String body}) async {
    sleepReminder = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_sleep', value);

    if (value) {
      await NotificationService.instance.scheduleDaily(
        id: NotificationService.sleepReminderId,
        title: title,
        body: body,
        hour: sleepTime.hour,
        minute: sleepTime.minute,
      );
    } else {
      await NotificationService.instance.cancel(NotificationService.sleepReminderId);
    }
  }

  Future<void> setDailyLogReminder(bool value, {required String title, required String body}) async {
    dailyLogReminder = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_dailyLog', value);

    if (value) {
      await NotificationService.instance.scheduleDaily(
        id: NotificationService.dailyLogReminderId,
        title: title,
        body: body,
        hour: dailyLogTime.hour,
        minute: dailyLogTime.minute,
      );
    } else {
      await NotificationService.instance.cancel(NotificationService.dailyLogReminderId);
    }
  }

  Future<void> setPillReminder(bool value, {required String title, required String body}) async {
    pillReminder = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_pill', value);

    if (value) {
      await NotificationService.instance.scheduleDaily(
        id: NotificationService.pillReminderId,
        title: title,
        body: body,
        hour: pillTime.hour,
        minute: pillTime.minute,
      );
    } else {
      await NotificationService.instance.cancel(NotificationService.pillReminderId);
    }
  }

  Future<void> setPillTime(TimeOfDay time, {required String title, required String body}) async {
    pillTime = time;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('notif_pill_time', _encodeTime(time));

    if (pillReminder) {
      await NotificationService.instance.scheduleDaily(
        id: NotificationService.pillReminderId,
        title: title,
        body: body,
        hour: time.hour,
        minute: time.minute,
      );
    }
  }

  Future<void> setWaterTime(TimeOfDay time, {required String title, required String body}) async {
    waterTime = time;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('notif_water_time', _encodeTime(time));

    if (waterReminder) {
      await NotificationService.instance.scheduleDaily(
        id: NotificationService.waterReminderId,
        title: title,
        body: body,
        hour: time.hour,
        minute: time.minute,
      );
    }
  }

  Future<void> setSleepTime(TimeOfDay time, {required String title, required String body}) async {
    sleepTime = time;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('notif_sleep_time', _encodeTime(time));

    if (sleepReminder) {
      await NotificationService.instance.scheduleDaily(
        id: NotificationService.sleepReminderId,
        title: title,
        body: body,
        hour: time.hour,
        minute: time.minute,
      );
    }
  }

  Future<void> setDailyLogTime(TimeOfDay time, {required String title, required String body}) async {
    dailyLogTime = time;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('notif_dailyLog_time', _encodeTime(time));

    if (dailyLogReminder) {
      await NotificationService.instance.scheduleDaily(
        id: NotificationService.dailyLogReminderId,
        title: title,
        body: body,
        hour: time.hour,
        minute: time.minute,
      );
    }
  }
}
