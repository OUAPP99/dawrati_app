import 'package:flutter/material.dart';

import '../../log/models/daily_log_entry.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';

class BottomSheetDay extends StatelessWidget {
  final DateTime date;
  final int cycleDay;
  final String phase;
  final DailyLogEntry? entry;
  final VoidCallback onSetPeriodStart;

  const BottomSheetDay({
    super.key,
    required this.date,
    required this.cycleDay,
    required this.phase,
    required this.entry,
    required this.onSetPeriodStart,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .82,
      maxChildSize: .95,
      minChildSize: .55,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.hero),
            ),
          ),
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.all(26),
            children: [

              Center(
                child: Container(
                  width: 55,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              Text(
                "${date.day}/${date.month}/${date.year}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Cycle Day $cycleDay",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                phase,
                style: const TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 28),

              _InfoCard(
                icon: Icons.favorite,
                title: "Chance of pregnancy",
                value: cycleDay == 14
                    ? "Peak"
                    : cycleDay >= 11 && cycleDay <= 15
                        ? "High"
                        : "Low",
              ),

              const SizedBox(height: 18),

              _InfoCard(
                icon: Icons.psychology,
                title: "Current phase",
                value: phase,
              ),

              const SizedBox(height: 18),

              _InfoCard(
                icon: Icons.water_drop,
                title: "Cycle day",
                value: "$cycleDay",
              ),

              const SizedBox(height: 28),

              const Text(
                "Daily Log",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),

              const SizedBox(height: 18),

              if (entry == null)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7FA),
                    borderRadius:
                        BorderRadius.circular(AppRadius.card),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        size: 55,
                        color: Colors.pink.shade400,
                      ),

                      const SizedBox(height: 18),

                      const Text(
                        "No log for this day",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Track symptoms, mood, sleep, water and more.",
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Add Daily Log"),
                        ),
                      ),

                      const SizedBox(height: 10),

                      OutlinedButton(
                        onPressed: onSetPeriodStart,
                        child: const Text(
                          "Set as period start",
                        ),
                      ),
                    ],
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7FA),
                    borderRadius:
                        BorderRadius.circular(AppRadius.card),
                    boxShadow: AppShadows.soft,
                  ),
                  child: Column(
                    children: [

                            _Row("Mood", entry!.mood),
                            _Row("Sleep", "${entry!.sleep.toStringAsFixed(1)} h"),
                            _Row("Water", "${entry!.water.toStringAsFixed(1)} L"),
                            _Row("Notes", "-"),

                    ],
                  ),
                ),

              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7FA),
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [

          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
            child: Icon(icon, color: Colors.pink),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String title;
  final String value;

  const _Row(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [

          Text(title),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),
    );
  }
}