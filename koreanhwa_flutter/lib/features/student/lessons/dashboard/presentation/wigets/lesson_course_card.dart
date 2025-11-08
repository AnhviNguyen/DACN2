import 'package:flutter/material.dart';

import '../lesson_dashboard_data.dart';

class LessonCourseCard extends StatelessWidget {
  const LessonCourseCard({super.key, required this.course});

  final LessonCourse course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColors = _statusColor(course.statusType);
    final progress = (course.progressPercent / 100).clamp(0.0, 1.0);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header: gradient preview + badges + favorite
          Container(
            height: 96,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              gradient: LinearGradient(
                colors: [Color(0xFF60A5FA), Color(0xFFA78BFA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                // COMBO / tag (suy luận đơn giản từ title/subtitle)
                Positioned(
                  top: 8,
                  left: 8,
                  child: _maybeBadge(
                    theme,
                    label: course.title.contains('COMBO') ? 'COMBO' : null,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(
                        Icons.favorite_border_rounded,
                        size: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                // Preview icon center
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.menu_book_rounded,
                        color: Colors.white70,
                        size: 28,
                      ),
                      Text(
                        'Preview',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Subtitle (thay cho instructor)
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline_rounded,
                      size: 14,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        course.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Title
                Text(
                  course.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 6),
                // Registration period label + value (dựa vào duration)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thời gian:',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  course.duration,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                // Stats row (lessons and duration as chip)
                Row(
                  children: [
                    if (course.totalLessons > 0)
                      Row(
                        children: [
                          const Icon(
                            Icons.menu_book_rounded,
                            size: 14,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${course.totalLessons} Bài',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 10),
                // Progress
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tiến độ ${course.progressPercent}%',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        minHeight: 6,
                        value: progress,
                        backgroundColor: const Color(0xFFE5E7EB),
                        valueColor: const AlwaysStoppedAnimation(
                          Color(0xFFFACC15),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Footer: status chip + action button
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColors.background,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        course.statusLabel,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: statusColors.foreground,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFACC15),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: const Text('Vào học'),
                    ),
                  ],
                ),
              ],
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

  Widget _infoChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF1F2937),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _maybeBadge(ThemeData theme, {String? label}) {
    if (label == null || label.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFACC15),
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _StatusPalette {
  const _StatusPalette({required this.background, required this.foreground});

  final Color background;
  final Color foreground;
}
