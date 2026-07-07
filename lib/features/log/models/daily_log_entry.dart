class DailyLogEntry {
  final DateTime date;
  final double water;
  final double sleep;
  final String mood;

  DailyLogEntry({
    required this.date,
    required this.water,
    required this.sleep,
    required this.mood,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'water': water,
      'sleep': sleep,
      'mood': mood,
    };
  }

  factory DailyLogEntry.fromJson(Map<String, dynamic> json) {
    return DailyLogEntry(
      date: DateTime.parse(json['date']),
      water: (json['water'] as num).toDouble(),
      sleep: (json['sleep'] as num).toDouble(),
      mood: json['mood'],
    );
  }
}