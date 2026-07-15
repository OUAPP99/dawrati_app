import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/services/cloud_sync_service.dart';
import '../../core/theme/app_color_scheme.dart';
import '../../l10n/app_localizations.dart';

class PartnerCodeScreen extends StatefulWidget {
  const PartnerCodeScreen({super.key});

  @override
  State<PartnerCodeScreen> createState() => _PartnerCodeScreenState();
}

class _PartnerCodeScreenState extends State<PartnerCodeScreen> {
  bool loading = true;
  String? code;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final result = await CloudSyncService.instance.getOrCreatePartnerCode();
    if (!mounted) return;
    setState(() {
      code = result;
      loading = false;
    });
  }

  void _share(AppLocalizations t) {
    if (code == null) return;
    Share.share(t.partnerShareMessage(code!));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 10),
              Text(t.partnerCodeScreenTitle, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
              const SizedBox(height: 10),
              Text(
                t.partnerCodeScreenSubtitle,
                style: TextStyle(color: colors.textSecondary, height: 1.4),
              ),
              const SizedBox(height: 30),
              if (loading)
                const Center(child: Padding(padding: EdgeInsets.all(40), child: CircularProgressIndicator()))
              else if (code == null)
                Text(t.partnerCodeUnavailable, style: const TextStyle(color: Colors.red))
              else ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: .05), blurRadius: 24, offset: const Offset(0, 10)),
                    ],
                  ),
                  child: Text(
                    code!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900, letterSpacing: 8),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () => _share(t),
                    icon: const Icon(Icons.ios_share),
                    label: Text(t.partnerShareCode, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
