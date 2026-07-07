import 'package:flutter/material.dart';

class AccueilScreen extends StatelessWidget {
  final DateTime dateDebutRegles;
  final Map<String, String> textes;
  final VoidCallback onChangerDate;

  const AccueilScreen({
    super.key,
    required this.dateDebutRegles,
    required this.textes,
    required this.onChangerDate,
  });

  @override
  Widget build(BuildContext context) {
    final jourDuCycle =
        DateTime.now().difference(dateDebutRegles).inDays + 1;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.pink.shade200, width: 6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textes['jour']!,
                  style: TextStyle(fontSize: 20, color: Colors.pink.shade400),
                ),
                Text(
                  '$jourDuCycle',
                  style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink.shade700,
                  ),
                ),
                Text(
                  textes['deTonCycle']!,
                  style: TextStyle(fontSize: 16, color: Colors.pink.shade400),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: onChangerDate,
            icon: const Icon(Icons.calendar_today),
            label: Text(textes['choisirDate']!),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink.shade100,
              foregroundColor: Colors.pink.shade900,
            ),
          ),
        ],
      ),
    );
  }
}