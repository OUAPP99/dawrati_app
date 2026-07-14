import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';

/// Wraps the platform in-app purchase APIs (Google Play Billing / StoreKit)
/// behind a small surface the rest of the app can use without knowing
/// about `in_app_purchase` internals.
class BillingService {
  BillingService._();
  static final BillingService instance = BillingService._();

  static const String monthlyProductId = 'dawrati_premium_monthly';
  static const String yearlyProductId = 'dawrati_premium_yearly';
  static const Set<String> productIds = {monthlyProductId, yearlyProductId};

  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  /// Called whenever a purchase completes successfully (new purchase or
  /// restored one), with the product id that was bought.
  void Function(String productId)? onPurchaseSuccess;
  void Function(String message)? onPurchaseError;
  void Function()? onPurchaseCanceled;

  bool _initialized = false;

  Future<bool> initialize() async {
    if (_initialized) return true;

    final available = await _iap.isAvailable();
    if (!available) return false;

    _subscription = _iap.purchaseStream.listen(
      _handlePurchaseUpdates,
      onError: (Object error) => onPurchaseError?.call(error.toString()),
    );

    _initialized = true;
    return true;
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _initialized = false;
  }

  Future<List<ProductDetails>> queryProducts() async {
    final response = await _iap.queryProductDetails(productIds);
    if (response.error != null) {
      onPurchaseError?.call(response.error!.message);
      return [];
    }
    return response.productDetails;
  }

  Future<void> buy(ProductDetails product) async {
    final purchaseParam = PurchaseParam(productDetails: product);
    await _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> restorePurchases() async {
    await _iap.restorePurchases();
  }

  void _handlePurchaseUpdates(List<PurchaseDetails> purchases) {
    for (final purchase in purchases) {
      switch (purchase.status) {
        case PurchaseStatus.pending:
          break;
        case PurchaseStatus.error:
          onPurchaseError?.call(purchase.error?.message ?? 'Purchase failed.');
          if (purchase.pendingCompletePurchase) {
            _iap.completePurchase(purchase);
          }
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          onPurchaseSuccess?.call(purchase.productID);
          if (purchase.pendingCompletePurchase) {
            _iap.completePurchase(purchase);
          }
          break;
        case PurchaseStatus.canceled:
          onPurchaseCanceled?.call();
          if (purchase.pendingCompletePurchase) {
            _iap.completePurchase(purchase);
          }
          break;
      }
    }
  }
}
