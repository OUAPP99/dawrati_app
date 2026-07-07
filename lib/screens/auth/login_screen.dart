import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _continue(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/questionnaire");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
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

            const Text(
              "Welcome to\nDawrati",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                height: 1.15,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "Track your cycle, understand your body and receive personalized AI insights.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 45),

            _button(
              icon: Icons.apple,
              text: "Continue with Apple",
              color: Colors.black,
              textColor: Colors.white,
              onTap: () => _continue(context),
            ),

            const SizedBox(height: 16),

            _button(
              icon: Icons.g_mobiledata,
              text: "Continue with Google",
              color: Colors.white,
              textColor: Colors.black,
              border: true,
              onTap: () => _continue(context),
            ),

            const SizedBox(height: 16),

            _button(
              icon: Icons.email_outlined,
              text: "Continue with Email",
              color: const Color(0xFFE91E63),
              textColor: Colors.white,
              onTap: () => _continue(context),
            ),

            const SizedBox(height: 30),

            Center(
              child: TextButton(
                onPressed: () => _continue(context),
                child: const Text(
                  "Continue without an account",
                  style: TextStyle(
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
                onPressed: () => _continue(context),
                child: const Text(
                  "I already have an account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
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