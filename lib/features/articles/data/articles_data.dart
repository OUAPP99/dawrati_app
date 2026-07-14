import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../models/article.dart';

List<Article> todaysArticles(AppLocalizations t) => [
      Article(
        id: 'fertility',
        title: t.articleFertilityTitle,
        subtitle: t.articleFertilitySubtitle,
        body: t.articleFertilityBody,
        image: 'assets/images/articles/fertility.png',
        color: const Color(0xFF9DB4FF),
      ),
      Article(
        id: 'cramps',
        title: t.articleCrampsTitle,
        subtitle: t.articleCrampsSubtitle,
        body: t.articleCrampsBody,
        image: 'assets/images/articles/cramps.png',
        color: const Color(0xFFE3C7FF),
      ),
      Article(
        id: 'cycle_ai',
        title: t.articleCycleTitle,
        subtitle: t.dawratiAiLabel,
        body: t.articleCycleBody,
        image: 'assets/images/articles/cycle_ai.png',
        color: const Color(0xFFFFD9E8),
      ),
    ];

List<Article> basedOnCycleArticles(AppLocalizations t) => [
      Article(
        id: 'body',
        title: t.learningBodyTitle,
        subtitle: t.minutesReadLabel(7),
        body: t.learningBodyText,
        image: 'assets/images/articles/body.png',
        color: const Color(0xFFFFE3EC),
      ),
      Article(
        id: 'habits',
        title: t.learningHabitsTitle,
        subtitle: t.minutesReadLabel(5),
        body: t.learningHabitsBody,
        image: 'assets/images/articles/habits.png',
        color: const Color(0xFFE9E2FF),
      ),
      Article(
        id: 'hormones',
        title: t.learningHormonesTitle,
        subtitle: t.minutesReadLabel(8),
        body: t.learningHormonesBody,
        image: 'assets/images/articles/hormones.png',
        color: const Color(0xFFFFF1D9),
      ),
    ];

List<Article> startOfCycleArticles(AppLocalizations t) => [
      Article(
        id: 'discharge',
        title: t.startArticle1Title,
        subtitle: t.startArticle1Subtitle,
        body: t.startArticle1Body,
        image: 'assets/images/articles/symptoms.png',
        color: const Color(0xFFD8F0E4),
      ),
      Article(
        id: 'pregnancy_signs',
        title: t.startArticle2Title,
        subtitle: t.startArticle2Subtitle,
        body: t.startArticle2Body,
        image: 'assets/images/articles/fertility.png',
        color: const Color(0xFFFFE7D6),
      ),
      Article(
        id: 'ease_pain',
        title: t.startArticle3Title,
        subtitle: t.startArticle3Subtitle,
        body: t.startArticle3Body,
        image: 'assets/images/articles/cramps.png',
        color: const Color(0xFFE3C7FF),
      ),
    ];

List<Article> liveBetterArticles(AppLocalizations t) => [
      Article(
        id: 'breast_tenderness',
        title: t.liveArticle1Title,
        subtitle: t.liveArticle1Subtitle,
        body: t.liveArticle1Body,
        image: 'assets/images/articles/hormones.png',
        color: const Color(0xFFFFF1D9),
      ),
      Article(
        id: 'bloating',
        title: t.liveArticle2Title,
        subtitle: t.liveArticle2Subtitle,
        body: t.liveArticle2Body,
        image: 'assets/images/articles/habits.png',
        color: const Color(0xFFE9E2FF),
      ),
      Article(
        id: 'sleep',
        title: t.liveArticle3Title,
        subtitle: t.liveArticle3Subtitle,
        body: t.liveArticle3Body,
        image: 'assets/images/articles/body.png',
        color: const Color(0xFFFFE3EC),
      ),
    ];
