import 'package:flutter/material.dart';

class HomeActionsSection extends StatelessWidget {
  final VoidCallback? onLogPeriod;
  final VoidCallback? onSymptoms;
  final VoidCallback? onSex;

  const HomeActionsSection({
    super.key,
    this.onLogPeriod,
    this.onSymptoms,
    this.onSex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _action(
          icon: Icons.water_drop,
          label: "Log period",
          color: const Color(0xFFE91E63),
          filled: true,
          onTap: onLogPeriod,
        ),
        const SizedBox(width: 18),
        _action(
          icon: Icons.add,
          label: "Symptoms",
          color: Colors.black87,
          onTap: onSymptoms,
        ),
        const SizedBox(width: 18),
        _action(
          icon: Icons.favorite_border,
          label: "Sex",
          color: Colors.black87,
          onTap: onSex,
        ),
      ],
    );
  }

  Widget _action({
    required IconData icon,
    required String label,
    required Color color,
    bool filled = false,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 74,
              height: 74,
              decoration: BoxDecoration(
                color: filled ? color : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .07),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: filled ? Colors.white : color,
                size: 34,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}