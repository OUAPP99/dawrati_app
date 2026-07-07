import 'package:flutter/material.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  void selectLanguage(BuildContext context, String lang) {
    Navigator.pushReplacementNamed(
      context,
      '/onboarding',
      arguments: lang,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              const Icon(Icons.favorite_rounded, color: Colors.pink, size: 82),
              const SizedBox(height: 22),
              const Text(
                "دورتي",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Choose your language",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 45),

              _button(context, "العربية", "ar"),
              const SizedBox(height: 16),
              _button(context, "Français", "fr"),
              const SizedBox(height: 16),
              _button(context, "English", "en"),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button(BuildContext context, String text, String lang) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: () => selectLanguage(context, lang),
        child: Text(text, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}