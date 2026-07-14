class DailyLogEntry {
  final DateTime date;
  final double water;
  final double sleep;
  final String mood;
  final List<String> symptoms;
  final String? flow;
  final double energy;
  final String? activity;
  final String notes;
  final double? weight;
  final List<String> medications;

  DailyLogEntry({
    required this.date,
    required this.water,
    required this.sleep,
    required this.mood,
    this.symptoms = const [],
    this.flow,
    this.energy = 5,
    this.activity,
    this.notes = '',
    this.weight,
    this.medications = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'water': water,
      'sleep': sleep,
      'mood': mood,
      'symptoms': symptoms,
      'flow': flow,
      'energy': energy,
      'activity': activity,
      'notes': notes,
      'weight': weight,
      'medications': medications,
    };
  }

  factory DailyLogEntry.fromJson(Map<String, dynamic> json) {
    return DailyLogEntry(
      date: DateTime.parse(json['date']),
      water: (json['water'] as num).toDouble(),
      sleep: (json['sleep'] as num).toDouble(),
      mood: json['mood'],
      symptoms: (json['symptoms'] as List?)?.map((e) => e as String).toList() ?? const [],
      flow: json['flow'] as String?,
      energy: (json['energy'] as num?)?.toDouble() ?? 5,
      activity: json['activity'] as String?,
      notes: json['notes'] as String? ?? '',
      weight: (json['weight'] as num?)?.toDouble(),
      medications: (json['medications'] as List?)?.map((e) => e as String).toList() ?? const [],
    );
  }
}
