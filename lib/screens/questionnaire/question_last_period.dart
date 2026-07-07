import 'package:flutter/material.dart';

class QuestionLastPeriod extends StatefulWidget {
  final VoidCallback onNext;

  const QuestionLastPeriod({super.key, required this.onNext});

  @override
  State<QuestionLastPeriod> createState() => _QuestionLastPeriodState();
}

class _QuestionLastPeriodState extends State<QuestionLastPeriod> {
  DateTime? selectedDate;

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 7)),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Text(
            "When did your last period start?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 40),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Text(
                  selectedDate == null
                      ? "No date selected"
                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: pickDate,
                  child: const Text("Select date"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          ElevatedButton(
            onPressed: selectedDate != null ? widget.onNext : null,
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}