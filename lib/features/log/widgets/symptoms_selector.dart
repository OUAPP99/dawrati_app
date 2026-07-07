import 'package:flutter/material.dart';

class SymptomsSelector extends StatelessWidget {
  final Set<String> selectedSymptoms;
  final ValueChanged<String> onToggle;

  const SymptomsSelector({
    super.key,
    required this.selectedSymptoms,
    required this.onToggle,
  });

  static const symptoms = [
    ("Cramps", Icons.flash_on),
    ("Bloating", Icons.bubble_chart),
    ("Headache", Icons.psychology),
    ("Back pain", Icons.accessibility_new),
    ("Acne", Icons.face_retouching_natural),
    ("Fatigue", Icons.battery_2_bar),
    ("Nausea", Icons.sick),
    ("Breast pain", Icons.favorite_border),
  ];

  @override
  Widget build(BuildContext context) {
    return _section(
      title: "Symptoms",
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: symptoms.map((item) {
          final selected = selectedSymptoms.contains(item.$1);

          return FilterChip(
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
            onSelected: (_) => onToggle(item.$1),
          );
        }).toList(),
      ),
    );
  }

  Widget _section({
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}