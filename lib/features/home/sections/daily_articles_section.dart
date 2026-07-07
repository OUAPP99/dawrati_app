import 'package:flutter/material.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_radius.dart';

class DailyArticlesSection extends StatelessWidget {
  const DailyArticlesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today's Articles",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 260,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _ArticleCard(
                color: Color(0xFF9DB4FF),
                title: "Your fertility today",
                subtitle: "Updated now",
                image: "assets/images/articles/fertility.png",
              ),
              SizedBox(width: 16),
              _ArticleCard(
                color: Color(0xFFE3C7FF),
                title: "How to relieve cramps",
                subtitle: "5 min read",
                image: "assets/images/articles/cramps.png",
              ),
              SizedBox(width: 16),
              _ArticleCard(
                color: Color(0xFFFFD9E8),
                title: "Understand your cycle",
                subtitle: "Dawrati AI",
                image: "assets/images/articles/cycle_ai.png",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final String image;

  const _ArticleCard({
    required this.color,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            image,
            height: 125,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      height: 1.05,
                    )),
                const SizedBox(height: 10),
                Text(subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}