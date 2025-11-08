import 'package:flutter/material.dart';

import '../lesson_dashboard_data.dart';

class LessonSummaryStatsSection extends StatelessWidget {
  const LessonSummaryStatsSection({super.key, required this.stats});

  final List<LessonSummaryStat> stats;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          stats
              .map(
                (stat) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _LessonSummaryCard(stat: stat),
                ),
              )
              .toList(),
    );
  }
}

class _LessonSummaryCard extends StatelessWidget {
  const _LessonSummaryCard({required this.stat});

  final LessonSummaryStat stat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompleted = stat.total == 0;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFFDE68A)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(stat.icon, color: Colors.black87),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  stat.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                '${stat.completed}',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: const Color(0xFFCA8A04),
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                ' / ${stat.total}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF6B7280),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              minHeight: 12,
              value: isCompleted ? 0 : stat.completionRate.clamp(0, 1),
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: const AlwaysStoppedAnimation(Color(0xFFFACC15)),
            ),
          ),
        ],
      ),
    );
  }
}
