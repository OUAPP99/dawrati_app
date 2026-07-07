import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: const Color(0xFFFFE4EC),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(
            Icons.favorite,
            color: Color(0xFFE91E63),
            size: 28,
          ),
        ),

        const SizedBox(width: 16),

        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                "دورتي",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 4),

              Text(
                "Your daily health companion",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

            ],
          ),
        ),

        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
        ),
      ],
    );
  }
}