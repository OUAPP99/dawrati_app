import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import 'app_lock_provider.dart';
import 'widgets/pin_keypad.dart';

/// Full-screen unlock gate shown at cold start and whenever the app
/// returns from the background while app lock is enabled.
class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  String entered = '';
  bool error = false;
  bool _promptedBiometrics = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appLock = context.read<AppLockProvider>();
    if (appLock.useBiometrics && !_promptedBiometrics) {
      _promptedBiometrics = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _tryBiometrics());
    }
  }

  Future<void> _tryBiometrics() async {
    final appLock = context.read<AppLockProvider>();
    final ok = await appLock.authenticateWithBiometrics();
    if (ok) appLock.unlock();
  }

  void _onDigit(String digit) {
    if (entered.length >= AppLockProvider.pinLength) return;
    setState(() {
      error = false;
      entered += digit;
    });

    if (entered.length == AppLockProvider.pinLength) {
      final appLock = context.read<AppLockProvider>();
      if (appLock.verifyPin(entered)) {
        appLock.unlock();
      } else {
        setState(() => error = true);
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) setState(() => entered = '');
        });
      }
    }
  }

  void _onBackspace() {
    if (entered.isEmpty) return;
    setState(() {
      error = false;
      entered = entered.substring(0, entered.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final appLock = context.watch<AppLockProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.favorite, color: Color(0xFFE91E63), size: 56),
              const SizedBox(height: 20),
              Text(
                error ? t.appLockWrongPin : t.appLockEnterPin,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: error ? Colors.red : Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              PinDots(length: AppLockProvider.pinLength, filled: entered.length, error: error),
              const SizedBox(height: 36),
              PinKeypad(
                onDigit: _onDigit,
                onBackspace: _onBackspace,
                extraAction: appLock.useBiometrics
                    ? IconButton(
                        iconSize: 30,
                        onPressed: _tryBiometrics,
                        icon: const Icon(Icons.fingerprint),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
