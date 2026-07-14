import 'package:flutter/material.dart';

import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadows.dart';
import 'article_detail_screen.dart';
import 'models/article.dart';

class ArticlesListScreen extends StatelessWidget {
  final String title;
  final List<Article> articles;

  const ArticlesListScreen({super.key, required this.title, required this.articles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 22, 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(22, 4, 22, 30),
                itemCount: articles.length,
                separatorBuilder: (_, _) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: article)),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        boxShadow: AppShadows.soft,
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image.asset(
                              article.image,
                              width: 72,
                              height: 72,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.title,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  article.subtitle,
                                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
