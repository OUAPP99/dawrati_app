import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class SaveButton extends StatelessWidget {
  final Future<void> Function() onSave;

  const SaveButton({
    super.key,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton.icon(
        onPressed: () async {
          await onSave();
        },
        icon: const Icon(Icons.check),
        label: Text(
          AppLocalizations.of(context).saveLog,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}