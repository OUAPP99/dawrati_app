import 'package:flutter/material.dart';

import '../models/calendar_day_model.dart';
import 'calendar_day_cell.dart';

class CalendarGrid extends StatelessWidget {
  final DateTime currentMonth;
  final DateTime periodStartDate;
  final DateTime selectedDate;
  final int cycleLength;
  final int periodLength;
  final ValueChanged<DateTime> onSelectDate;

  const CalendarGrid({
    super.key,
    required this.currentMonth,
    required this.periodStartDate,
    required this.selectedDate,
    required this.onSelectDate,
    this.cycleLength = 28,
    this.periodLength = 5,
  });

  int _cycleDayFor(DateTime date) {
    final difference = date.difference(periodStartDate).inDays + 1;
    return ((difference - 1) % cycleLength) + 1;
  }

  bool _sameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  int get _ovulationDay => cycleLength - 14;

  bool _isPeriod(int cycleDay) => cycleDay >= 1 && cycleDay <= periodLength;
  bool _isFertile(int cycleDay) => cycleDay >= _ovulationDay - 3 && cycleDay <= _ovulationDay + 1;
  bool _isOvulation(int cycleDay) => cycleDay == _ovulationDay;

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(currentMonth.year, currentMonth.month, 1);
    final daysInMonth = DateTime(
      currentMonth.year,
      currentMonth.month + 1,
      0,
    ).day;

    final startWeekday = firstDay.weekday % 7;
    final totalCells = daysInMonth + startWeekday;
    final totalRows = (totalCells / 7).ceil();
    final now = DateTime.now();

    return Column(
      children: List.generate(totalRows, (row) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: List.generate(7, (col) {
              final index = row * 7 + col;

              if (index < startWeekday || index >= totalCells) {
                return const Expanded(child: SizedBox(height: 54));
              }

              final day = index - startWeekday + 1;
              final date = DateTime(currentMonth.year, currentMonth.month, day);
              final cycleDay = _cycleDayFor(date);

              final model = CalendarDayModel(
                date: date,
                isToday: _sameDay(date, now),
                isSelected: _sameDay(date, selectedDate),
                isPeriod: _isPeriod(cycleDay),
                isFertile: _isFertile(cycleDay),
                isOvulation: _isOvulation(cycleDay),
              );

              return Expanded(
                child: CalendarDayCell(
                  day: day,
                  heroTag: 'calendarDay-${date.year}-${date.month}-${date.day}',
                  isToday: model.isToday,
                  isPeriod: model.isPeriod,
                  isFertile: model.isFertile,
                  isOvulation: model.isOvulation,
                  isSelected: model.isSelected,
                  hasLog: false,
                  mood: null,
                  onTap: () => onSelectDate(date),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}