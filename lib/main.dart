import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'config/app_routes.dart';
import 'core/services/notification_service.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

import 'features/app_state/app_startup.dart';
import 'features/app_state/app_state_provider.dart';
import 'features/app_state/partner_view_sync.dart';
import 'features/app_state/sync_gate.dart';
import 'features/auth/auth_provider.dart';

import 'features/app_state/home_widget_sync.dart';
import 'features/cycle/cycle_provider.dart';
import 'features/log/provider/daily_log_provider.dart';
import 'features/notifications/notification_settings_provider.dart';
import 'features/partner/partner_mode_provider.dart';
import 'features/security/app_lock_overlay.dart';
import 'features/security/app_lock_provider.dart';
import 'features/subscription/subscription_provider.dart';
import 'features/app_state/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: 'env_config.txt');
  } catch (_) {
    // No secrets file bundled (e.g. fresh checkout) — AI features will
    // report a missing API key instead of crashing the whole app.
    dotenv.testLoad(fileInput: '');
  }

  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
        .timeout(const Duration(seconds: 10));

    // Attests that Firestore requests come from the real app binary
    // (Play Integrity on Android, App Attest on iOS) instead of a
    // scripted client with a stolen API key. Debug provider is used in
    // debug builds since real devices/emulators aren't attestable there.
    await FirebaseAppCheck.instance.activate(
      providerAndroid: kDebugMode ? AndroidDebugProvider() : AndroidPlayIntegrityProvider(),
      providerApple: kDebugMode ? AppleDebugProvider() : AppleAppAttestProvider(),
    );
  } catch (e, st) {
    // Auth/cloud-sync features will be unavailable, but the rest of the
    // app must still start.
    debugPrint('Firebase.initializeApp failed: $e\n$st');
  }

  await NotificationService.instance.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppStateProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => CycleProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => DailyLogProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => SubscriptionProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => NotificationSettingsProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => PartnerModeProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => AppLockProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: const CycleApp(),
    ),
  );
}

class CycleApp extends StatelessWidget {
  const CycleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final cycleProvider = context.watch<CycleProvider>();
    final appState = context.watch<AppStateProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return SyncGate(
      child: PartnerViewSync(
        child: MaterialApp(
          title: 'دورتي',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          locale: Locale(appState.languageCode),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const AppStartup(),
          routes: AppRoutes.routes(
            dateDebutRegles: cycleProvider.periodStartDate,
            textes: const {
              'titre': 'دورتي',
              'jour': 'اليوم',
              'deTonCycle': 'من دورتك',
              'choisirDate': 'اختاري تاريخ الدورة',
            },
            onChangerDate: cycleProvider.updatePeriodStartDate,
          ),
          builder: (context, child) => AppLockOverlay(child: HomeWidgetSync(child: child!)),
        ),
      ),
    );
  }
}