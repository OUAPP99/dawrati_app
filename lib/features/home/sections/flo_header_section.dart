import 'package:flutter/material.dart';

class FloHeaderSection extends StatelessWidget {
  const FloHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _circleButton(Icons.person_outline),
        const Spacer(),
        Image.asset(
          "assets/images/logo_header.png",
          height: 48,
          fit: BoxFit.contain,
        ),
        const Spacer(),
        _circleButton(Icons.calendar_month_outlined),
      ],
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: const Color(0xFF5A4B56),
        size: 28,
      ),
    );
  }
}