import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_routes.dart';
import '../partner/partner_dashboard_screen.dart';
import '../partner/partner_mode_provider.dart';
import 'app_state_provider.dart';

class AppStartup extends StatefulWidget {
  const AppStartup({super.key});

  @override
  State<AppStartup> createState() => _AppStartupState();
}

class _AppStartupState extends State<AppStartup> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigate();
    });
  }

  Future<void> _navigate() async {
    final partnerMode = context.read<PartnerModeProvider>();
    await partnerMode.load();
    if (!mounted) return;

    if (partnerMode.isPartnerMode) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PartnerDashboardScreen()),
      );
      return;
    }

    final appState = context.read<AppStateProvider>();

    if (appState.hasCompletedOnboarding) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.splash);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}