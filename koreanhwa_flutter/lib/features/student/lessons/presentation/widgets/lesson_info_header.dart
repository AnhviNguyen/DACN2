import 'package:flutter/material.dart';

class LessonInfoHeader extends StatelessWidget {
  const LessonInfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const yellow = Color(0xFFFACC15); // Tailwind yellow-400ish

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: badge + icons (BookOpen, FileText)
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: yellow.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'COMBO',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(Icons.menu_book_rounded, color: Colors.white70, size: 20),
              const SizedBox(width: 12),
              const Icon(Icons.article_rounded, color: Colors.white70, size: 20),
            ],
          ),
          const SizedBox(height: 14),
          // Title
          Text(
            'COMBO Khóa Luyện Thi TOPIK II + IBT MockTest',
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          // Instructor
          Row(
            children: [
              const Icon(Icons.person_outline_rounded, color: Colors.white70, size: 18),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  'Giảng viên: Ninh Thị Thúy',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Accent divider
          Container(
            height: 4,
            width: 80,
            decoration: BoxDecoration(
              color: yellow,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}

