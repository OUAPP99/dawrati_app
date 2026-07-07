import 'package:flutter/material.dart';

class QuestionHealthLifestyle extends StatefulWidget {
  final VoidCallback onNext;

  const QuestionHealthLifestyle({super.key, required this.onNext});

  @override
  State<QuestionHealthLifestyle> createState() => _QuestionHealthLifestyleState();
}

class _QuestionHealthLifestyleState extends State<QuestionHealthLifestyle> {

  String? contraception;
  String? stress;
  String? sleep;
  double? weight;

  final List<String> optionsContraception = [
    "None",
    "Pill",
    "IUD",
    "Implant",
    "Other"
  ];

  final List<String> optionsStress = [
    "Low",
    "Medium",
    "High"
  ];

  final List<String> optionsSleep = [
    "< 6h",
    "6–8h",
    "> 8h"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 30),

            const Text(
              "Your health & lifestyle",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // CONTRACEPTION
            const Text("Do you use contraception?"),
            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              children: optionsContraception.map((item) {
                return ChoiceChip(
                  label: Text(item),
                  selected: contraception == item,
                  onSelected: (_) {
                    setState(() {
                      contraception = item;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 25),

            // STRESS
            const Text("Stress level"),
            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              children: optionsStress.map((item) {
                return ChoiceChip(
                  label: Text(item),
                  selected: stress == item,
                  onSelected: (_) {
                    setState(() {
                      stress = item;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 25),

            // SLEEP
            const Text("Sleep quality"),
            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              children: optionsSleep.map((item) {
                return ChoiceChip(
                  label: Text(item),
                  selected: sleep == item,
                  onSelected: (_) {
                    setState(() {
                      sleep = item;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            // WEIGHT (simple slider)
            const Text("Weight (kg)"),
            Slider(
              value: weight ?? 60,
              min: 30,
              max: 120,
              divisions: 90,
              label: "${(weight ?? 60).round()} kg",
              onChanged: (value) {
                setState(() {
                  weight = value;
                });
              },
            ),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  widget.onNext();
                },
                child: const Text("Continue"),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}