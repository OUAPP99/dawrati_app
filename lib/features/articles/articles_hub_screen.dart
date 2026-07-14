import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../home/sections/article_carousel_section.dart';
import 'data/articles_data.dart';

class ArticlesHubScreen extends StatelessWidget {
  const ArticlesHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 120),
          children: [
            Text(
              t.articlesHubTitle,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 6),
            Text(
              t.articlesHubSubtitle,
              style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 26),
            ArticleCarouselSection(
              heading: t.todaysArticles,
              articles: todaysArticles(t),
            ),
            const SizedBox(height: 32),
            ArticleCarouselSection(
              heading: t.basedOnCycle,
              articles: basedOnCycleArticles(t),
              cardWidth: 235,
              cardImageHeight: 140,
              sectionHeight: 270,
            ),
            const SizedBox(height: 32),
            ArticleCarouselSection(
              heading: t.startOfCycleSectionTitle,
              articles: startOfCycleArticles(t),
            ),
            const SizedBox(height: 32),
            ArticleCarouselSection(
              heading: t.liveBetterSectionTitle,
              articles: liveBetterArticles(t),
            ),
          ],
        ),
      ),
    );
  }
}
