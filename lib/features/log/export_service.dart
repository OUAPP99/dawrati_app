import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../cycle/cycle_provider.dart';
import 'models/daily_log_entry.dart';

class ExportService {
  ExportService._();

  static String _csvField(String value) {
    if (value.contains(',') || value.contains('"') || value.contains('\n')) {
      return '"${value.replaceAll('"', '""')}"';
    }
    return value;
  }

  static String buildCsv(List<DailyLogEntry> history) {
    final sorted = [...history]..sort((a, b) => a.date.compareTo(b.date));
    final dateFormat = DateFormat('yyyy-MM-dd');

    final buffer = StringBuffer();
    buffer.writeln(
      [
        'Date', 'Water (L)', 'Sleep (h)', 'Mood', 'Symptoms', 'Flow',
        'Energy (1-10)', 'Activity', 'Weight (kg)',
        'Medications', 'Notes',
      ].map(_csvField).join(','),
    );

    for (final entry in sorted) {
      buffer.writeln(
        [
          dateFormat.format(entry.date),
          entry.water.toStringAsFixed(2),
          entry.sleep.toStringAsFixed(1),
          entry.mood,
          entry.symptoms.join('; '),
          entry.flow ?? '',
          entry.energy.toStringAsFixed(0),
          entry.activity ?? '',
          entry.weight?.toStringAsFixed(1) ?? '',
          entry.medications.join('; '),
          entry.notes,
        ].map(_csvField).join(','),
      );
    }

    return buffer.toString();
  }

  static Future<void> exportAndShare(List<DailyLogEntry> history) async {
    final csv = buildCsv(history);
    final bytes = utf8.encode(csv);
    final fileName = 'dawrati_export_${DateFormat('yyyyMMdd').format(DateTime.now())}.csv';

    await Share.shareXFiles(
      [XFile.fromData(bytes, name: fileName, mimeType: 'text/csv')],
      fileNameOverrides: [fileName],
    );
  }

  /// A human-readable plain-text summary of the cycle and recent daily
  /// logs, meant to be shared with a doctor — as opposed to [buildCsv],
  /// which is raw data for the user's own records.
  static String buildDoctorSummary(CycleProvider cycle, List<DailyLogEntry> history) {
    final dateFormat = DateFormat('MMM d, yyyy');
    final sorted = [...history]..sort((a, b) => a.date.compareTo(b.date));
    final recent = sorted.length > 60 ? sorted.sublist(sorted.length - 60) : sorted;

    final buffer = StringBuffer();
    buffer.writeln('Dawrati - Cycle & Symptom Summary');
    buffer.writeln('Generated ${dateFormat.format(DateTime.now())}');
    buffer.writeln('');

    buffer.writeln('CYCLE OVERVIEW');
    buffer.writeln(
      'Average cycle length: ${cycle.averageCycleLength} days'
      '${cycle.hasRealCycleData ? ' (based on ${cycle.periodHistory.length} logged periods)' : ' (estimated, not enough history yet)'}',
    );
    buffer.writeln('Average period length: ${cycle.periodLength} days');
    buffer.writeln('Last period start: ${dateFormat.format(cycle.periodStartDate)}');
    if (cycle.isIrregular) {
      buffer.writeln('Note: recent cycle lengths have varied by more than a week between cycles.');
    }
    buffer.writeln('');

    if (cycle.periodHistory.isNotEmpty) {
      buffer.writeln('LOGGED PERIOD START DATES');
      for (final date in cycle.periodHistory.reversed) {
        buffer.writeln('- ${dateFormat.format(date)}');
      }
      buffer.writeln('');
    }

    if (recent.isNotEmpty) {
      buffer.writeln('DAILY LOG (most recent ${recent.length} entries)');
      for (final entry in recent.reversed) {
        buffer.writeln('${dateFormat.format(entry.date)}:');
        buffer.writeln('  Mood: ${entry.mood}');
        if (entry.symptoms.isNotEmpty) buffer.writeln('  Symptoms: ${entry.symptoms.join(', ')}');
        if (entry.flow != null && entry.flow!.isNotEmpty) buffer.writeln('  Flow: ${entry.flow}');
        buffer.writeln('  Sleep: ${entry.sleep.toStringAsFixed(1)}h, Water: ${entry.water.toStringAsFixed(1)}L');
        if (entry.medications.isNotEmpty) buffer.writeln('  Medications: ${entry.medications.join(', ')}');
        if (entry.notes.isNotEmpty) buffer.writeln('  Notes: ${entry.notes}');
        buffer.writeln('');
      }
    } else {
      buffer.writeln('No daily logs recorded yet.');
    }

    return buffer.toString();
  }

