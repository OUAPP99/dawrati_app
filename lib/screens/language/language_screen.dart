import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_color_scheme.dart';
import '../../features/app_state/app_state_provider.dart';
import '../../l10n/app_localizations.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  void selectLanguage(BuildContext context, String lang) {
    context.read<AppStateProvider>().setLanguage(lang);

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLang = context.watch<AppStateProvider>().languageCode;
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              const Icon(Icons.favorite_rounded, color: Colors.pink, size: 82),
              const SizedBox(height: 22),
              Text(
                t.appName,
                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                t.chooseLanguageTitle,
                style: TextStyle(fontSize: 18, color: context.colors.textSecondary),
              ),
              const SizedBox(height: 45),

              _button(context, "العربية", "ar", currentLang),
              const SizedBox(height: 16),
              _button(context, "Français", "fr", currentLang),
              const SizedBox(height: 16),
              _button(context, "English", "en", currentLang),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button(BuildContext context, String text, String lang, String currentLang) {
    final selected = lang == currentLang;

    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton.icon(
        onPressed: () => selectLanguage(context, lang),
        icon: selected ? const Icon(Icons.check_circle, size: 20) : const SizedBox.shrink(),
        label: Text(text, style: const TextStyle(fontSize: 20)),
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? const Color(0xFFE91E63) : null,
          foregroundColor: selected ? Colors.white : null,
        ),
      ),
    );
  }
}