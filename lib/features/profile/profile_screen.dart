import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/animated_tap.dart';
import '../../core/widgets/fade_slide.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/label_translations.dart';
import '../app_state/app_state_provider.dart';
import '../cycle/cycle_provider.dart';
import '../log/provider/daily_log_provider.dart';
import '../partner/partner_code_screen.dart';
import '../security/app_lock_provider.dart';
import '../subscription/subscription_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cycle = context.watch<CycleProvider>();
    final log = context.watch<DailyLogProvider>();
    final isPremium = context.watch<SubscriptionProvider>().isPremium;
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 120),
          children: [
            Text(t.profileTitle, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900)),
            const SizedBox(height: 24),
            FadeSlide(delay: 0, child: _profileHeader(context, t, isPremium)),
            const SizedBox(height: 22),
            FadeSlide(
              delay: 80,
              child: Row(
                children: [
                  Expanded(
                    child: _statCard(
                      t.cycleLabel,
                      t.dayLabel(cycle.cycleDay),
                      Icons.favorite,
                      Colors.pink,
                      onTap: () => Navigator.pushNamed(context, '/cycle-settings'),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _statCard(
                      t.phaseLabel,
                      translatePhase(t, cycle.phase),
                      Icons.spa,
                      Colors.purple,
                      onTap: () => Navigator.pushNamed(context, '/cycle-settings'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            FadeSlide(
              delay: 140,
              child: Row(
                children: [
                  Expanded(child: _statCard(t.waterLabel, "${log.water.toStringAsFixed(1)}L", Icons.water_drop, Colors.blue)),
                  const SizedBox(width: 14),
                  Expanded(child: _statCard(t.sleepLabel, "${log.sleep.toStringAsFixed(1)}h", Icons.bedtime, Colors.indigo)),
                ],
              ),
            ),
            const SizedBox(height: 26),
            FadeSlide(
              delay: 220,
              child: isPremium ? _premiumActiveCard(t) : _premiumCard(context, t),
            ),
            const SizedBox(height: 26),
            FadeSlide(
              delay: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle(t.settingsTitle),
                  _item(
                    Icons.language,
                    t.settingsLanguage,
                    _languageLabel(context.watch<AppStateProvider>().languageCode),
                    onTap: () => Navigator.pushNamed(context, '/language'),
                  ),
                  _item(
                    Icons.notifications_none,
                    t.settingsNotifications,
                    t.settingsNotificationsDesc,
                    onTap: () => Navigator.pushNamed(context, '/notification-settings'),
                  ),
                  _item(
                    Icons.lock_outline,
                    t.settingsPrivacy,
                    t.settingsPrivacyDesc,
                    onTap: () => Navigator.pushNamed(context, '/privacy'),
                  ),
                  _item(
                    Icons.pin_outlined,
                    t.settingsAppLock,
                    context.watch<AppLockProvider>().isLockEnabled
                        ? t.settingsAppLockDescOn
                        : t.settingsAppLockDescOff,
                    onTap: () => Navigator.pushNamed(context, '/app-lock-settings'),
                  ),
                  _item(
                    Icons.favorite_border,
                    t.settingsCycle,
                    t.settingsCycleDesc,
                    onTap: () => Navigator.pushNamed(context, '/cycle-settings'),
                  ),
                  _item(
                    Icons.people_outline,
                    t.settingsPartner,
                    t.settingsPartnerDesc,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PartnerCodeScreen()),
                    ),
                  ),
                  _item(
                    Icons.card_giftcard_outlined,
                    t.settingsReferral,
                    t.settingsReferralDesc,
                    onTap: () => Navigator.pushNamed(context, '/referral'),
                  ),
                  if (!kIsWeb && Platform.isAndroid)
                    _item(
                      Icons.widgets_outlined,
                      t.settingsWidget,
                      t.settingsWidgetDesc,
                      onTap: () => _addHomeWidget(context, t),
                    ),
                  _item(
                    Icons.help_outline,
                    t.settingsHelp,
                    t.settingsHelpDesc,
                    onTap: () => Navigator.pushNamed(context, '/help-support'),
                  ),
                  _item(
                    Icons.logout,
                    t.settingsLogout,
                    t.settingsLogoutDesc,
                    onTap: () => _confirmLogout(context, t),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addHomeWidget(BuildContext context, AppLocalizations t) async {
    final supported = await HomeWidget.isRequestPinWidgetSupported() ?? false;
    if (supported) {
      await HomeWidget.requestPinWidget(androidName: 'CycleWidgetProvider');
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.widgetPinUnsupported)),
      );
    }
  }

  Future<void> _confirmLogout(BuildContext context, AppLocalizations t) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(t.logoutConfirmTitle),
        content: Text(t.logoutConfirmDesc),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(t.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(t.confirm, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    await context.read<AppStateProvider>().resetOnboarding();

    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  Widget _profileHeader(BuildContext context, AppLocalizations t, bool isPremium) {
    return AnimatedTap(
      onTap: () => Navigator.pushNamed(context, '/cycle-settings'),
      child: Container(
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
              child: Icon(Icons.favorite, color: Colors.pink.shade500, size: 38),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.appName, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 4),
                  if (isPremium)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.workspace_premium, size: 16, color: Color(0xFFC9971E)),
                        const SizedBox(width: 4),
                        Text(
                          t.premiumPlanLabel,
                          style: const TextStyle(color: Color(0xFFC9971E), fontWeight: FontWeight.w700),
                        ),
                      ],
                    )
                  else
                    Text(t.freePlan, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const Icon(Icons.edit_outlined, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color, {VoidCallback? onTap}) {
    final content = Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 10),
          Text(value, textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w700)),
        ],
      ),
    );

    if (onTap == null) return content;

    return AnimatedTap(onTap: onTap, child: content);
  }

  Widget _premiumCard(BuildContext context, AppLocalizations t) {
    return AnimatedTap(
      onTap: () {
        Navigator.pushNamed(context, '/premium');
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1B2E),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFFFFC857),
              child: Icon(Icons.workspace_premium, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.premiumTitle, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 6),
                  Text(t.premiumSubtitle, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _premiumActiveCard(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1F1B2E), Color(0xFF3A2E4A)],
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xFFFFC857),
            child: Icon(Icons.workspace_premium, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.premiumActiveTitle, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                const SizedBox(height: 6),
                Text(t.premiumActiveDesc, style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const Icon(Icons.check_circle, color: Color(0xFFFFC857)),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Text(text, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
    );
  }

  String _languageLabel(String code) {
    switch (code) {
      case 'fr':
        return 'Français';
      case 'en':
        return 'English';
      default:
        return 'العربية';
    }
  }

  Widget _item(IconData icon, String title, String subtitle, {VoidCallback? onTap}) {
    return AnimatedTap(
      onTap: onTap ?? () {},
      child: Container(
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
                  Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}