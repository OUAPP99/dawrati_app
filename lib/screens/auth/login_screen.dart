import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_color_scheme.dart';
import '../../features/app_state/app_state_provider.dart';
import '../../features/auth/auth_provider.dart';
import '../../features/partner/partner_entry_screen.dart';
import '../../l10n/app_localizations.dart';
import 'email_auth_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _continueAsGuest(BuildContext context) {
    context.read<AuthProvider>().continueAsGuest();
    Navigator.pushReplacementNamed(context, "/questionnaire");
  }

  void _openEmailAuth(BuildContext context, {required bool signIn}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EmailAuthScreen(startInSignIn: signIn)),
    );
  }

  void _openPartnerEntry(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PartnerEntryScreen()),
    );
  }

  void _showAppleComingSoon(BuildContext context) {
    final t = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(t.appleSignInComingSoon)),
    );
  }

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    final t = AppLocalizations.of(context);
    final auth = context.read<AuthProvider>();

    final result = await auth.signInWithGoogle();
    if (!context.mounted) return;

    if (!result.ok) {
      if (result.errorCode == 'cancelled') return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.authErrorGeneric)),
      );
      return;
    }

    if (result.isNewUser) {
      Navigator.pushReplacementNamed(context, '/questionnaire');
    } else {
      await context.read<AppStateProvider>().completeOnboarding();
      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(28, 30, 28, 40),
          children: [
            const SizedBox(height: 20),

            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFFEAF3),
                      Color(0xFFEDE7FF),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Color(0xFFE91E63),
                  size: 60,
                ),
              ),
            ),

            const SizedBox(height: 36),

            Text(
              t.welcomeTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                height: 1.15,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              t.welcomeSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: colors.textSecondary,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 45),

            _button(
              icon: Icons.apple,
              text: t.continueWithApple,
              color: Colors.black,
              textColor: Colors.white,
              onTap: () => _showAppleComingSoon(context),
            ),

            const SizedBox(height: 16),

            _button(
              icon: Icons.g_mobiledata,
              text: t.continueWithGoogle,
              color: Colors.white,
              textColor: Colors.black,
              border: true,
              onTap: () => _handleGoogleSignIn(context),
            ),

            const SizedBox(height: 16),

            _button(
              icon: Icons.email_outlined,
              text: t.continueWithEmail,
              color: const Color(0xFFE91E63),
              textColor: Colors.white,
              onTap: () => _openEmailAuth(context, signIn: false),
            ),

            const SizedBox(height: 30),

            Center(
              child: TextButton(
                onPressed: () => _continueAsGuest(context),
                child: Text(
                  t.continueWithoutAccount,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Divider(),

            const SizedBox(height: 20),

            Center(
              child: TextButton(
                onPressed: () => _openEmailAuth(context, signIn: true),
                child: Text(
                  t.alreadyHaveAccount,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            Center(
              child: TextButton.icon(
                onPressed: () => _openPartnerEntry(context),
                icon: Icon(Icons.favorite_border, size: 18, color: colors.textSecondary),
                label: Text(
                  t.partnerEntryLink,
                  style: TextStyle(fontWeight: FontWeight.w600, color: colors.textSecondary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _button({
    required IconData icon,
    required String text,
    required Color color,
    required Color textColor,
    bool border = false,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 58,
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          elevation: border ? 0 : 2,
          backgroundColor: color,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: border
                ? const BorderSide(color: Color(0xFFE8E8E8))
                : BorderSide.none,
          ),
        ),
        onPressed: onTap,
        icon: Icon(icon, size: 28),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}