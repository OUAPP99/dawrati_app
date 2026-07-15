import 'package:flutter/material.dart';

import '../../core/theme/app_color_scheme.dart';
import '../../l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  List<Map<String, dynamic>> _pages(AppLocalizations t) => [
    {
      "icon": Icons.favorite,
      "title": t.onboardTitle1,
      "description": t.onboardDesc1,
    },
    {
      "icon": Icons.calendar_month,
      "title": t.onboardTitle2,
      "description": t.onboardDesc2,
    },
    {
      "icon": Icons.edit_note,
      "title": t.onboardTitle3,
      "description": t.onboardDesc3,
    },
    {
      "icon": Icons.auto_awesome,
      "title": t.onboardTitle4,
      "description": t.onboardDesc4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final pages = _pages(t);
    final isLast = currentPage == pages.length - 1;
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),

            Image.asset(
              "assets/images/logo_header.png",
              height: 58,
            ),

            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() => currentPage = index);
                },
                itemBuilder: (context, index) {
                  final page = pages[index];

                  return Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFFEAF3),
                                Color(0xFFEDE7FF),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            page["icon"] as IconData,
                            size: 88,
                            color: const Color(0xFFE91E63),
                          ),
                        ),

                        const SizedBox(height: 50),

                        Text(
                          page["title"] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                          ),
                        ),

                        const SizedBox(height: 18),

                        Text(
                          page["description"] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: colors.textSecondary,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentPage == index ? 26 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? const Color(0xFFE91E63)
                        : Colors.pink.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(25),
              child: SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    if (!isLast) {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeOutCubic,
                      );
                    } else {
                      Navigator.pushReplacementNamed(context, "/login");
                    }
                  },
                  child: Text(
                    isLast ? t.getStarted : t.next,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}