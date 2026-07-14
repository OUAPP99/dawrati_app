import 'package:flutter/material.dart';
import '../../core/widgets/hayati_button.dart';
import '../../core/widgets/hayati_progress.dart';
import 'package:provider/provider.dart';
import '../../features/app_state/app_state_provider.dart';
import '../../features/cycle/cycle_provider.dart';
import '../../l10n/app_localizations.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  int step = 0;

  double age = 25;
  DateTime? lastPeriodDate;
  double periodLength = 5;
  double cycleLength = 28;
  double weight = 60;

  String? goal;
  String? contraception;
  String? stress;
  String? sleep;

  final int totalSteps = 10;

Future<void> next() async {
  if (step < totalSteps - 1) {
    setState(() => step++);
  } else {
    final cycle = context.read<CycleProvider>();
    final appState = context.read<AppStateProvider>();

    if (lastPeriodDate != null) {
      await cycle.updatePeriodStartDate(lastPeriodDate!);
    }
    await cycle.setEstimatedCycleLength(cycleLength.round());
    await cycle.setPeriodLength(periodLength.round());
    await appState.setProfileAnswers(
      goal: goal,
      contraception: contraception,
      stress: stress,
      sleep: sleep,
    );
    await appState.setWeightKg(weight);
    await appState.setAge(age.round());
    await appState.completeOnboarding();

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/home');
  }
}

  void back() {
    if (step > 0) setState(() => step--);
  }

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 7)),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (date != null) setState(() => lastPeriodDate = date);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    final pages = [
      _sliderQuestion(t.qAge, age, 10, 75, "", (v) => setState(() => age = v)),
      _dateQuestion(t),
      _sliderQuestion(t.qPeriodLength, periodLength, 1, 10, " days", (v) => setState(() => periodLength = v)),
      _sliderQuestion(t.qCycleLength, cycleLength, 21, 40, " days", (v) => setState(() => cycleLength = v)),
      _choiceQuestion(t.qGoal, {
        'trackCycle': t.goalTrackCycle,
        'getPregnant': t.goalGetPregnant,
        'avoidPregnancy': t.goalAvoidPregnancy,
        'understandHealth': t.goalUnderstandHealth,
      }, goal, (v) => setState(() => goal = v)),
      _choiceQuestion(t.qContraception, {
        'none': t.contraceptionNone,
        'pill': t.contraceptionPill,
        'iud': t.contraceptionIUD,
        'implant': t.contraceptionImplant,
        'other': t.contraceptionOther,
      }, contraception, (v) => setState(() => contraception = v)),
      _choiceQuestion(t.qStress, {
        'low': t.stressLow,
        'medium': t.stressMedium,
        'high': t.stressHigh,
      }, stress, (v) => setState(() => stress = v)),
      _choiceQuestion(t.qSleep, {
        'less6': t.sleepLess6,
        '6to8': t.sleep6to8,
        'more8': t.sleepMore8,
      }, sleep, (v) => setState(() => sleep = v)),
      _sliderQuestion(t.qWeight, weight, 35, 140, " kg", (v) => setState(() => weight = v)),
      _finishQuestion(t),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: HayatiProgress(value: (step + 1) / totalSteps),
            ),
            Positioned.fill(
              top: 70,
              bottom: 95,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: pages[step],
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Row(
                children: [
                  if (step > 0)
                    TextButton(
                      onPressed: back,
                      child: Text(t.back),
                    ),
                  const Spacer(),
                  SizedBox(
                    width: 170,
                    child: HayatiButton(
                      text: step == totalSteps - 1 ? t.goHome : t.continueLabel,
                      onPressed: next,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sliderQuestion(
    String title,
    double value,
    double min,
    double max,
    String suffix,
    ValueChanged<double> onChanged,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        const SizedBox(height: 30),
        Text("${value.round()}$suffix", style: TextStyle(fontSize: 58, fontWeight: FontWeight.bold, color: Colors.pink.shade700)),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).round(),
          label: "${value.round()}$suffix",
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _dateQuestion(AppLocalizations t) {
    final label = lastPeriodDate == null
        ? t.selectDate
        : "${lastPeriodDate!.day}/${lastPeriodDate!.month}/${lastPeriodDate!.year}";

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(t.qLastPeriod, textAlign: TextAlign.center, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: pickDate,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
            child: Row(
              children: [
                Icon(Icons.calendar_month, color: Colors.pink.shade400),
                const SizedBox(width: 14),
                Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Spacer(),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _choiceQuestion(
    String title,
    Map<String, String> options,
    String? selected,
    ValueChanged<String> onSelected,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        const SizedBox(height: 30),
        ...options.entries.map((option) {
          final isSelected = selected == option.key;
          return GestureDetector(
            onTap: () => onSelected(option.key),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isSelected ? Colors.pink.shade100 : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: isSelected ? Colors.pink : Colors.pink.shade100, width: 1.5),
              ),
              child: Text(option.value, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            ),
          );
        }),
      ],
    );
  }

  Widget _finishQuestion(AppLocalizations t) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_circle_rounded, size: 100, color: Colors.pink.shade400),
        const SizedBox(height: 25),
        Text(t.profileReadyTitle, textAlign: TextAlign.center, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text(t.profileReadyDesc, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 16)),
      ],
    );
  }
}