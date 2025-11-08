import 'package:flutter/material.dart';

// Model class cho lesson item - sẽ được map từ API response
class LessonItem {
  const LessonItem({
    required this.id,
    required this.title,
    required this.duration,
    required this.isStudied,
    this.isCurrent = false,
    this.isUnlocked = true,
  });

  final int id;
  final String title;
  final String duration; // e.g., "45 phút"
  final bool isStudied;
  final bool isCurrent; // Bài học hiện tại đang học
  final bool isUnlocked; // Đã mở khóa chưa

  LessonItem copyWith({
    int? id,
    String? title,
    String? duration,
    bool? isStudied,
    bool? isCurrent,
    bool? isUnlocked,
  }) {
    return LessonItem(
      id: id ?? this.id,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      isStudied: isStudied ?? this.isStudied,
      isCurrent: isCurrent ?? this.isCurrent,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }
}

class LearningSidebar extends StatelessWidget {
  const LearningSidebar({
    super.key,
    this.currentLesson,
    this.onLessonSelected,
  });

  final LessonItem? currentLesson;
  final ValueChanged<LessonItem>? onLessonSelected;

  // Mock data - sẽ được thay thế bằng data từ API/provider sau
  // TODO: Thay thế bằng FutureProvider hoặc StateNotifierProvider khi có API
  static const _lessons = [
    LessonItem(
      id: 1,
      title: "Bài 1: Chào hỏi cơ bản",
      duration: "45 phút",
      isStudied: true,
      isCurrent: true,
      isUnlocked: true,
    ),
    LessonItem(
      id: 2,
      title: "Bài 2: Giới thiệu bản thân",
      duration: "45 phút",
      isStudied: true,
      isCurrent: false,
      isUnlocked: true,
    ),
    LessonItem(
      id: 3,
      title: "Bài 3: Số đếm cơ bản",
      duration: "50 phút",
      isStudied: false,
      isCurrent: false,
      isUnlocked: true,
    ),
    LessonItem(
      id: 4,
      title: "Bài 4: Thời gian",
      duration: "40 phút",
      isStudied: false,
      isCurrent: false,
      isUnlocked: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Header with close button (for drawer)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Danh sách bài học',
                  style: theme.textTheme.headlineMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),

          // Lesson List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _lessons.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final lesson = _lessons[index];
                final isCurrent = currentLesson?.id == lesson.id;
                return GestureDetector(
                  onTap: () => onLessonSelected?.call(lesson),
                  child: _buildLessonItem(
                    context,
                    lesson.copyWith(isCurrent: isCurrent),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonItem(BuildContext context, LessonItem lesson) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: lesson.isCurrent
            ? colorScheme.secondary
            : Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: lesson.isCurrent
              ? colorScheme.primary
              : Colors.grey.shade300,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  lesson.title,
                  style: theme.textTheme.headlineSmall,
                  softWrap: true,
                ),
                const SizedBox(height: 4),
                Text(
                  lesson.duration,
                  style: theme.textTheme.titleMedium,
                  softWrap: true,
                ),
              ],
            ),
          ),
          if (lesson.isStudied)
            Icon(
              Icons.check_circle_outline_rounded,
              size: 16,
              color: colorScheme.primary,
            ),
        ],
      ),
    );
  }
}
