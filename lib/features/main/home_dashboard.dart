import 'package:flutter/material.dart';
import '../../core/widgets/hayati_ai_card.dart';
import '../../core/widgets/hayati_header.dart';
import '../../core/widgets/hayati_info_card.dart';
import '../../core/widgets/hayati_metric_card.dart';

class HomeDashboard extends StatelessWidget {
  final DateTime dateDebutRegles;
  final VoidCallback onChangerDate;

  const HomeDashboard({
    super.key,
    required this.dateDebutRegles,
    required this.onChangerDate,
  });

  int get jourDuCycle => DateTime.now().difference(dateDebutRegles).inDays + 1;

  int get joursAvantRegles {
    const cycleMoyen = 28;
    final restants = cycleMoyen - jourDuCycle;
    return restants < 0 ? 0 : restants;
  }

  String get phase {
    if (jourDuCycle <= 5) return "Menstruation";
    if (jourDuCycle <= 13) return "Follicular Phase";
    if (jourDuCycle <= 16) return "Ovulation";
    return "Luteal Phase";
  }

  double get cycleProgress {
    final progress = jourDuCycle / 28;
    return progress.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(22),
          children: [
            const HayatiHeader(
              title: "دورتي",
              subtitle: "Your daily cycle companion",
              icon: Icons.favorite_rounded,
            ),

            const SizedBox(height: 24),

            HayatiMetricCard(
              title: "Today",
              value: "Day $jourDuCycle",
              subtitle: phase,
              icon: Icons.favorite,
              progress: cycleProgress,
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: HayatiInfoCard(
                    icon: Icons.water_drop_outlined,
                    title: "Next Period",
                    value: "$joursAvantRegles d",
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: HayatiInfoCard(
                    icon: Icons.spa_outlined,
                    title: "Ovulation",
                    value: "Day 14",
                    color: Colors.purple,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const Row(
              children: [
                Expanded(
                  child: HayatiInfoCard(
                    icon: Icons.mood,
                    title: "Mood",
                    value: "Good",
                    color: Colors.orange,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: HayatiInfoCard(
                    icon: Icons.bedtime_outlined,
                    title: "Sleep",
                    value: "7h",
                    color: Colors.indigo,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const HayatiAiCard(
              title: "Hayati AI",
              text:
                  "Your body may need more rest and hydration today. Keep logging your symptoms to improve predictions.",
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("Add today's log"),
            ),
          ],
        ),
      ),
    );
  }
}