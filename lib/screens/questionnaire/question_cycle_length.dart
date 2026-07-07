import 'package:flutter/material.dart';

class QuestionCycleLength extends StatefulWidget {
  final VoidCallback onNext;

  const QuestionCycleLength({super.key, required this.onNext});

  @override
  State<QuestionCycleLength> createState() => _QuestionCycleLengthState();
}

class _QuestionCycleLengthState extends State<QuestionCycleLength> {
  int? selectedCycle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Text(
            "What is your average cycle length?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "A typical cycle is between 21 and 35 days",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 40),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(15, (index) {
              final value = 21 + index;

              return ChoiceChip(
                label: Text("$value days"),
                selected: selectedCycle == value,
                onSelected: (_) {
                  setState(() {
                    selectedCycle = value;
                  });
                },
              );
            }),
          ),

          const SizedBox(height: 40),

          ElevatedButton(
            onPressed: selectedCycle != null ? widget.onNext : null,
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}