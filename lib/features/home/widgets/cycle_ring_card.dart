import 'package:flutter/material.dart';
import 'dart:math';

class CycleRingCard extends StatelessWidget {
  final int cycleDay;
  final String phase;
  final double progress;
  final VoidCallback onTap;

  const CycleRingCard({
    super.key,
    required this.cycleDay,
    required this.phase,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 190,
              height: 190,
              child: CustomPaint(
                painter: _RingPainter(progress),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Day"),
                      Text(
                        "$cycleDay",
                        style: const TextStyle(
                          fontSize: 54,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE91E63),
                        ),
                      ),
                      Text(phase),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              "Tap to change period date",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;

  _RingPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 14.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = const Color(0xFFFFC1D6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = const Color(0xFFE91E63)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}