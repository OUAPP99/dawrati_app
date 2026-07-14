import 'package:shared_preferences/shared_preferences.dart';

/// Tracks how many free AI messages the user has sent today.
/// Premium users bypass this entirely (checked separately by the caller).
class AiUsageLimiter {
  static const int freeMessagesPerDay = 3;

  static String _todayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }

  static Future<int> messagesSentToday() async {
    final prefs = await SharedPreferences.getInstance();
    final storedDate = prefs.getString('ai_usage_date');

    if (storedDate != _todayKey()) return 0;

    return prefs.getInt('ai_usage_count') ?? 0;
  }

  static Future<int> remainingFreeMessages() async {
    final used = await messagesSentToday();
    final remaining = freeMessagesPerDay - used;
    return remaining < 0 ? 0 : remaining;
  }

  static Future<void> recordMessageSent() async {
    final prefs = await SharedPreferences.getInstance();
    final used = await messagesSentToday();

    await prefs.setString('ai_usage_date', _todayKey());
    await prefs.setInt('ai_usage_count', used + 1);
  }
}
