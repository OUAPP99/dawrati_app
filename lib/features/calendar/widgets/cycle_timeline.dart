import 'package:flutter/material.dart';

import '../../../core/theme/app_color_scheme.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../l10n/app_localizations.dart';

class CycleTimeline extends StatelessWidget {
  final int cycleDay;
  final int cycleLength;

  const CycleTimeline({
    super.key,
    required this.cycleDay,
    this.cycleLength = 28,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.cycleTimelineTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 30),

          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: 14,
                decoration: BoxDecoration(
                  color: colors.divider,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),

              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: 14,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE91E63),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 8,
                    child: Container(
                      height: 14,
                      color: const Color(0xFFF48FB1),
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 14,
                      color: const Color(0xFF8E5BE8),
                    ),
                  ),

                  Expanded(
                    flex: 14,
                    child: Container(
                      height: 14,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFC45A),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Positioned(
                left: ((cycleDay - 1) / cycleLength).clamp(0.0, 1.0) * 310,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: colors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE91E63),
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .15),
                        blurRadius: 12,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Legend(const Color(0xFFE91E63), t.legendPeriod),
              _Legend(const Color(0xFFF48FB1), t.legendFertile),
              _Legend(const Color(0xFF8E5BE8), t.phaseOvulation),
              _Legend(const Color(0xFFFFC45A), t.phaseLuteal),
            ],
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String text;

  const _Legend(this.color, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: context.colors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}