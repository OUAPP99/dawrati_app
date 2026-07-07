import 'package:flutter/material.dart';

class AnimatedScore extends StatelessWidget {
  final int score;

  const AnimatedScore({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: score.toDouble()),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: CircularProgressIndicator(
                value: value / 100,
                strokeWidth: 10,
                backgroundColor: Colors.grey.shade200,
                color: Colors.pink,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Score",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}