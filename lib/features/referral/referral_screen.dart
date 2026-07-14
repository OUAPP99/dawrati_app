import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/services/cloud_sync_service.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadows.dart';
import '../../l10n/app_localizations.dart';
import '../subscription/subscription_provider.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  static const int rewardDays = 7;

  bool loading = true;
  bool signedIn = true;
  String? myCode;
  bool hasRedeemed = false;
  bool redeeming = false;
  String? message;
  bool messageIsError = false;

  final codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    if (!CloudSyncService.instance.isSignedIn) {
      setState(() {
        signedIn = false;
        loading = false;
      });
      return;
    }

    final code = await CloudSyncService.instance.getOrCreateReferralCode();
    final profile = await CloudSyncService.instance.pullProfile();
    if (!mounted) return;

    setState(() {
      myCode = code;
      hasRedeemed = profile?['hasRedeemedReferral'] == true;
      loading = false;
    });
  }

  Future<void> _redeem() async {
    final t = AppLocalizations.of(context);
    final code = codeController.text.trim().toUpperCase();
    if (code.isEmpty) return;

    if (myCode != null && code == myCode) {
      setState(() {
        message = t.referralCannotUseOwnCode;
        messageIsError = true;
      });
      return;
    }

    setState(() {
      redeeming = true;
      message = null;
    });

    final referrerUid = await CloudSyncService.instance.resolveReferrerUid(code);
    if (referrerUid == null) {
      if (!mounted) return;
      setState(() {
        redeeming = false;
        message = t.referralInvalidCode;
        messageIsError = true;
      });
      return;
    }

    await CloudSyncService.instance.createReferralCredit(referrerUid, rewardDays);
    await CloudSyncService.instance.markReferralRedeemed();

    if (!mounted) return;
    await context.read<SubscriptionProvider>().grantBonusPremiumDays(rewardDays);

    if (!mounted) return;
    setState(() {
      redeeming = false;
      hasRedeemed = true;
      message = t.referralRedeemSuccess(rewardDays);
      messageIsError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      body: SafeArea(
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.fromLTRB(22, 18, 22, 40),
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 4),
                      Text(t.referralTitle, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                    ],
                  ),
                  const SizedBox(height: 18),
                  if (!signedIn)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        boxShadow: AppShadows.soft,
                      ),
                      child: Text(
                        t.referralSignInRequired,
                        style: TextStyle(color: Colors.grey.shade700, height: 1.5),
                      ),
                    )
                  else ...[
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFFEDE7FF), Color(0xFFFFEAF3)]),
                        borderRadius: BorderRadius.circular(AppRadius.card),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t.referralInviteTitle, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                          const SizedBox(height: 8),
                          Text(
                            t.referralInviteDesc(rewardDays),
                            style: TextStyle(color: Colors.grey.shade800, height: 1.4),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                myCode ?? '—',
                                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 4),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton.icon(
                              onPressed: myCode == null
                                  ? null
                                  : () => Share.share(t.referralShareMessage(myCode!, rewardDays)),
                              icon: const Icon(Icons.ios_share),
                              label: Text(t.referralShareButton),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),
                    if (!hasRedeemed) ...[
                      Text(t.referralRedeemTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 12),
                      TextField(
                        controller: codeController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                          hintText: t.referralCodeHint,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: redeeming ? null : _redeem,
                          child: redeeming
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                )
                              : Text(t.referralRedeemButton),
                        ),
                      ),
                    ] else
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppRadius.card),
                          boxShadow: AppShadows.soft,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green),
                            const SizedBox(width: 10),
                            Expanded(child: Text(t.referralAlreadyRedeemed)),
                          ],
                        ),
                      ),
                    if (message != null) ...[
                      const SizedBox(height: 14),
                      Text(
                        message!,
                        style: TextStyle(color: messageIsError ? Colors.red : Colors.green.shade700),
                      ),
                    ],
                  ],
                ],
              ),
      ),
    );
  }
}
