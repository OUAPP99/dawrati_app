import 'package:flutter/material.dart';

class CycleLearningSection extends StatelessWidget {
  const CycleLearningSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Based on your current cycle",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 270,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              LearningCard(
                title: "Understanding your body",
                duration: "7 min",
                color: Color(0xFFFFE3EC),
                image: "assets/images/articles/body.png",
              ),
              SizedBox(width: 18),
              LearningCard(
                title: "Healthy habits",
                duration: "5 min",
                color: Color(0xFFE9E2FF),
                image: "assets/images/articles/habits.png",
              ),
              SizedBox(width: 18),
              LearningCard(
                title: "Hormones explained",
                duration: "8 min",
                color: Color(0xFFFFF1D9),
                image: "assets/images/articles/hormones.png",
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: OutlinedButton(
            onPressed: () {},
            child: const Text("See more"),
          ),
        ),
      ],
    );
  }
}

class LearningCard extends StatelessWidget {
  final String title;
  final String duration;
  final Color color;
  final String image;

  const LearningCard({
    super.key,
    required this.title,
    required this.duration,
    required this.color,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 235,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            image,
            height: 140,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    )),
                const SizedBox(height: 10),
                Text(duration),
              ],
            ),
          ),
        ],
      ),
    );
  }
}