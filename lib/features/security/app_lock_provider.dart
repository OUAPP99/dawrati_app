import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Optional device-level lock (PIN + biometrics) gating access to the app.
/// This is purely local — it never touches the cloud — since its only job
/// is to stop someone who picks up an already-unlocked phone from opening
/// the app.
class AppLockProvider extends ChangeNotifier with WidgetsBindingObserver {
  static const int pinLength = 4;

  bool isLockEnabled = false;
  bool useBiometrics = false;

  /// Session-scoped: true once the user has entered the correct PIN or
  /// biometric this app session. Reset to false whenever the app is
  /// backgrounded, so returning to it requires unlocking again.
  bool isUnlocked = false;

  bool _loaded = false;
  String? _pinHash;
  String? _pinSalt;

  final LocalAuthentication _localAuth = LocalAuthentication();

  AppLockProvider() {
    WidgetsBinding.instance.addObserver(this);
    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    isLockEnabled = prefs.getBool('appLockEnabled') ?? false;
    useBiometrics = prefs.getBool('appLockUseBiometrics') ?? false;
    _pinHash = prefs.getString('appLockPinHash');
    _pinSalt = prefs.getString('appLockPinSalt');
    _loaded = true;
    notifyListeners();
  }

  bool get isReady => _loaded;

  Future<bool> canUseBiometrics() async {
    try {
      final supported = await _localAuth.isDeviceSupported();
      final canCheck = await _localAuth.canCheckBiometrics;
      return supported && canCheck;
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticateWithBiometrics() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: 'Unlock Dawrati',
        options: const AuthenticationOptions(biometricOnly: true, stickyAuth: true),
      );
    } catch (_) {
      return false;
    }
  }

  String _hash(String pin, String salt) {
    return sha256.convert(utf8.encode('$salt:$pin')).toString();
  }

  String _generateSalt() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    return base64UrlEncode(bytes);
  }

  /// Sets (or changes) the PIN and turns the lock on.
  Future<void> setupPin(String pin) async {
    final salt = _generateSalt();
    final hash = _hash(pin, salt);

    _pinSalt = salt;
    _pinHash = hash;
    isLockEnabled = true;
    isUnlocked = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('appLockPinSalt', salt);
    await prefs.setString('appLockPinHash', hash);
    await prefs.setBool('appLockEnabled', true);
  }

  bool verifyPin(String pin) {
    if (_pinHash == null || _pinSalt == null) return false;
    return _hash(pin, _pinSalt!) == _pinHash;
  }

  Future<void> setUseBiometrics(bool value) async {
    useBiometrics = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('appLockUseBiometrics', value);
  }

  Future<void> disableLock() async {
    isLockEnabled = false;
    useBiometrics = false;
    isUnlocked = true;
    _pinHash = null;
    _pinSalt = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('appLockEnabled', false);
    await prefs.setBool('appLockUseBiometrics', false);
    await prefs.remove('appLockPinHash');
    await prefs.remove('appLockPinSalt');
  }

  void unlock() {
    isUnlocked = true;
    notifyListeners();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!isLockEnabled) return;
    if (state == AppLifecycleState.paused) {
      isUnlocked = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
