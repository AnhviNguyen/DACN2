import 'package:flutter/material.dart';

import '../../../point_system/point_system.dart';

class PointInfoCard extends StatelessWidget {
  const PointInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    const currentPoints = 450;
    final level = PointSystem.getStudentLevel(currentPoints);
    final progress = PointSystem.getProgressToNextLevel(currentPoints);

    final nextLevelDelta = progress.isMaxLevel
        ? 'MAX'
        : '${(progress.targetPointsWithinLevel ?? 0) - progress.currentPointsWithinLevel}';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 16, offset: const Offset(0, 8))],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            child: _MiniStat(
              title: 'Tổng điểm',
              value: '$currentPoints',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _MiniStat(
              title: 'Cấp độ',
              value: level.name,
              subtitle: level.description,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _MiniStat(
              title: 'Tiến độ lên cấp',
              value: '${progress.progressPercent.toStringAsFixed(0)}%',
              subtitle: progress.isMaxLevel
                  ? 'Đã đạt cấp cao nhất'
                  : 'Còn $nextLevelDelta điểm',
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.title,
    required this.value,
    this.subtitle,
  });
  final String title;
  final String value;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black87)),
        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(subtitle!, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500)),
        ],
      ]),
    );
  }
}


