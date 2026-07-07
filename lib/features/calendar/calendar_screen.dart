import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  int cycleDayFor(DateTime date) {
    return date.difference(widget.dateDebutRegles).inDays + 1;
  }

  String phaseFor(int cycleDay) {
    final day = ((cycleDay - 1) % 28) + 1;

    if (day <= 5) return "Menstruation";
    if (day <= 13) return "Follicular";
    if (day <= 16) return "Ovulation";
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
    final day = ((cycleDay - 1) % 28) + 1;

    if (day == 14) return "Peak";
    if (day >= 11 && day <= 15) return "High";
    if (day >= 8 && day <= 17) return "Medium";
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
            CalendarHeroHeader(
              currentMonth: currentMonth,
              cycleDay: selectedCycleDay,
              phase: selectedPhase,
              onPrevious: previousMonth,
              onNext: nextMonth,
            ),

            const SizedBox(height: 24),

            const WeekHeader(),

            const SizedBox(height: 18),

            CalendarGrid(
              
              currentMonth: currentMonth,
              periodStartDate: widget.dateDebutRegles,
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
            const SizedBox(height: 28),

            CalendarPhaseCard(
              cycleDay: selectedCycleDay,
              phase: selectedPhase,
            ),

            const SizedBox(height: 18),

            FertilityCard(
              chance: pregnancyChance(selectedCycleDay),
            ),

            const SizedBox(height: 18),

            CycleTimeline(
              cycleDay: selectedCycleDay,
            ),

            const SizedBox(height: 18),

            DailyLogPreview(entry: selectedEntry),
          ],
        ),
      ),
    );
  }
}