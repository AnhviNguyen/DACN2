import 'package:flutter/material.dart';

import '../lesson_dashboard_data.dart';

class LessonCourseDetailList extends StatelessWidget {
  const LessonCourseDetailList({super.key, required this.courses});

  final List<LessonCourse> courses;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tổng quan khóa học',
          style: theme.textTheme.titleLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 16),
        ...courses.map(
          (course) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _LessonCourseDetailCard(course: course),
          ),
        ),
      ],
    );
  }
}

class _LessonCourseDetailCard extends StatelessWidget {
  const _LessonCourseDetailCard({required this.course});

  final LessonCourse course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusPalette = _statusColor(course.statusType);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFDE68A)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '#${course.id.toString().padLeft(2, '0')}',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: const Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      course.subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFCA8A04),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusPalette.background,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  course.statusLabel,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: statusPalette.foreground,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _infoTile('Số bài giảng', '${course.totalLessons}'),
              _infoTile('Bài đã hoàn thành', '${course.completedLessons}'),
              _infoTile('Tiến độ', '${course.progressPercent}%'),
              _infoTile('Thời gian học', course.duration),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  _StatusPalette _statusColor(LessonCourseStatusType type) {
    switch (type) {
      case LessonCourseStatusType.urgent:
        return const _StatusPalette(
          background: Color(0xFFFEE2E2),
          foreground: Color(0xFFB91C1C),
        );
      case LessonCourseStatusType.newCourse:
        return const _StatusPalette(
          background: Color(0xFFDBEAFE),
          foreground: Color(0xFF1D4ED8),
        );
      case LessonCourseStatusType.active:
      default:
        return const _StatusPalette(
          background: Color(0xFFD1FAE5),
          foreground: Color(0xFF047857),
        );
    }
  }
}

class _StatusPalette {
  const _StatusPalette({required this.background, required this.foreground});

  final Color background;
  final Color foreground;
}
