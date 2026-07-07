import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/mini_bar_chart.dart';
import '../cycle/cycle_provider.dart';
import '../log/provider/daily_log_provider.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cycle = context.watch<CycleProvider>();
    final log = context.watch<DailyLogProvider>();

    final last7 = log.history.length <= 7
        ? log.history
        : log.history.sublist(log.history.length - 7);

    final waterValues =
        last7.isEmpty ? List.filled(7, 0.0) : last7.map((e) => e.water).toList();

    final sleepValues =
        last7.isEmpty ? List.filled(7, 0.0) : last7.map((e) => e.sleep).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 120),
          children: [
            const Text(
              "Insights",
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 24),

            _hero(cycle.phase, cycle.cycleDay),
            const SizedBox(height: 22),

            Row(
              children: [
                Expanded(child: _smallCard("Water", "${log.water.toStringAsFixed(1)}L", Icons.water_drop, Colors.blue)),
                const SizedBox(width: 14),
                Expanded(child: _smallCard("Sleep", "${log.sleep.toStringAsFixed(1)}h", Icons.bedtime, Colors.indigo)),
              ],
            ),
            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(child: _smallCard("Mood", log.mood.split(" ").first, Icons.mood, Colors.orange)),
                const SizedBox(width: 14),
                Expanded(child: _smallCard("Logs", "${log.history.length}", Icons.edit_note, Colors.green)),
              ],
            ),

            const SizedBox(height: 28),
            _chartCard("Hydration", "Last 7 days", waterValues, Colors.blue),

            const SizedBox(height: 22),
            _chartCard("Sleep", "Last 7 days", sleepValues, Colors.indigo),

            const SizedBox(height: 22),
            _aiCard(
              "You are currently in the ${cycle.phase}. "
              "Your latest log shows ${log.water.toStringAsFixed(1)}L water, "
              "${log.sleep.toStringAsFixed(1)}h sleep and mood: ${log.mood}.",
            ),

            const SizedBox(height: 22),
            _premiumCard(),
          ],
        ),
      ),
    );
  }

  Widget _hero(String phase, int cycleDay) {
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
          const Text("Cycle Overview", style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          Text("Day $cycleDay", style: const TextStyle(fontSize: 46, fontWeight: FontWeight.w900)),
          const SizedBox(height: 6),
          Text(phase, style: const TextStyle(fontSize: 22, color: Color(0xFFE91E63), fontWeight: FontWeight.w800)),
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

  Widget _chartCard(String title, String subtitle, List<double> values, Color color) {
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
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 22),
          MiniBarChart(values: values, color: color),
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

  Widget _premiumCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1B2E),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Advanced Insights", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
          SizedBox(height: 10),
          Text(
            "Unlock cycle trends, symptom patterns and AI health analysis.",
            style: TextStyle(color: Colors.white70, height: 1.4),
          ),
          SizedBox(height: 14),
          Text("Premium →", style: TextStyle(color: Color(0xFFFFC1D6), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}