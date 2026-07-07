import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/subscription/subscription_provider.dart';

class PremiumGate extends StatelessWidget {
  final Widget child;
  final String title;
  final String description;

  const PremiumGate({
    super.key,
    required this.child,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final subscription = context.watch<SubscriptionProvider>();

    if (subscription.isPremium) {
      return child;
    }

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.lock,
            size: 42,
            color: Colors.amber,
          ),

          const SizedBox(height: 18),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/premium',
              );
            },
            icon: const Icon(Icons.workspace_premium),
            label: const Text("Unlock Premium"),
          ),
        ],
      ),
    );
  }
}