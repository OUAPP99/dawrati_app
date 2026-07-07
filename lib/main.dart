import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/app_routes.dart';
import 'core/theme/app_theme.dart';

import 'features/app_state/app_startup.dart';
import 'features/app_state/app_state_provider.dart';

import 'features/cycle/cycle_provider.dart';
import 'features/log/provider/daily_log_provider.dart';
import 'features/subscription/subscription_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppStateProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => CycleProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => DailyLogProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => SubscriptionProvider(),
        ),
      ],
      child: const CycleApp(),
    ),
  );
}

class CycleApp extends StatelessWidget {
  const CycleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final cycleProvider = context.watch<CycleProvider>();

    return MaterialApp(
      title: 'دورتي',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AppStartup(),
      routes: AppRoutes.routes(
        dateDebutRegles: cycleProvider.periodStartDate,
        textes: const {
          'titre': 'دورتي',
          'jour': 'اليوم',
          'deTonCycle': 'من دورتك',
          'choisirDate': 'اختاري تاريخ الدورة',
        },
        onChangerDate: cycleProvider.updatePeriodStartDate,
      ),
    );
  }
}