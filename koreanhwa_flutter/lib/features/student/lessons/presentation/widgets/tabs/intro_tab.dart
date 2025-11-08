import 'package:flutter/material.dart';

class IntroTab extends StatelessWidget {
  const IntroTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final highlights = <String>[
      '45 bài giảng chi tiết với tổng thời lượng 90 ngày học',
      'Hơn 3,463 học viên đã đăng ký và đạt kết quả tốt',
      'Bài thi thử IBT MockTest chính thức',
      'Phương pháp học hiệu quả, tập trung vào từng kỹ năng',
      'Hỗ trợ học viên 24/7 trong suốt quá trình học',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Về khóa học này',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Khóa học COMBO Luyện Thi TOPIK II + IBT MockTest được thiết kế dành riêng cho những học viên muốn đạt điểm cao trong kỳ thi TOPIK II. Khóa học kết hợp giữa lý thuyết và thực hành với các bài thi thử IBT MockTest chính thức.',
          style: theme.textTheme.bodyMedium?.copyWith(
            height: 1.6,
            color: const Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Với sự hướng dẫn của giảng viên Ninh Thị Thúy - chuyên gia có nhiều năm kinh nghiệm trong việc giảng dạy tiếng Hàn, bạn sẽ được trang bị đầy đủ kiến thức và kỹ năng cần thiết để chinh phục kỳ thi TOPIK II.',
          style: theme.textTheme.bodyMedium?.copyWith(
            height: 1.6,
            color: const Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Điểm nổi bật của khóa học:',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              highlights
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Icon(
                              Icons.circle,
                              size: 6,
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              item,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFF4B5563),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
