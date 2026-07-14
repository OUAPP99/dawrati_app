import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../features/log/models/daily_log_entry.dart';

const _partnerCodeChars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

/// Syncs a signed-in user's data to Firestore. All methods are no-ops when
/// signed out (guest mode) — the app already works fully offline/local-only
/// via SharedPreferences, this is a best-effort cloud backup layered on top.
class CloudSyncService {
  CloudSyncService._();
  static final CloudSyncService instance = CloudSyncService._();

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  DocumentReference<Map<String, dynamic>>? get _userDoc {
    final uid = _uid;
    if (uid == null) return null;
    return FirebaseFirestore.instance.collection('users').doc(uid);
  }

  bool get isSignedIn => _uid != null;

  Future<void> _safeWrite(Future<void> Function() write) async {
    try {
      await write();
    } catch (e) {
      debugPrint('CloudSyncService write failed: $e');
    }
  }

  Future<void> pushPeriodStartDate(DateTime date) {
    final doc = _userDoc;
    if (doc == null) return Future.value();
    return _safeWrite(
      () => doc.set({'periodStartDate': date.toIso8601String()}, SetOptions(merge: true)),
    );
  }

  /// Pushes the user's full logged period-start history, used to compute a
  /// real personalized average cycle length instead of assuming 28 days.
  Future<void> pushPeriodHistory(List<DateTime> history) {
    final doc = _userDoc;
    if (doc == null) return Future.value();
    return _safeWrite(
      () => doc.set(
        {'periodHistory': history.map((d) => d.toIso8601String()).toList()},
        SetOptions(merge: true),
      ),
    );
  }

  Future<void> pushEstimatedCycleLength(int days) {
    final doc = _userDoc;
    if (doc == null) return Future.value();
    return _safeWrite(
      () => doc.set({'estimatedCycleLength': days}, SetOptions(merge: true)),
    );
  }

  Future<void> pushPeriodLength(int days) {
    final doc = _userDoc;
    if (doc == null) return Future.value();
    return _safeWrite(
      () => doc.set({'periodLength': days}, SetOptions(merge: true)),
    );
  }

  /// Pushes whichever onboarding profile answers are non-null, merged into
  /// the user doc in a single write.
  Future<void> pushProfileAnswers({
    String? goal,
    String? contraception,
    String? stress,
    String? sleepQuality,
  }) {
    final doc = _userDoc;
    if (doc == null) return Future.value();

    final data = <String, dynamic>{};
    if (goal != null) data['userGoal'] = goal;
    if (contraception != null) data['contraceptionMethod'] = contraception;
    if (stress != null) data['stressLevel'] = stress;
    if (sleepQuality != null) data['sleepQuality'] = sleepQuality;
    if (data.isEmpty) return Future.value();

    return _safeWrite(() => doc.set(data, SetOptions(merge: true)));
  }

  Future<void> pushWeightKg(double kg) {
    final doc = _userDoc;
    if (doc == null) return Future.value();
    return _safeWrite(
      () => doc.set({'weightKg': kg}, SetOptions(merge: true)),
    );
  }

  Future<void> pushAge(int years) {
    final doc = _userDoc;
    if (doc == null) return Future.value();
    return _safeWrite(
      () => doc.set({'age': years}, SetOptions(merge: true)),
    );
  }

  Future<void> pushLanguageCode(String code) {
    final doc = _userDoc;
    if (doc == null) return Future.value();
    return _safeWrite(
      () => doc.set({'languageCode': code}, SetOptions(merge: true)),
    );
  }

  Future<void> pushSubscriptionPlan(String planName) {
    final doc = _userDoc;
    if (doc == null) return Future.value();
    return _safeWrite(
      () => doc.set({'subscriptionPlan': planName}, SetOptions(merge: true)),
    );
  }

  Future<void> pushDailyLog(DailyLogEntry entry) {
    final doc = _userDoc;
    if (doc == null) return Future.value();
    return _safeWrite(
      () => doc.collection('dailyLogs').doc(_dateKey(entry.date)).set(entry.toJson()),
    );
  }

  /// Returns null if signed out or the user has no cloud profile yet
  /// (brand-new account with nothing pushed).
  Future<Map<String, dynamic>?> pullProfile() async {
    final doc = _userDoc;
    if (doc == null) return null;

    try {
      final snap = await doc.get();
      return snap.data();
    } catch (e) {
      debugPrint('CloudSyncService pullProfile failed: $e');
      return null;
    }
  }

  Future<List<DailyLogEntry>> pullDailyLogs() async {
    final doc = _userDoc;
    if (doc == null) return [];

    try {
      final snap = await doc.collection('dailyLogs').get();
      return snap.docs.map((d) => DailyLogEntry.fromJson(d.data())).toList();
    } catch (e) {
      debugPrint('CloudSyncService pullDailyLogs failed: $e');
      return [];
    }
  }

  Future<void> pushAllDailyLogs(List<DailyLogEntry> logs) {
    final doc = _userDoc;
    if (doc == null) return Future.value();

    return _safeWrite(() async {
      final batch = FirebaseFirestore.instance.batch();
      for (final entry in logs) {
        batch.set(doc.collection('dailyLogs').doc(_dateKey(entry.date)), entry.toJson());
      }
      await batch.commit();
    });
  }

  String _dateKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  String _generatePartnerCode() {
    final rand = Random.secure();
    return List.generate(8, (_) => _partnerCodeChars[rand.nextInt(_partnerCodeChars.length)]).join();
  }

