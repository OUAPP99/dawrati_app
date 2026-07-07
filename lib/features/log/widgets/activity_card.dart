import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String? selectedActivity;
  final ValueChanged<String> onChanged;

  const ActivityCard({
    super.key,
    required this.selectedActivity,
    required this.onChanged,
  });

  static const activities = [
    ("None", Icons.block),
    ("Walk", Icons.directions_walk),
    ("Run", Icons.directions_run),
    ("Gym", Icons.fitness_center),
    ("Yoga", Icons.self_improvement),
  ];

  @override
  Widget build(BuildContext context) {
    return _card(
      title: "Activity",
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: activities.map((item) {
          final selected = selectedActivity == item.$1;

          return ChoiceChip(
            selected: selected,
            label: Text(item.$1),
            avatar: Icon(
              item.$2,
              size: 18,
              color: selected ? Colors.white : const Color(0xFFE91E63),
            ),
            selectedColor: const Color(0xFFE91E63),
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w700,
            ),
            side: BorderSide(
              color: selected ? const Color(0xFFE91E63) : Colors.grey.shade200,
            ),
            onSelected: (_) => onChanged(item.$1),
          );
        }).toList(),
      ),
    );
  }

  Widget _card({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(22),
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        const SizedBox(height: 18),
        child,
      ]),
    );
  }
}