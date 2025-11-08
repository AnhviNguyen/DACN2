import 'package:flutter/material.dart';

import '../lesson_dashboard_data.dart';

class LessonVideoSummarySection extends StatelessWidget {
  const LessonVideoSummarySection({super.key, required this.items});

  final List<LessonVideoSummary> items;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];

    for (var i = 0; i < items.length; i += 2) {
      final chunk = items.skip(i).take(2).toList();
      rows.add(
        Row(
          children: [
            Expanded(child: _LessonVideoCard(item: chunk.first)),
            const SizedBox(width: 12),
            if (chunk.length > 1)
              Expanded(child: _LessonVideoCard(item: chunk[1]))
            else
              const Expanded(child: SizedBox.shrink()),
          ],
        ),
      );
      if (i + 2 < items.length) {
        rows.add(const SizedBox(height: 12));
      }
    }

    return Column(children: rows);
  }
}

class _LessonVideoCard extends StatelessWidget {
  const _LessonVideoCard({required this.item});

  final LessonVideoSummary item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFFDE68A)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: item.highlight ? Colors.black : const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              item.icon,
              color: item.highlight ? const Color(0xFFFACC15) : Colors.black,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF6B7280),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color:
                        item.highlight ? const Color(0xFFCA8A04) : Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
