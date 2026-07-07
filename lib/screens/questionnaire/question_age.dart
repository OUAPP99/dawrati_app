import 'package:flutter/material.dart';

class QuestionAge extends StatefulWidget {
  final VoidCallback onNext;

  const QuestionAge({super.key, required this.onNext});

  @override
  State<QuestionAge> createState() => _QuestionAgeState();
}

class _QuestionAgeState extends State<QuestionAge> {
  int? age;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "How old are you?",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 30),

          Wrap(
            spacing: 10,
            children: List.generate(50, (index) {
              final value = index + 13;

              return ChoiceChip(
                label: Text("$value"),
                selected: age == value,
                onSelected: (_) {
                  setState(() {
                    age = value;
                  });
                },
              );
            }),
          ),

          const SizedBox(height: 40),

          ElevatedButton(
            onPressed: age != null ? widget.onNext : null,
            child: const Text("Continue"),
          )
        ],
      ),
    );
  }
}