import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class FlowCard extends StatelessWidget {
  final String? selectedFlow;
  final ValueChanged<String> onChanged;

  const FlowCard({
    super.key,
    required this.selectedFlow,
    required this.onChanged,
  });

  static const flows = [
    ("Spotting", "●"),
    ("Light", "●●"),
    ("Medium", "●●●"),
    ("Heavy", "●●●●"),
  ];

  static String label(AppLocalizations t, String key) {
    switch (key) {
      case "Spotting":
        return t.flowSpotting;
      case "Light":
        return t.flowLight;
      case "Medium":
        return t.flowMedium;
      case "Heavy":
        return t.flowHeavy;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return _card(
      title: t.periodFlowTitle,
      child: Row(
        children: flows.map((flow) {
          final selected = selectedFlow == flow.$1;

          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(flow.$1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: selected ? const Color(0xFFFFEAF3) : const Color(0xFFFFF7FA),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: selected ? const Color(0xFFE91E63) : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Text(flow.$2, style: const TextStyle(color: Color(0xFFE91E63))),
                    const SizedBox(height: 6),
                    Text(label(t, flow.$1), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
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