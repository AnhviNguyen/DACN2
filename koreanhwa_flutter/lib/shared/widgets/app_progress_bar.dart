import 'package:flutter/material.dart';

class AppProgressBar extends StatelessWidget {
  final double value; // 0.0 - 1.0
  final bool showLabel;
  final Color? color;

  const AppProgressBar({
    super.key,
    required this.value,
    this.showLabel = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final clamped = value.clamp(0.0, 1.0);
    final barColor = color ?? Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: clamped,
            color: barColor,
            backgroundColor: barColor.withOpacity(.2),
            minHeight: 10,
          ),
        ),
        if (showLabel) ...[
          const SizedBox(height: 6),
          Text('${(clamped * 100).toStringAsFixed(0)}%', style: Theme.of(context).textTheme.labelMedium),
        ]
      ],
    );
  }
}
