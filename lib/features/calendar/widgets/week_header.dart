import 'package:flutter/material.dart';

class WeekHeader extends StatelessWidget {
  const WeekHeader({super.key});

  @override
  Widget build(BuildContext context) {
    const days = ["S","M","T","W","T","F","S"];

    return Row(
      children: days.map((day){
        return Expanded(
          child: Center(
            child: Text(
              day,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}