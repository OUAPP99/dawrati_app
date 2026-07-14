import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/app_state/app_state_provider.dart';
import '../../features/auth/auth_provider.dart';
import '../../l10n/app_localizations.dart';

class EmailAuthScreen extends StatefulWidget {
  final bool startInSignIn;

  const EmailAuthScreen({super.key, this.startInSignIn = false});

  @override
  State<EmailAuthScreen> createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  late bool signInMode = widget.startInSignIn;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? error;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String _errorLabel(AppLocalizations t, String? code) {
    switch (code) {
      case 'invalid-email':
        return t.authErrorInvalidEmail;
      case 'user-not-found':
        return t.authErrorUserNotFound;
      case 'wrong-password':
      case 'invalid-credential':
        return t.authErrorWrongPassword;
      case 'email-already-in-use':
        return t.authErrorEmailInUse;
      case 'weak-password':
        return t.authErrorWeakPassword;
      default:
        return t.authErrorGeneric;
    }
  }

  Future<void> _submit() async {
    final t = AppLocalizations.of(context);
    final auth = context.read<AuthProvider>();

    setState(() => error = null);

    final result = signInMode
        ? await auth.signInWithEmail(emailController.text, passwordController.text)
        : await auth.signUpWithEmail(emailController.text, passwordController.text);

    if (!mounted) return;

    if (!result.ok) {
      setState(() => error = _errorLabel(t, result.errorCode));
      return;
    }

    _afterAuthSuccess(isNewUser: result.isNewUser);
  }

  void _afterAuthSuccess({required bool isNewUser}) {
    if (isNewUser) {
      Navigator.pushReplacementNamed(context, '/questionnaire');
    } else {
      context.read<AppStateProvider>().completeOnboarding();
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Future<void> _forgotPassword() async {
    final t = AppLocalizations.of(context);
    final auth = context.read<AuthProvider>();

    if (emailController.text.trim().isEmpty) {
      setState(() => error = t.authErrorInvalidEmail);
      return;
    }

    final result = await auth.sendPasswordResetEmail(emailController.text);
    if (!mounted) return;

    if (result.ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.passwordResetSent)),
      );
    } else {
      setState(() => error = _errorLabel(t, result.errorCode));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(28, 20, 28, 40),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Text(
              signInMode ? t.emailAuthSignInTitle : t.emailAuthSignUpTitle,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 30),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: t.emailLabel,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: t.passwordLabel,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            if (signInMode) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _forgotPassword,
                  child: Text(t.forgotPassword),
                ),
              ),
            ],

            if (error != null) ...[
              const SizedBox(height: 8),
              Text(error!, style: const TextStyle(color: Colors.red)),
            ],

            const SizedBox(height: 20),

            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: auth.isLoading ? null : _submit,
                child: auth.isLoading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : Text(
                        signInMode ? t.signInButton : t.signUpButton,
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: TextButton(
                onPressed: () => setState(() {
                  signInMode = !signInMode;
                  error = null;
                }),
                child: Text(
                  signInMode ? t.switchToSignUp : t.switchToSignIn,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
