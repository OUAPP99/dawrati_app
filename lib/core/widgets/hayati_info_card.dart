import 'package:flutter/material.dart';

class HayatiInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const HayatiInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.color = Colors.pink,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 10),
          Text(title, textAlign: TextAlign.center),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}