  static Future<void> exportDoctorSummaryAndShare(
    CycleProvider cycle,
    List<DailyLogEntry> history,
  ) async {
    final summary = buildDoctorSummary(cycle, history);
    final bytes = utf8.encode(summary);
    final fileName = 'dawrati_doctor_summary_${DateFormat('yyyyMMdd').format(DateTime.now())}.txt';

    await Share.shareXFiles(
      [XFile.fromData(bytes, name: fileName, mimeType: 'text/plain')],
      fileNameOverrides: [fileName],
    );
  }

  /// Builds an .ics calendar file with predicted period and ovulation
  /// dates for the next 6 cycles, importable into any calendar app.
  static String buildIcs(CycleProvider cycle) {
    final dateFmt = DateFormat('yyyyMMdd');
    final stampFmt = DateFormat("yyyyMMdd'T'HHmmss'Z'").format(DateTime.now().toUtc());
    final length = cycle.averageCycleLength;

    var periodStart = cycle.nextPeriodStartDate;
    var ovulation = cycle.nextOvulationDate;

    final buffer = StringBuffer();
    buffer.writeln('BEGIN:VCALENDAR');
    buffer.writeln('VERSION:2.0');
    buffer.writeln('PRODID:-//Dawrati//Cycle Predictions//EN');
    buffer.writeln('CALSCALE:GREGORIAN');

    for (var i = 0; i < 6; i++) {
      final periodEnd = periodStart.add(Duration(days: cycle.periodLength));

      buffer.writeln('BEGIN:VEVENT');
      buffer.writeln('UID:dawrati-period-$i-${dateFmt.format(periodStart)}@dawrati.app');
      buffer.writeln('DTSTAMP:$stampFmt');
      buffer.writeln('DTSTART;VALUE=DATE:${dateFmt.format(periodStart)}');
      buffer.writeln('DTEND;VALUE=DATE:${dateFmt.format(periodEnd)}');
      buffer.writeln('SUMMARY:Predicted period');
      buffer.writeln('END:VEVENT');

      buffer.writeln('BEGIN:VEVENT');
      buffer.writeln('UID:dawrati-ovulation-$i-${dateFmt.format(ovulation)}@dawrati.app');
      buffer.writeln('DTSTAMP:$stampFmt');
      buffer.writeln('DTSTART;VALUE=DATE:${dateFmt.format(ovulation)}');
      buffer.writeln('SUMMARY:Predicted ovulation');
      buffer.writeln('END:VEVENT');

      periodStart = periodStart.add(Duration(days: length));
      ovulation = ovulation.add(Duration(days: length));
    }

    buffer.writeln('END:VCALENDAR');
    return buffer.toString().replaceAll('\n', '\r\n');
  }

  static Future<void> exportIcsAndShare(CycleProvider cycle) async {
    final ics = buildIcs(cycle);
    final bytes = utf8.encode(ics);
    final fileName = 'dawrati_cycle_${DateFormat('yyyyMMdd').format(DateTime.now())}.ics';

    await Share.shareXFiles(
      [XFile.fromData(bytes, name: fileName, mimeType: 'text/calendar')],
      fileNameOverrides: [fileName],
    );
  }
}
