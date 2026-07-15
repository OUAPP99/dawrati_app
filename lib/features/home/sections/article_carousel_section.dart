import 'package:flutter/material.dart';

import '../../../core/theme/app_color_scheme.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/widgets/animated_tap.dart';
import '../../../l10n/app_localizations.dart';
import '../../articles/article_detail_screen.dart';
import '../../articles/articles_list_screen.dart';
import '../../articles/models/article.dart';

class ArticleCarouselSection extends StatelessWidget {
  final String heading;
  final List<Article> articles;
  final double cardWidth;
  final double cardImageHeight;
  final double sectionHeight;

  const ArticleCarouselSection({
    super.key,
    required this.heading,
    required this.articles,
    this.cardWidth = 220,
    this.cardImageHeight = 125,
    this.sectionHeight = 260,
  });

  void _openArticle(BuildContext context, Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: article)),
    );
  }

  void _openAll(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ArticlesListScreen(title: heading, articles: articles)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                heading,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: context.colors.textPrimary),
              ),
            ),
            InkWell(
              onTap: () => _openAll(context),
              child: Row(
                children: [
                  Text(t.seeAll, style: TextStyle(fontSize: 17, color: context.colors.textSecondary, fontWeight: FontWeight.w700)),
                  const SizedBox(width: 4),
                  Icon(Icons.chevron_right, color: context.colors.textSecondary),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: sectionHeight,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (final article in articles) ...[
                _Card(
                  article: article,
                  width: cardWidth,
                  imageHeight: cardImageHeight,
                  onTap: () => _openArticle(context, article),
                ),
                const SizedBox(width: 16),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final Article article;
  final double width;
  final double imageHeight;
  final VoidCallback onTap;

  const _Card({
    required this.article,
    required this.width,
    required this.imageHeight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTap(
      onTap: onTap,
      child: Container(
        width: width,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: article.color,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: AppShadows.soft,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              article.image,
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      height: 1.05,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    article.subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
