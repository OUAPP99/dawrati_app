import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  final VoidCallback? onAddLog;

  const QuickActions({
    super.key,
    this.onAddLog,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton.icon(
        onPressed: onAddLog,
        icon: const Icon(Icons.add),
        label: const Text(
          "Add today's log",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}