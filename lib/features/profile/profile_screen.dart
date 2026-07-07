import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cycle/cycle_provider.dart';
import '../log/provider/daily_log_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cycle = context.watch<CycleProvider>();
    final log = context.watch<DailyLogProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 120),
          children: [
            const Text(
              "Profile",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 24),

            _profileHeader(),

            const SizedBox(height: 22),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    "Cycle",
                    "Day ${cycle.cycleDay}",
                    Icons.favorite,
                    Colors.pink,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _statCard(
                    "Phase",
                    cycle.phase,
                    Icons.spa,
                    Colors.purple,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    "Water",
                    "${log.water.toStringAsFixed(1)}L",
                    Icons.water_drop,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _statCard(
                    "Sleep",
                    "${log.sleep.toStringAsFixed(1)}h",
                    Icons.bedtime,
                    Colors.indigo,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 26),

            _premiumCard(context),

            const SizedBox(height: 26),

            _sectionTitle("Settings"),

            _item(Icons.language, "Language", "Arabic / English / French"),
            _item(Icons.notifications_none, "Notifications", "Cycle reminders"),
            _item(Icons.lock_outline, "Privacy", "Manage your data"),
            _item(Icons.favorite_border, "Cycle Settings", "28-day cycle"),
            _item(Icons.help_outline, "Help & Support", "Contact us"),
            _item(Icons.logout, "Logout", "Sign out from Dawrati"),
          ],
        ),
      ),
    );
  }

  Widget _profileHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 38,
            backgroundColor: Colors.pink.shade50,
            child: Icon(
              Icons.favorite,
              color: Colors.pink.shade500,
              size: 38,
            ),
          ),
          const SizedBox(width: 18),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "دورتي",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Dawrati Free Plan",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.edit_outlined, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 10),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _premiumCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/premium');
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1B2E),
          borderRadius: BorderRadius.circular(32),
        ),
        child: const Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFFFFC857),
              child: Icon(
                Icons.workspace_premium,
                color: Colors.white,
                size: 32,
              ),
            ),
            SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dawrati Premium",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Unlock AI coach and advanced insights.",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _item(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFE91E63)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}