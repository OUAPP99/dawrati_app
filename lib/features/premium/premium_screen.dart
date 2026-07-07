import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../subscription/subscription_provider.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subscription = context.watch<SubscriptionProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 40),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
                const Spacer(),
                const Text(
                  "Premium",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const Spacer(),
                const SizedBox(width: 48),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFEAF3),
                    Color(0xFFFFF7FA),
                    Color(0xFFEDE7FF),
                  ],
                ),
                borderRadius: BorderRadius.circular(38),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.workspace_premium,
                    size: 70,
                    color: Color(0xFFE91E63),
                  ),
                  SizedBox(height: 18),
                  Text(
                    "Unlock Dawrati Premium",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "AI coach, advanced insights, unlimited history and smarter cycle predictions.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            _feature(Icons.auto_awesome, "Dawrati AI Coach",
                "Personal guidance based on your cycle and daily logs."),
            _feature(Icons.analytics_outlined, "Advanced Insights",
                "Understand mood, sleep, hydration and cycle trends."),
            _feature(Icons.history, "Unlimited History",
                "Track patterns across months, not only recent days."),
            _feature(Icons.cloud_outlined, "Cloud Backup",
                "Keep your health data safe across devices."),

            const SizedBox(height: 22),

            _pricing("Monthly", "\$4.99", false),
            const SizedBox(height: 14),
            _pricing("Annual", "\$29.99", true),

            const SizedBox(height: 26),

            SizedBox(
              height: 58,
              child: ElevatedButton(
                onPressed: () async {
                  await subscription.setPlan(SubscriptionPlan.premium);

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Premium activated")),
                  );

                  Navigator.pop(context);
                },
                child: const Text(
                  "Start Premium",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
              ),
            ),

            const SizedBox(height: 14),

            const Text(
              "Testing mode: payment is disabled.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _feature(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: const Color(0xFFFFEAF3),
            child: Icon(icon, color: const Color(0xFFE91E63)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w900)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(color: Colors.grey, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pricing(String title, String price, bool selected) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFFFEAF3) : Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: selected ? const Color(0xFFE91E63) : Colors.transparent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: selected ? const Color(0xFFE91E63) : Colors.grey,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
          ),
          Text(
            price,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}