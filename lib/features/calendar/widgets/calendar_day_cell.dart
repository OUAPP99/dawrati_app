import 'package:flutter/material.dart';

import '../../../core/theme/app_color_scheme.dart';

class CalendarDayCell extends StatelessWidget {
  final int day;
  final String heroTag;

  final bool isToday;
  final bool isSelected;

  final bool isPeriod;
  final bool isFertile;
  final bool isOvulation;

  final bool hasLog;
  final String? mood;

  final VoidCallback onTap;

  const CalendarDayCell({
    super.key,
    required this.day,
    required this.heroTag,
    required this.onTap,
    this.isToday = false,
    this.isSelected = false,
    this.isPeriod = false,
    this.isFertile = false,
    this.isOvulation = false,
    this.hasLog = false,
    this.mood,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = Colors.transparent;
    Color text = context.colors.textPrimary;

    if (isPeriod) {
      bg = const Color(0xFFFFB6CF);
      text = const Color(0xFFAD004B);
    }

    if (isFertile) {
      bg = const Color(0xFFDDF8FB);
      text = const Color(0xFF008AA3);
    }

    if (isOvulation) {
      bg = const Color(0xFFDCC6FF);
      text = const Color(0xFF6E3CC5);
    }

    if (isSelected || isToday) {
      bg = const Color(0xFFE91E63);
      text = Colors.white;
    }

    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: heroTag,
        flightShuttleBuilder: (_, animation, _, _, toContext) {
          return ScaleTransition(scale: animation, child: toContext.widget);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOut,

          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bg,

            boxShadow: (isToday || isSelected)
                ? [
                    BoxShadow(
                      color: const Color(0xFFE91E63).withValues(alpha: .30),
                      blurRadius: 22,
                      offset: const Offset(0, 8),
                    )
                  ]
                : [],
          ),

          child: Stack(
            alignment: Alignment.center,
            children: [

              Text(
                "$day",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: text,
                  fontSize: 17,
                ),
              ),

              if (hasLog)
                Positioned(
                  bottom: 7,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: text,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}