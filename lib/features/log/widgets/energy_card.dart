import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class EnergyCard extends StatelessWidget {
  final double energy;
  final ValueChanged<double> onChanged;

  const EnergyCard({
    super.key,
    required this.energy,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _card(
      title: AppLocalizations.of(context).energyTitle,
      child: Column(
        children: [
          Text(
            "${energy.round()} / 10",
            style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900),
          ),
          Slider(
            value: energy,
            min: 0,
            max: 10,
            divisions: 10,
            label: "${energy.round()}",
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _card({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        const SizedBox(height: 18),
        child,
      ]),
    );
  }
}