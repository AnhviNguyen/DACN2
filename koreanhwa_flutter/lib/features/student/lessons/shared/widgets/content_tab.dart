import 'package:flutter/material.dart';

class LessonContentItem {
  const LessonContentItem({
    required this.title,
    required this.duration,
    required this.isUnlocked,
    required this.isCompleted,
  });

  final String title;
  final String duration;
  final bool isUnlocked;
  final bool isCompleted;
}

class ContentTab extends StatelessWidget {
  const ContentTab({super.key});

  // Mock data - sẽ được thay thế bằng data từ API/provider sau
  static const _courseContent = [
    LessonContentItem(
      title: "Giới thiệu khóa học",
      duration: "00:02:26",
      isUnlocked: true,
      isCompleted: false,
    ),
    LessonContentItem(
      title: "[Bài 1 - Phần đọc] Chọn ngữ pháp đúng điền vào ô trống [1~2]",
      duration: "00:18:04",
      isUnlocked: true,
      isCompleted: false,
    ),
    LessonContentItem(
      title: "[Bài 2 - Phần đọc] Chọn ngữ pháp có nghĩa tương tự [3~4]",
      duration: "00:15:18",
      isUnlocked: true,
      isCompleted: false,
    ),
    LessonContentItem(
      title: "[Bài 3 - Phần đọc] Hiểu nội dung đoạn văn ngắn [5~8]",
      duration: "00:22:45",
      isUnlocked: false,
      isCompleted: false,
    ),
    LessonContentItem(
      title: "[Bài 4 - Phần đọc] Đọc hiểu đoạn văn dài [9~12]",
      duration: "00:28:30",
      isUnlocked: false,
      isCompleted: false,
    ),
    LessonContentItem(
      title: "[Bài 5 - Phần nghe] Nghe hiểu nội dung cơ bản [13~16]",
      duration: "00:25:15",
      isUnlocked: false,
      isCompleted: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ..._courseContent.map((lesson) => _buildLessonItem(context, lesson)),
      ],
    );
  }

  Widget _buildLessonItem(BuildContext context, LessonContentItem lesson) {
    final theme = Theme.of(context);
    
    // Xác định màu và icon cho status circle
    Color statusColor;
    IconData statusIcon;
    Color iconColor;
    
    if (lesson.isCompleted) {
      statusColor = Colors.green.shade500;
      statusIcon = Icons.check_circle_outline_rounded;
      iconColor = Colors.white;
    } else if (lesson.isUnlocked) {
      statusColor = Colors.amber.shade400;
      statusIcon = Icons.play_arrow;
      iconColor = Colors.black;
    } else {
      statusColor = Colors.grey.shade300;
      statusIcon = Icons.lock;
      iconColor = Colors.grey.shade600;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFFDE68A), // border-yellow-200
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Status circle với icon
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                statusIcon,
                size: lesson.isCompleted ? 20 : 16,
                color: iconColor,
              ),
            ),
            const SizedBox(width: 16),
            // Title - flexible để chiếm không gian còn lại
            Expanded(
              child: Text(
                lesson.title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            // Duration và unlock indicator
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 4),
                Text(
                  lesson.duration,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                if (lesson.isUnlocked) ...[
                  const SizedBox(width: 8),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.green.shade500,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}



