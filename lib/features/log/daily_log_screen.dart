import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_color_scheme.dart';
import '../../core/widgets/fade_slide.dart';
import '../../l10n/app_localizations.dart';
import 'provider/daily_log_provider.dart';
import 'widgets/mood_selector.dart';
import 'widgets/symptoms_selector.dart';
import 'widgets/flow_card.dart';
import 'widgets/sleep_card.dart';
import 'widgets/water_card.dart';
import 'widgets/energy_card.dart';
import 'widgets/activity_card.dart';
import 'widgets/medication_card.dart';
import 'widgets/weight_card.dart';
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

  Set<String> symptoms = {};
  String? flow;
  double energy = 5;
  String? activity;
  double? weight;
  List<String> medications = [];

  final TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadEntryForSelectedDate());
  }

  void _loadEntryForSelectedDate() {
    final log = context.read<DailyLogProvider>();
    final entry = log.entryFor(selectedDate);

    setState(() {
      symptoms = entry?.symptoms.toSet() ?? {};
      flow = entry?.flow;
      energy = entry?.energy ?? 5;
      activity = entry?.activity;
      weight = entry?.weight;
      medications = entry?.medications ?? [];
      notesController.text = entry?.notes ?? '';
    });
  }

  void previousDay() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
    });
    _loadEntryForSelectedDate();
  }

  void nextDay() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
    });
    _loadEntryForSelectedDate();
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final log = context.watch<DailyLogProvider>();
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 120),
          children: [
            FadeSlide(delay: 0, child: _header(context, t)),
            const SizedBox(height: 22),

            FadeSlide(delay: 60, child: _dateSelector(context, t)),
            const SizedBox(height: 30),

            FadeSlide(
              delay: 120,
              child: MoodSelector(
                selectedMood: log.mood,
                onChanged: log.setMood,
              ),
            ),
            const SizedBox(height: 22),

            FadeSlide(
              delay: 180,
              child: SymptomsSelector(
                selectedSymptoms: symptoms,
                onToggle: (symptom) {
                  setState(() {
                    symptoms.contains(symptom)
                        ? symptoms.remove(symptom)
                        : symptoms.add(symptom);
                  });
                },
              ),
            ),
            const SizedBox(height: 22),

            FadeSlide(
              delay: 240,
              child: FlowCard(
                selectedFlow: flow,
                onChanged: (value) {
                  setState(() {
                    flow = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 22),

            FadeSlide(
              delay: 300,
              child: SleepCard(
                sleep: log.sleep,
                onChanged: log.setSleep,
              ),
            ),
            const SizedBox(height: 22),

            FadeSlide(
              delay: 360,
              child: WaterCard(
                water: log.water,
                onMinus: () => log.setWater(log.water - 0.25),
                onPlus: () => log.setWater(log.water + 0.25),
              ),
            ),
            const SizedBox(height: 22),

            FadeSlide(
              delay: 420,
              child: EnergyCard(
                energy: energy,
                onChanged: (value) {
                  setState(() {
                    energy = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 22),

            FadeSlide(
              delay: 480,
              child: ActivityCard(
                selectedActivity: activity,
                onChanged: (value) {
                  setState(() {
                    activity = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 22),

            FadeSlide(
              delay: 540,
              child: WeightCard(
                weight: weight,
                onChanged: (value) => setState(() => weight = value),
              ),
            ),
            const SizedBox(height: 22),

            FadeSlide(
              delay: 560,
              child: MedicationCard(
                medications: medications,
                onChanged: (value) => setState(() => medications = value),
              ),
            ),
            const SizedBox(height: 22),

            FadeSlide(delay: 600, child: NotesCard(controller: notesController)),
            const SizedBox(height: 30),
            const SizedBox(height: 22),

            const FadeSlide(
              delay: 640,
              child: DayScoreCard(score: 8.4),
            ),

            const SizedBox(height: 22),

            FadeSlide(
              delay: 680,
              child: AIInsightCard(
                insight: t.aiInsightSample,
              ),
            ),

const SizedBox(height: 30),
            SaveButton(
              onSave: () async {
                await log.saveLog(
                  selectedDate,
                  symptoms: symptoms.toList(),
                  flow: flow,
                  energy: energy,
                  activity: activity,
                  notes: notesController.text,
                  weight: weight,
                  medications: medications,
                );

                if (!context.mounted) return;

                final locale = Localizations.localeOf(context).toString();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      t.logSavedForDate(DateFormat.yMd(locale).format(selectedDate)),
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

  Widget _header(BuildContext context, AppLocalizations t) {
    return Row(
      children: [
        Expanded(
          child: Text(
            t.dailyLogLabel,
            style: const TextStyle(
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

  Widget _dateSelector(BuildContext context, AppLocalizations t) {
    final locale = Localizations.localeOf(context).toString();
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
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
                Text(
                  t.selectedDateLabel,
                  style: TextStyle(color: colors.textSecondary),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat.yMd(locale).format(selectedDate),
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
