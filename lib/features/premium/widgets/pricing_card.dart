import 'package:flutter/material.dart';

class PricingCard extends StatelessWidget {
  final String title;
  final String price;
  final bool selected;

  const PricingCard({
    super.key,
    required this.title,
    required this.price,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: selected ? Colors.pink.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: selected ? Colors.pink : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}