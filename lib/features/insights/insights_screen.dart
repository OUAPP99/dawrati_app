import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/trend_chart.dart';
import '../../core/widgets/fade_slide.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/label_translations.dart';
import '../cycle/cycle_provider.dart';
import '../log/export_service.dart';
import '../log/provider/daily_log_provider.dart';
import '../subscription/subscription_provider.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  int rangeDays = 7;

  @override
  Widget build(BuildContext context) {
    final cycle = context.watch<CycleProvider>();
    final log = context.watch<DailyLogProvider>();
    final isPremium = context.watch<SubscriptionProvider>().isPremium;
    final t = AppLocalizations.of(context);

    final sorted = [...log.history]..sort((a, b) => a.date.compareTo(b.date));
    final range = sorted.length <= rangeDays
        ? sorted
        : sorted.sublist(sorted.length - rangeDays);

    final dates = range.map((e) => e.date).toList();
    final waterValues = range.map((e) => e.water).toList();
    final sleepValues = range.map((e) => e.sleep).toList();
    final moodValues = range.map((e) => moodScore(e.mood).toDouble()).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 120),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    t.insightsTitle,
                    style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900),
                  ),
                ),
                PopupMenuButton<String>(
                  tooltip: t.exportChooseFormat,
                  icon: const Icon(Icons.ios_share),
                  onSelected: (value) async {
                    if (value == 'ics') {
                      await ExportService.exportIcsAndShare(cycle);
                      return;
                    }
                    if (value == 'csv' && !isPremium) {
                      Navigator.pushNamed(context, '/premium');
                      return;
                    }
                    if (log.history.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(t.exportNoData)),
                      );
                      return;
                    }
                    if (value == 'csv') {
                      await ExportService.exportAndShare(log.history);
                    } else {
                      await ExportService.exportDoctorSummaryAndShare(cycle, log.history);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'csv',
                      child: Row(
                        children: [
                          Text(t.exportCsvOption),
                          if (!isPremium) ...[
                            const SizedBox(width: 6),
                            Icon(Icons.lock, size: 14, color: Colors.grey.shade500),
                          ],
                        ],
                      ),
                    ),
                    PopupMenuItem(value: 'doctor', child: Text(t.exportDoctorSummary)),
                    PopupMenuItem(value: 'ics', child: Text(t.exportIcsOption)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            FadeSlide(delay: 0, child: _hero(t, cycle.phase, cycle.cycleDay)),
            const SizedBox(height: 22),

            FadeSlide(
              delay: 80,
              child: Row(
                children: [
                  Expanded(child: _smallCard(t.waterLabel, "${log.water.toStringAsFixed(1)}L", Icons.water_drop, Colors.blue)),
                  const SizedBox(width: 14),
                  Expanded(child: _smallCard(t.sleepLabel, "${log.sleep.toStringAsFixed(1)}h", Icons.bedtime, Colors.indigo)),
                ],
              ),
            ),
            const SizedBox(height: 14),

            FadeSlide(
              delay: 140,
              child: Row(
                children: [
                  Expanded(child: _smallCard(t.moodLabel, translateMoodString(t, log.mood), Icons.mood, Colors.orange)),
                  const SizedBox(width: 14),
                  Expanded(child: _smallCard(t.logsLabel, "${log.history.length}", Icons.edit_note, Colors.green)),
                ],
              ),
            ),

            const SizedBox(height: 28),

            FadeSlide(
              delay: 200,
              child: _rangeSelector(context, t, isPremium),
            ),

            const SizedBox(height: 18),
            FadeSlide(
              delay: 240,
              child: _chartCard(
                t.hydrationTitle,
                TrendChart(
                  dates: dates,
                  values: waterValues,
                  color: Colors.blue,
                  minY: 0,
                  maxY: (waterValues.isEmpty ? 2.0 : (waterValues.reduce((a, b) => a > b ? a : b) * 1.2)).clamp(1.0, double.infinity),
                  valueLabel: (v) => "${v.toStringAsFixed(1)}L",
                  leftAxisLabel: (v) => "${v.toStringAsFixed(0)}L",
                  noDataLabel: t.noDataYetLabel,
                ),
              ),
            ),

            const SizedBox(height: 22),
            FadeSlide(
              delay: 280,
              child: _chartCard(
                t.sleepLabel,
                TrendChart(
                  dates: dates,
                  values: sleepValues,
                  color: Colors.indigo,
                  minY: 0,
                  maxY: (sleepValues.isEmpty ? 10.0 : (sleepValues.reduce((a, b) => a > b ? a : b) * 1.2)).clamp(4.0, double.infinity),
                  valueLabel: (v) => "${v.toStringAsFixed(1)}h",
                  leftAxisLabel: (v) => "${v.toStringAsFixed(0)}h",
                  noDataLabel: t.noDataYetLabel,
                ),
              ),
            ),

            const SizedBox(height: 22),
            FadeSlide(
              delay: 320,
              child: _chartCard(
                t.moodTrendTitle,
                TrendChart(
                  dates: dates,
                  values: moodValues,
                  color: Colors.orange,
                  minY: 1,
                  maxY: 5,
                  valueLabel: (v) => moodScoreEmojis[(v.round() - 1).clamp(0, 4)],
                  leftAxisLabel: (v) => moodScoreEmojis[(v.round() - 1).clamp(0, 4)],
                  noDataLabel: t.noDataYetLabel,
                ),
              ),
            ),

            const SizedBox(height: 22),
            FadeSlide(
              delay: 360,
              child: _aiCard(
                t.aiInsightDynamicText(
                  translatePhase(t, cycle.phase),
                  log.water.toStringAsFixed(1),
                  log.sleep.toStringAsFixed(1),
                  translateMoodString(t, log.mood),
                ),
              ),
            ),

            if (!isPremium) ...[
              const SizedBox(height: 22),
              FadeSlide(delay: 420, child: _premiumCard(t)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _rangeSelector(BuildContext context, AppLocalizations t, bool isPremium) {
    return Row(
      children: [
        Expanded(child: _rangeChip(context, t.last7Days, 7, locked: false)),
        const SizedBox(width: 12),
        Expanded(child: _rangeChip(context, t.last30Days, 30, locked: !isPremium)),
      ],
    );
  }

  Widget _rangeChip(BuildContext context, String label, int days, {required bool locked}) {
    final selected = rangeDays == days;

    return GestureDetector(
      onTap: () {
        if (locked) {
          Navigator.pushNamed(context, '/premium');
          return;
        }
        setState(() => rangeDays = days);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE91E63) : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (locked) ...[
              Icon(Icons.lock, size: 14, color: selected ? Colors.white : Colors.grey.shade500),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _hero(AppLocalizations t, String phase, int cycleDay) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFEAF3), Color(0xFFFFF7FA)],
        ),
        borderRadius: BorderRadius.circular(34),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.cycleOverview, style: const TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          Text(t.dayLabel(cycleDay), style: const TextStyle(fontSize: 46, fontWeight: FontWeight.w900)),
          const SizedBox(height: 6),
          Text(translatePhase(t, phase), style: const TextStyle(fontSize: 22, color: Color(0xFFE91E63), fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }

  Widget _smallCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _chartCard(String title, Widget chart) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 18),
          chart,
        ],
      ),
    );
  }

  Widget _aiCard(String text) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEAF3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.auto_awesome, color: Color(0xFFE91E63)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, height: 1.45, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _premiumCard(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1B2E),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.advancedInsights, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),
          Text(
            t.advancedInsightsDesc,
            style: const TextStyle(color: Colors.white70, height: 1.4),
          ),
          const SizedBox(height: 14),
          Text(t.premiumArrow, style: const TextStyle(color: Color(0xFFFFC1D6), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
