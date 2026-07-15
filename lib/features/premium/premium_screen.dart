import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_color_scheme.dart';
import '../../core/widgets/animated_tap.dart';
import '../../l10n/app_localizations.dart';
import '../subscription/billing_service.dart';
import '../subscription/subscription_provider.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  bool isAnnual = true;
  late bool _wasPremium;

  @override
  void initState() {
    super.initState();
    _wasPremium = context.read<SubscriptionProvider>().isPremium;
  }

  ProductDetails? _productFor(List<ProductDetails> products, String id) {
    for (final product in products) {
      if (product.id == id) return product;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final subscription = context.watch<SubscriptionProvider>();
    final t = AppLocalizations.of(context);

    if (!_wasPremium && subscription.isPremium) {
      _wasPremium = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.premiumActivated)),
        );
        Navigator.pop(context);
      });
    }

    final monthly = _productFor(subscription.products, BillingService.monthlyProductId);
    final yearly = _productFor(subscription.products, BillingService.yearlyProductId);
    final selectedProduct = isAnnual ? yearly : monthly;
    final canPurchase = subscription.billingAvailable &&
        selectedProduct != null &&
        !subscription.purchaseInProgress;

    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 40),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
                const Spacer(),
                Text(
                  t.premiumAppBarTitle,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const Spacer(),
                const SizedBox(width: 48),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFEAF3),
                    Color(0xFFFFF7FA),
                    Color(0xFFEDE7FF),
                  ],
                ),
                borderRadius: BorderRadius.circular(38),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.workspace_premium,
                    size: 70,
                    color: Color(0xFFE91E63),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      t.premiumKicker,
                      style: const TextStyle(
                        color: Color(0xFFE91E63),
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    t.unlockPremiumTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    t.unlockPremiumDesc,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    t.premiumFomoLine,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            _feature(
              context,
              Icons.auto_awesome,
              t.aiCoachCardTitle,
              t.featureAiCoachDesc,
            ),
            _feature(
              context,
              Icons.analytics_outlined,
              t.advancedInsights,
              t.featureAdvancedInsightsDesc,
            ),
            _feature(
              context,
              Icons.history,
              t.featureUnlimitedHistoryTitle,
              t.featureUnlimitedHistoryDesc,
            ),
            _feature(
              context,
              Icons.cloud_outlined,
              t.featureCloudBackupTitle,
              t.featureCloudBackupDesc,
            ),

            const SizedBox(height: 22),

            _pricing(context, t, t.monthlyLabel, monthly?.price ?? '—', !isAnnual, () => setState(() => isAnnual = false)),
            const SizedBox(height: 14),
            _pricing(
              context,
              t,
              t.annualLabel,
              yearly?.price ?? '—',
              isAnnual,
              () => setState(() => isAnnual = true),
              badge: t.premiumBestValueBadge,
              subtitle: yearly != null
                  ? t.premiumMonthlyEquivalent('${yearly.currencySymbol}${(yearly.rawPrice / 12).toStringAsFixed(2)}')
                  : null,
              savePercent: (monthly != null && yearly != null && monthly.rawPrice > 0)
                  ? (100 - (yearly.rawPrice / (monthly.rawPrice * 12) * 100)).round()
                  : null,
            ),

            const SizedBox(height: 26),

            SizedBox(
              height: 58,
              child: ElevatedButton(
                onPressed: canPurchase
                    ? () async {
                        await subscription.purchase(selectedProduct);

                        if (!context.mounted) return;

                        if (subscription.purchaseError != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(subscription.purchaseError!)),
                          );
                        }
                      }
                    : null,
                child: subscription.purchaseInProgress
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : Text(
                        t.startPremium,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                      ),
              ),
            ),

            const SizedBox(height: 14),

            Center(
              child: Text(
                t.premiumTrustLine,
                textAlign: TextAlign.center,
                style: TextStyle(color: context.colors.textSecondary, fontSize: 12),
              ),
            ),

            const SizedBox(height: 10),

            if (!subscription.billingAvailable || subscription.products.isEmpty)
              Text(
                t.billingUnavailable,
                textAlign: TextAlign.center,
                style: TextStyle(color: context.colors.textSecondary),
              )
            else
              Center(
                child: TextButton(
                  onPressed: subscription.purchaseInProgress
                      ? null
                      : () async {
                          await subscription.restorePurchases();
                        },
                  child: Text(t.restorePurchases),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _feature(BuildContext context, IconData icon, String title, String subtitle) {
    final colors = context.colors;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: const Color(0xFFFFEAF3),
            child: Icon(icon, color: const Color(0xFFE91E63)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: colors.textSecondary,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pricing(
    BuildContext context,
    AppLocalizations t,
    String title,
    String price,
    bool selected,
    VoidCallback onTap, {
    String? badge,
    String? subtitle,
    int? savePercent,
  }) {
    final colors = context.colors;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedTap(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: selected ? const Color(0xFFFFEAF3) : colors.surface,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: selected ? const Color(0xFFE91E63) : Colors.transparent,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  selected ? Icons.radio_button_checked : Icons.radio_button_off,
                  color: selected ? const Color(0xFFE91E63) : colors.textSecondary,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          if (savePercent != null && savePercent > 0) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE91E63),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                t.premiumSavePercent(savePercent),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 3),
                        Text(
                          subtitle,
                          style: TextStyle(color: colors.textSecondary, fontSize: 12),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (badge != null)
          PositionedDirectional(
            top: -10,
            start: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1B2E),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: .5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}