import 'package:flutter/material.dart';

class PinKeypad extends StatelessWidget {
  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;
  final Widget? extraAction;

  const PinKeypad({
    super.key,
    required this.onDigit,
    required this.onBackspace,
    this.extraAction,
  });

  @override
  Widget build(BuildContext context) {
    final rows = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final row in rows)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: row.map((d) => _key(Text(d, style: _digitStyle), () => onDigit(d))).toList(),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _key(extraAction ?? const SizedBox(width: 70, height: 70), extraAction == null ? null : () {}),
              _key(Text('0', style: _digitStyle), () => onDigit('0')),
              _key(const Icon(Icons.backspace_outlined), onBackspace),
            ],
          ),
        ),
      ],
    );
  }

  static const _digitStyle = TextStyle(fontSize: 26, fontWeight: FontWeight.w700);

  Widget _key(Widget child, VoidCallback? onTap) {
    return SizedBox(
      width: 70,
      height: 70,
      child: onTap == null && child is SizedBox
          ? child
          : Material(
              color: Colors.white,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onTap,
                child: Center(child: child),
              ),
            ),
    );
  }
}

class PinDots extends StatelessWidget {
  final int length;
  final int filled;
  final bool error;

  const PinDots({
    super.key,
    required this.length,
    required this.filled,
    this.error = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (i) {
        final isFilled = i < filled;
        final color = error
            ? Colors.red
            : (isFilled ? const Color(0xFFE91E63) : Colors.grey.shade300);
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        );
      }),
    );
  }
}
