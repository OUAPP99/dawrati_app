import 'package:flutter/material.dart';

class SleepCard extends StatelessWidget {
  final double sleep;
  final ValueChanged<double> onChanged;

  const SleepCard({
    super.key,
    required this.sleep,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _card(
      title: "Sleep",
      child: Column(
        children: [
          Text(
            "${sleep.toStringAsFixed(1)} h",
            style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w900),
          ),
          Slider(
            value: sleep,
            min: 0,
            max: 12,
            divisions: 24,
            label: "${sleep.toStringAsFixed(1)} h",
            onChanged: onChanged,
          ),
        ],
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