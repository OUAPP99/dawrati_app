import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/daily_log_provider.dart';
import 'widgets/mood_selector.dart';
import 'widgets/symptoms_selector.dart';
import 'widgets/flow_card.dart';
import 'widgets/sleep_card.dart';
import 'widgets/water_card.dart';
import 'widgets/energy_card.dart';
import 'widgets/activity_card.dart';
import 'widgets/notes_card.dart';
import 'widgets/save_button.dart';
import 'widgets/day_score_card.dart';
import 'widgets/ai_insight_card.dart';

class DailyLogScreen extends StatefulWidget {
  const DailyLogScreen({super.key});

  @override
  State<DailyLogScreen> createState() => _DailyLogScreenState();
}

class _DailyLogScreenState extends State<DailyLogScreen> {
  DateTime selectedDate = DateTime.now();

  final Set<String> symptoms = {};
  String? flow;
  double energy = 5;
  String? activity;

  final TextEditingController notesController = TextEditingController();

  void previousDay() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
    });
  }

  void nextDay() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
    });
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final log = context.watch<DailyLogProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 120),
          children: [
            _header(context),
            const SizedBox(height: 22),

            _dateSelector(),
            const SizedBox(height: 30),

            MoodSelector(
              selectedMood: log.mood,
              onChanged: log.setMood,
            ),
            const SizedBox(height: 22),

            SymptomsSelector(
              selectedSymptoms: symptoms,
              onToggle: (symptom) {
                setState(() {
                  symptoms.contains(symptom)
                      ? symptoms.remove(symptom)
                      : symptoms.add(symptom);
                });
              },
            ),
            const SizedBox(height: 22),

            FlowCard(
              selectedFlow: flow,
              onChanged: (value) {
                setState(() {
                  flow = value;
                });
              },
            ),
            const SizedBox(height: 22),

            SleepCard(
              sleep: log.sleep,
              onChanged: log.setSleep,
            ),
            const SizedBox(height: 22),

            WaterCard(
              water: log.water,
              onMinus: () => log.setWater(log.water - 0.25),
              onPlus: () => log.setWater(log.water + 0.25),
            ),
            const SizedBox(height: 22),

            EnergyCard(
              energy: energy,
              onChanged: (value) {
                setState(() {
                  energy = value;
                });
              },
            ),
            const SizedBox(height: 22),

            ActivityCard(
              selectedActivity: activity,
              onChanged: (value) {
                setState(() {
                  activity = value;
                });
              },
            ),
            const SizedBox(height: 22),

            NotesCard(controller: notesController),
            const SizedBox(height: 30),
            const SizedBox(height: 22),

             const DayScoreCard(
             score: 8.4,
),

            const SizedBox(height: 22),

            const AIInsightCard(
           insight:
      "Based on today's mood, sleep and hydration, your body seems to be recovering well. Continue drinking water and prioritize good sleep tonight.",
),

const SizedBox(height: 30),
            SaveButton(
              onSave: () async {
                await log.saveLog(selectedDate);

                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Log saved for ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            "Daily Log",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }

  Widget _dateSelector() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: previousDay,
            icon: const Icon(Icons.chevron_left),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "Selected date",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: nextDay,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}