import 'package:flutter/material.dart';

class QuestionPeriodLength extends StatefulWidget {
  final VoidCallback onNext;

  const QuestionPeriodLength({super.key, required this.onNext});

  @override
  State<QuestionPeriodLength> createState() => _QuestionPeriodLengthState();
}

class _QuestionPeriodLengthState extends State<QuestionPeriodLength> {
  int? selectedDays;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Text(
            "How long do your periods last?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 40),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(8, (index) {
              final value = index + 1;

              return ChoiceChip(
                label: Text("$value day${value > 1 ? "s" : ""}"),
                selected: selectedDays == value,
                onSelected: (_) {
                  setState(() {
                    selectedDays = value;
                  });
                },
              );
            }),
          ),

          const SizedBox(height: 40),

          ElevatedButton(
            onPressed: selectedDays != null ? widget.onNext : null,
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}