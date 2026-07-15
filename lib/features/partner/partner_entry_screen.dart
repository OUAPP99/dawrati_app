import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/cloud_sync_service.dart';
import '../../core/theme/app_color_scheme.dart';
import '../../l10n/app_localizations.dart';
import '../auth/auth_provider.dart';
import 'partner_dashboard_screen.dart';
import 'partner_mode_provider.dart';

class PartnerEntryScreen extends StatefulWidget {
  const PartnerEntryScreen({super.key});

  @override
  State<PartnerEntryScreen> createState() => _PartnerEntryScreenState();
}

class _PartnerEntryScreenState extends State<PartnerEntryScreen> {
  final TextEditingController controller = TextEditingController();
  bool loading = false;
  String? error;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _connect() async {
    final t = AppLocalizations.of(context);
    final code = controller.text.trim().toUpperCase();
    if (code.isEmpty) return;

    setState(() {
      loading = true;
      error = null;
    });

    await context.read<AuthProvider>().ensureAnonymousSignIn();
    final ownerUid = await CloudSyncService.instance.resolveOwnerUid(code);

    if (!mounted) return;

    if (ownerUid == null) {
      setState(() {
        loading = false;
        error = t.partnerCodeInvalid;
      });
      return;
    }

    await context.read<PartnerModeProvider>().connect(code, ownerUid);

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const PartnerDashboardScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 20, 28, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 12),
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFEAF3), Color(0xFFEDE7FF)],
                    ),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: const Icon(Icons.favorite_border, color: Color(0xFFE91E63), size: 48),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                t.partnerEntryTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 10),
              Text(
                t.partnerEntrySubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: colors.textSecondary, height: 1.4),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: controller,
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.characters,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 4),
                decoration: InputDecoration(
                  hintText: t.partnerCodeHint,
                  filled: true,
                  fillColor: colors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                ),
              ),
              if (error != null) ...[
                const SizedBox(height: 12),
                Text(error!, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
              ],
              const SizedBox(height: 24),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: loading ? null : _connect,
                  child: loading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(t.partnerConnectButton, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
