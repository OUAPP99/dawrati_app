import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class MedicationCard extends StatefulWidget {
  final List<String> medications;
  final ValueChanged<List<String>> onChanged;

  const MedicationCard({
    super.key,
    required this.medications,
    required this.onChanged,
  });

  @override
  State<MedicationCard> createState() => _MedicationCardState();
}

class _MedicationCardState extends State<MedicationCard> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _add() {
    final value = controller.text.trim();
    if (value.isEmpty) return;

    widget.onChanged([...widget.medications, value]);
    controller.clear();
  }

  void _remove(String medication) {
    widget.onChanged(widget.medications.where((m) => m != medication).toList());
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.medicationsTitle, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  onSubmitted: (_) => _add(),
                  decoration: InputDecoration(
                    hintText: t.addMedicationHint,
                    filled: true,
                    fillColor: const Color(0xFFFFF7FA),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _add,
                style: ElevatedButton.styleFrom(minimumSize: const Size(0, 56)),
                child: Text(t.add),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (widget.medications.isEmpty)
            Text(t.noMedicationsAdded, style: const TextStyle(color: Colors.grey))
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.medications
                  .map(
                    (m) => Chip(
                      label: Text(m),
                      backgroundColor: const Color(0xFFFFEAF3),
                      deleteIcon: const Icon(Icons.close, size: 16),
                      onDeleted: () => _remove(m),
                      side: BorderSide.none,
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
