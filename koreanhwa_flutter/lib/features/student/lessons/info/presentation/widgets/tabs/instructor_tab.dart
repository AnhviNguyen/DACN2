import 'package:flutter/material.dart';

class InstructorTab extends StatelessWidget {
  const InstructorTab({super.key});

  // Mock data - sẽ được thay thế bằng data từ API/provider sau
  static const _instructorName = 'Ninh Thị Thúy';
  static const _instructorTitle = 'Giảng viên chuyên môn TOPIK';
  static const _instructorDescription =
      'Cô Ninh Thị Thúy là giảng viên có hơn 8 năm kinh nghiệm trong việc giảng dạy tiếng Hàn và luyện thi TOPIK. '
      'Cô đã giúp hàng nghìn học viên đạt điểm cao trong kỳ thi TOPIK II.';
  static const _achievements = [
    'Thạc sĩ Ngôn ngữ Hàn Quốc - Đại học Quốc gia Seoul',
    'Chứng chỉ giảng dạy tiếng Hàn cho người nước ngoài',
    'Tác giả của 5 cuốn sách luyện thi TOPIK bestseller',
    '95% học viên đạt điểm mục tiêu sau khóa học',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          // Header với avatar và thông tin
          Row(
            children: [
              // Avatar circle
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.amber.shade400, // bg-yellow-400
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  size: 32,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 16),
              // Tên và chức danh
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _instructorName,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _instructorTitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Mô tả
          Text(
            _instructorDescription,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade700,
              height: 1.6, // leading-relaxed
            ),
          ),
          const SizedBox(height: 16),
          // Tiêu đề thành tích
          Text(
            'Thành tích nổi bật:',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          // Danh sách thành tích
          ..._achievements.map((achievement) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6, right: 12),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        achievement,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
      ],
    );
  }
}



