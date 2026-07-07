import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HayatiScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottom;

  const HayatiScaffold({
    super.key,
    required this.body,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: body),
            if (bottom != null)
              Padding(
                padding: const EdgeInsets.all(20),
                child: bottom!,
              ),
          ],
        ),
      ),
    );
  }
}