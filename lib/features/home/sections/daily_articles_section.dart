import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../articles/data/articles_data.dart';
import 'article_carousel_section.dart';

class DailyArticlesSection extends StatelessWidget {
  const DailyArticlesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return ArticleCarouselSection(
      heading: t.todaysArticles,
      articles: todaysArticles(t),
    );
  }
}