  /// Returns the signed-in user's partner code, generating and persisting
  /// one on first call. Returns null when signed out.
  Future<String?> getOrCreatePartnerCode() async {
    final doc = _userDoc;
    final uid = _uid;
    if (doc == null || uid == null) return null;

    try {
      final snap = await doc.get();
      final existing = snap.data()?['partnerCode'] as String?;
      if (existing != null && existing.isNotEmpty) return existing;

      final code = _generatePartnerCode();
      await FirebaseFirestore.instance.collection('partnerLinks').doc(code).set({'ownerUid': uid});
      await doc.set({'partnerCode': code}, SetOptions(merge: true));
      return code;
    } catch (e) {
      debugPrint('CloudSyncService getOrCreatePartnerCode failed: $e');
      return null;
    }
  }

  /// Publishes a curated, partner-safe snapshot of the signed-in user's
  /// cycle status. Never includes raw daily-log history, notes or account
  /// details — only what a linked partner is allowed to see.
  Future<void> pushPartnerView(Map<String, dynamic> data) {
    final doc = _userDoc;
    if (doc == null) return Future.value();
    return _safeWrite(
      () => doc.collection('partnerView').doc('summary').set(data, SetOptions(merge: true)),
    );
  }

  /// Looks up a partner code and returns the owning user's uid, or null if
  /// the code doesn't exist. The caller must already be authenticated
  /// (anonymous auth is enough) for this to succeed under the Firestore
  /// rules.
  Future<String?> resolveOwnerUid(String code) async {
    try {
      final linkSnap = await FirebaseFirestore.instance
          .collection('partnerLinks')
          .doc(code.trim().toUpperCase())
          .get();
      return linkSnap.data()?['ownerUid'] as String?;
    } catch (e) {
      debugPrint('CloudSyncService resolveOwnerUid failed: $e');
      return null;
    }
  }

  /// Live stream of a linked owner's partner-safe view.
  Stream<Map<String, dynamic>?> partnerViewStream(String ownerUid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(ownerUid)
        .collection('partnerView')
        .doc('summary')
        .snapshots()
        .map((snap) => snap.data());
  }

  String _generateReferralCode() {
    final rand = Random.secure();
    return List.generate(6, (_) => _partnerCodeChars[rand.nextInt(_partnerCodeChars.length)]).join();
  }

  /// Returns the signed-in user's referral code, generating and persisting
  /// one on first call. Returns null when signed out — referrals need a
  /// cloud identity to link two accounts together.
  Future<String?> getOrCreateReferralCode() async {
    final doc = _userDoc;
    final uid = _uid;
    if (doc == null || uid == null) return null;

    try {
      final snap = await doc.get();
      final existing = snap.data()?['referralCode'] as String?;
      if (existing != null && existing.isNotEmpty) return existing;

      final code = _generateReferralCode();
      await FirebaseFirestore.instance.collection('referralCodes').doc(code).set({'ownerUid': uid});
      await doc.set({'referralCode': code}, SetOptions(merge: true));
      return code;
    } catch (e) {
      debugPrint('CloudSyncService getOrCreateReferralCode failed: $e');
      return null;
    }
  }

  Future<String?> resolveReferrerUid(String code) async {
    try {
      final snap = await FirebaseFirestore.instance
          .collection('referralCodes')
          .doc(code.trim().toUpperCase())
          .get();
      return snap.data()?['ownerUid'] as String?;
    } catch (e) {
      debugPrint('CloudSyncService resolveReferrerUid failed: $e');
      return null;
    }
  }

  /// Records that [referrerUid] earned a referral reward, as a credit doc
  /// under their own subcollection. The redeeming device can't safely
  /// write the referrer's premium status directly, so the referrer claims
  /// this credit themselves the next time they sync (see [pullReferralCredits]).
  Future<void> createReferralCredit(String referrerUid, int days) {
    return _safeWrite(
      () => FirebaseFirestore.instance
          .collection('users')
          .doc(referrerUid)
          .collection('referralCredits')
          .add({'days': days, 'createdAt': DateTime.now().toIso8601String()}),
    );
  }

  /// Pulls the signed-in user's own unclaimed referral credits. The caller
  /// must apply them and then delete each via [deleteReferralCredit].
  Future<List<MapEntry<String, int>>> pullReferralCredits() async {
    final doc = _userDoc;
    if (doc == null) return [];

    try {
      final snap = await doc.collection('referralCredits').get();
      return snap.docs
          .map((d) => MapEntry(d.id, (d.data()['days'] as num?)?.toInt() ?? 0))
          .toList();
    } catch (e) {
      debugPrint('CloudSyncService pullReferralCredits failed: $e');
      return [];
    }
  }

  Future<void> deleteReferralCredit(String docId) {
    final doc = _userDoc;
    if (doc == null) return Future.value();
    return _safeWrite(() => doc.collection('referralCredits').doc(docId).delete());
  }

  Future<void> markReferralRedeemed() {
    final doc = _userDoc;
    if (doc == null) return Future.value();
    return _safeWrite(() => doc.set({'hasRedeemedReferral': true}, SetOptions(merge: true)));
  }

  Future<void> pushBonusPremiumUntil(DateTime until) {
    final doc = _userDoc;
    if (doc == null) return Future.value();
    return _safeWrite(
      () => doc.set({'bonusPremiumUntil': until.toIso8601String()}, SetOptions(merge: true)),
    );
  }
}
