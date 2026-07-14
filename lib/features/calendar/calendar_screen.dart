import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/fade_slide.dart';
import '../cycle/cycle_provider.dart';
import '../log/models/daily_log_entry.dart';
import '../log/provider/daily_log_provider.dart';
import 'widgets/bottom_sheet_day.dart';
import 'widgets/calendar_grid.dart';
import 'widgets/calendar_phase_card.dart';
import 'widgets/cycle_timeline.dart';
import 'widgets/daily_log_preview.dart';
import 'widgets/fertility_card.dart';
import 'widgets/week_header.dart';
import 'widgets/calendar_hero_header.dart';
import 'widgets/calendar_legend_v2.dart';

class CalendarScreen extends StatefulWidget {
  final DateTime dateDebutRegles;
  final ValueChanged<DateTime>? onSelectDate;

  const CalendarScreen({
    super.key,
    required this.dateDebutRegles,
    this.onSelectDate,
  });

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime currentMonth;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    currentMonth = DateTime(now.year, now.month);
    selectedDate = DateTime(now.year, now.month, now.day);
  }

  int get cycleLength => context.read<CycleProvider>().averageCycleLength;
  int get periodLength => context.read<CycleProvider>().periodLength;

  int cycleDayFor(DateTime date) {
    return date.difference(widget.dateDebutRegles).inDays + 1;
  }

  String phaseFor(int cycleDay) {
    final length = cycleLength;
    final day = ((cycleDay - 1) % length) + 1;
    final ovulationDay = length - 14;

    if (day <= periodLength) return "Menstruation";
    if (day <= ovulationDay - 1) return "Follicular";
    if (day <= ovulationDay + 2) return "Ovulation";
    return "Luteal";
  }

  DailyLogEntry? findEntry(List<DailyLogEntry> history, DateTime date) {
    for (final entry in history) {
      if (entry.date.year == date.year &&
          entry.date.month == date.month &&
          entry.date.day == date.day) {
        return entry;
      }
    }
    return null;
  }

  void previousMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    });
  }

  void nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    });
  }

  void openDaySheet(BuildContext context, DateTime date, DailyLogEntry? entry) {
    final cycleDay = cycleDayFor(date);
    final phase = phaseFor(cycleDay);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BottomSheetDay(
          date: date,
          cycleDay: cycleDay,
          phase: phase,
          entry: entry,
          onSetPeriodStart: () {
            Navigator.pop(context);
            widget.onSelectDate?.call(date);
          },
        );
      },
    );
  }

  String pregnancyChance(int cycleDay) {
    final length = cycleLength;
    final day = ((cycleDay - 1) % length) + 1;
    final ovulationDay = length - 14;

    if (day == ovulationDay) return "Peak";
    if (day >= ovulationDay - 3 && day <= ovulationDay + 1) return "High";
    if (day >= ovulationDay - 6 && day <= ovulationDay + 3) return "Medium";
    return "Low";
  }

  @override
  Widget build(BuildContext context) {
    final log = context.watch<DailyLogProvider>();

    final selectedCycleDay = cycleDayFor(selectedDate);
    final selectedPhase = phaseFor(selectedCycleDay);
    final selectedEntry = findEntry(log.history, selectedDate);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
          children: [
            FadeSlide(
              delay: 0,
              child: CalendarHeroHeader(
                currentMonth: currentMonth,
                cycleDay: selectedCycleDay,
                phase: selectedPhase,
                onPrevious: previousMonth,
                onNext: nextMonth,
              ),
            ),

            const SizedBox(height: 24),

            FadeSlide(
              delay: 80,
              child: Column(
                children: [
                  const WeekHeader(),
                  const SizedBox(height: 18),
                  CalendarGrid(
                    currentMonth: currentMonth,
                    periodStartDate: widget.dateDebutRegles,
                    cycleLength: cycleLength,
                    periodLength: periodLength,
                    selectedDate: selectedDate,
                    onSelectDate: (date) {
                      final entry = findEntry(log.history, date);

                      setState(() {
                        selectedDate = date;
                      });

                      openDaySheet(context, date, entry);
                    },
                  ),
                  const SizedBox(height: 10),
                  const CalendarLegendV2(),
                ],
              ),
            ),

            const SizedBox(height: 28),

            FadeSlide(
              delay: 160,
              child: CalendarPhaseCard(
                cycleDay: selectedCycleDay,
                phase: selectedPhase,
                onTap: () => openDaySheet(context, selectedDate, selectedEntry),
              ),
            ),

            const SizedBox(height: 18),

            FadeSlide(
              delay: 240,
              child: FertilityCard(
                chance: pregnancyChance(selectedCycleDay),
                onTap: () => openDaySheet(context, selectedDate, selectedEntry),
              ),
            ),

            const SizedBox(height: 18),

            FadeSlide(
              delay: 320,
              child: CycleTimeline(
                cycleDay: selectedCycleDay,
                cycleLength: cycleLength,
              ),
            ),

            const SizedBox(height: 18),

            FadeSlide(
              delay: 400,
              child: DailyLogPreview(entry: selectedEntry),
            ),
          ],
        ),
      ),
    );
  }
}