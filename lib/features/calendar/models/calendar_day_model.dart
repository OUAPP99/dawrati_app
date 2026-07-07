class CalendarDayModel {
  final DateTime date;

  final bool isToday;
  final bool isSelected;

  final bool isPeriod;
  final bool isFertile;
  final bool isOvulation;

  const CalendarDayModel({
    required this.date,
    this.isToday = false,
    this.isSelected = false,
    this.isPeriod = false,
    this.isFertile = false,
    this.isOvulation = false,
  });
}