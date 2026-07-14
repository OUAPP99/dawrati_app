import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../subscription/subscription_provider.dart';

class FloHeaderSection extends StatelessWidget {
  final VoidCallback? onProfileTap;
  final VoidCallback? onCalendarTap;

  const FloHeaderSection({
    super.key,
    this.onProfileTap,
    this.onCalendarTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPremium = context.watch<SubscriptionProvider>().isPremium;

    return Row(
      children: [
        _circleButton(Icons.person_outline, onProfileTap, isPremium: isPremium),
        const Spacer(),
        Image.asset(
          "assets/images/logo_header.png",
          height: 48,
          fit: BoxFit.contain,
        ),
        const Spacer(),
        _circleButton(Icons.calendar_month_outlined, onCalendarTap),
      ],
    );
  }

  Widget _circleButton(IconData icon, VoidCallback? onTap, {bool isPremium = false}) {
    final button = Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: isPremium ? Border.all(color: const Color(0xFFFFC857), width: 2.5) : null,
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

    return GestureDetector(
      onTap: onTap,
      child: isPremium
          ? Stack(
              clipBehavior: Clip.none,
              children: [
                button,
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFC857),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.workspace_premium, size: 14, color: Colors.white),
                  ),
                ),
              ],
            )
          : button,
    );
  }
}
