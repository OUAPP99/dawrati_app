import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cycle/cycle_provider.dart';
import '../home/home_screen.dart';
import '../calendar/calendar_screen.dart';
import '../log/daily_log_screen.dart';
import '../insights/insights_screen.dart';
import '../profile/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final DateTime dateDebutRegles;
  final Map<String, String> textes;
  final ValueChanged<DateTime> onChangerDate;

  const MainNavigationScreen({
    super.key,
    required this.dateDebutRegles,
    required this.textes,
    required this.onChangerDate,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final cycle = context.watch<CycleProvider>();

    final screens = [
      HomeScreen(
        dateDebutRegles: cycle.periodStartDate,
        onChangerDate: () {},
        onOpenCalendar: () {
          setState(() => currentIndex = 1);
        },
        onOpenLog: () {
          setState(() => currentIndex = 2);
        },
      ),
      CalendarScreen(
        dateDebutRegles: cycle.periodStartDate,
        onSelectDate: (date) {
          cycle.updatePeriodStartDate(date);
          setState(() => currentIndex = 0);
        },
      ),
      const DailyLogScreen(),
      const InsightsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() => currentIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: "Calendar",
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: "Log",
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: "Insights",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}