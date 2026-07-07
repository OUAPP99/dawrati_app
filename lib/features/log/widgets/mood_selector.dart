import 'package:flutter/material.dart';

class MoodSelector extends StatelessWidget {
  final String? selectedMood;
  final ValueChanged<String> onChanged;

  const MoodSelector({
    super.key,
    required this.selectedMood,
    required this.onChanged,
  });

  static const moods = [
    ("😍", "Amazing"),
    ("😊", "Good"),
    ("😐", "Okay"),
    ("😔", "Sad"),
    ("😭", "Awful"),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "How do you feel today?",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),

        const SizedBox(height: 18),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: moods.map((mood) {
            final selected = selectedMood == mood.$2;

            return GestureDetector(
              onTap: () => onChanged(mood.$2),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: 62,
                height: 82,
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFFFFEAF3)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: selected
                        ? const Color(0xFFE91E63)
                        : Colors.grey.shade200,
                    width: 2,
                  ),
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: const Color(0xFFE91E63)
                                .withValues(alpha: .18),
                            blurRadius: 18,
                          )
                        ]
                      : [],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      mood.$1,
                      style: const TextStyle(fontSize: 28),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      mood.$2,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: selected
                            ? const Color(0xFFE91E63)
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}