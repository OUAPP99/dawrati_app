import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/widgets/animated_tap.dart';
import '../../l10n/app_localizations.dart';
import 'app_lock_provider.dart';
import 'pin_setup_screen.dart';

class AppLockSettingsScreen extends StatefulWidget {
  const AppLockSettingsScreen({super.key});

  @override
  State<AppLockSettingsScreen> createState() => _AppLockSettingsScreenState();
}

class _AppLockSettingsScreenState extends State<AppLockSettingsScreen> {
  bool biometricsAvailable = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final available = await context.read<AppLockProvider>().canUseBiometrics();
      if (mounted) setState(() => biometricsAvailable = available);
    });
  }

  Future<void> _setupPin() async {
    final success = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const PinSetupScreen()),
    );
    if (success == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).appLockEnable)),
      );
    }
  }

  Future<void> _disableLock(AppLocalizations t) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(t.appLockDisableConfirmTitle),
        content: Text(t.appLockDisableConfirmDesc),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: Text(t.cancel)),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(t.confirm, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await context.read<AppLockProvider>().disableLock();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final appLock = context.watch<AppLockProvider>();

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
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 4),
                Text(t.settingsAppLock, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
              ],
            ),
            const SizedBox(height: 22),

            if (!appLock.isLockEnabled)
              AnimatedTap(
                onTap: _setupPin,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    boxShadow: AppShadows.soft,
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(0xFFFFEAF3),
                        child: Icon(Icons.lock_outline, color: Color(0xFFE91E63)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t.appLockEnable, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                            const SizedBox(height: 2),
                            Text(t.appLockEnableDesc, style: TextStyle(color: Colors.grey.shade700)),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              )
            else ...[
              _item(
                icon: Icons.password,
                title: t.appLockChangePin,
                onTap: _setupPin,
              ),
              const SizedBox(height: 14),
              if (biometricsAvailable)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    boxShadow: AppShadows.soft,
                  ),
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(t.appLockUseBiometrics, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    subtitle: Text(t.appLockUseBiometricsDesc, style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
                    value: appLock.useBiometrics,
                    onChanged: (value) => context.read<AppLockProvider>().setUseBiometrics(value),
                  ),
                )
              else
                Text(t.appLockBiometricsUnavailable, style: TextStyle(color: Colors.grey.shade600)),
              const SizedBox(height: 22),
              _item(
                icon: Icons.lock_open,
                title: t.appLockDisable,
                titleColor: Colors.red,
                onTap: () => _disableLock(t),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _item({required IconData icon, required String title, VoidCallback? onTap, Color? titleColor}) {
    return AnimatedTap(
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: AppShadows.soft,
        ),
        child: Row(
          children: [
            Icon(icon, color: titleColor ?? const Color(0xFFE91E63)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: titleColor)),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
