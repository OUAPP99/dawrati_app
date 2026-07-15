import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_color_scheme.dart';
import '../../features/app_state/theme_provider.dart';
import '../../l10n/app_localizations.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final current = context.watch<ThemeProvider>().themeMode;
    final t = AppLocalizations.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: Text(t.settingsTheme)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                t.chooseThemeTitle,
                style: TextStyle(fontSize: 18, color: colors.textSecondary),
              ),
              const SizedBox(height: 28),
              _option(context, Icons.brightness_auto, t.themeSystem, ThemeMode.system, current),
              const SizedBox(height: 14),
              _option(context, Icons.light_mode, t.themeLight, ThemeMode.light, current),
              const SizedBox(height: 14),
              _option(context, Icons.dark_mode, t.themeDark, ThemeMode.dark, current),
            ],
          ),
        ),
      ),
    );
  }

  Widget _option(BuildContext context, IconData icon, String label, ThemeMode mode, ThemeMode current) {
    final colors = context.colors;
    final selected = mode == current;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => context.read<ThemeProvider>().setThemeMode(mode),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: selected ? colors.surfaceAlt : colors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? const Color(0xFFE91E63) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFE91E63)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: colors.textPrimary),
              ),
            ),
            if (selected) const Icon(Icons.check_circle, color: Color(0xFFE91E63)),
          ],
        ),
      ),
    );
  }
}
