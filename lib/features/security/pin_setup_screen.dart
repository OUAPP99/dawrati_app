import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_color_scheme.dart';
import '../../l10n/app_localizations.dart';
import 'app_lock_provider.dart';
import 'widgets/pin_keypad.dart';

/// Two-step PIN creation flow: enter a new PIN, then confirm it. Used both
/// for first-time setup and for changing an existing PIN.
class PinSetupScreen extends StatefulWidget {
  const PinSetupScreen({super.key});

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  String? firstPin;
  String entered = '';
  bool error = false;

  void _onDigit(String digit) {
    if (entered.length >= AppLockProvider.pinLength) return;
    setState(() {
      error = false;
      entered += digit;
    });

    if (entered.length == AppLockProvider.pinLength) {
      if (firstPin == null) {
        setState(() {
          firstPin = entered;
          entered = '';
        });
      } else if (entered == firstPin) {
        context.read<AppLockProvider>().setupPin(entered).then((_) {
          if (mounted) Navigator.pop(context, true);
        });
      } else {
        setState(() => error = true);
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              firstPin = null;
              entered = '';
            });
          }
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
    final title = firstPin == null
        ? (error ? t.appLockPinMismatch : t.appLockCreatePin)
        : t.appLockConfirmPin;
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 4,
              left: 4,
              child: IconButton(
                onPressed: () => Navigator.pop(context, false),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock_outline, color: Color(0xFFE91E63), size: 56),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: error ? Colors.red : colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  PinDots(length: AppLockProvider.pinLength, filled: entered.length, error: error),
                  const SizedBox(height: 36),
                  PinKeypad(onDigit: _onDigit, onBackspace: _onBackspace),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
