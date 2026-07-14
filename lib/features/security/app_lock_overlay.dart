import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_lock_provider.dart';
import 'lock_screen.dart';

/// Wraps the whole app. When app lock is enabled and the session isn't
/// unlocked yet (cold start, or returning from the background), shows the
/// [LockScreen] on top of everything else instead of navigating routes
/// around — simplest way to guarantee it always wins regardless of what
/// screen is currently open.
class AppLockOverlay extends StatelessWidget {
  final Widget child;

  const AppLockOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final appLock = context.watch<AppLockProvider>();
    final locked = appLock.isReady && appLock.isLockEnabled && !appLock.isUnlocked;

    return Stack(
      children: [
        child,
        if (locked) const LockScreen(),
      ],
    );
  }
}
