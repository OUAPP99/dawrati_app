import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/hayati_bottom_nav.dart';
import '../../l10n/app_localizations.dart';
import '../articles/articles_hub_screen.dart';
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
    final t = AppLocalizations.of(context);

    final screens = [
      HomeScreen(
        onChangerDate: () {},
        onOpenCalendar: () {
          setState(() => currentIndex = 1);
        },
        onOpenLog: () {
          setState(() => currentIndex = 2);
        },
        onOpenProfile: () {
          setState(() => currentIndex = 5);
        },
        onOpenInsights: () {
          setState(() => currentIndex = 3);
        },
        onOpenArticles: () {
          setState(() => currentIndex = 4);
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
      const ArticlesHubScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 280),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          final slide = Tween<Offset>(
            begin: const Offset(0, 0.02),
            end: Offset.zero,
          ).animate(animation);
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(position: slide, child: child),
          );
        },
        layoutBuilder: (currentChild, previousChildren) => Stack(
          children: [...previousChildren, ?currentChild],
        ),
        child: KeyedSubtree(
          key: ValueKey<int>(currentIndex),
          child: screens[currentIndex],
        ),
      ),
      bottomNavigationBar: HayatiBottomNav(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          HayatiNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            label: t.navHome,
          ),
          HayatiNavItem(
            icon: Icons.calendar_month_outlined,
            activeIcon: Icons.calendar_month_rounded,
            label: t.navCalendar,
          ),
          HayatiNavItem(
            icon: Icons.add_circle_outline,
            activeIcon: Icons.add_circle_rounded,
            label: t.navLog,
          ),
          HayatiNavItem(
            icon: Icons.insights_outlined,
            activeIcon: Icons.insights_rounded,
            label: t.navInsights,
          ),
          HayatiNavItem(
            icon: Icons.menu_book_outlined,
            activeIcon: Icons.menu_book_rounded,
            label: t.navArticles,
          ),
          HayatiNavItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person_rounded,
            label: t.navProfile,
          ),
        ],
      ),
    );
  }
}