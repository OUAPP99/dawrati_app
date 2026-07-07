import 'package:flutter/material.dart';

class QuestionGoal extends StatefulWidget {
  final VoidCallback onNext;

  const QuestionGoal({super.key, required this.onNext});

  @override
  State<QuestionGoal> createState() => _QuestionGoalState();
}

class _QuestionGoalState extends State<QuestionGoal> {
  String? selectedGoal;

  final List<String> goals = [
    "Track my cycle",
    "Get pregnant",
    "Avoid pregnancy",
    "Understand my health",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Text(
            "Why are you using دورتي?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 40),

          Column(
            children: goals.map((goal) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedGoal = goal;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: selectedGoal == goal
                          ? Colors.pink.shade100
                          : Colors.white,
                      border: Border.all(color: Colors.pink.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      goal,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: selectedGoal != null ? widget.onNext : null,
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}