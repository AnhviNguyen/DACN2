import 'package:flutter/material.dart';

class ClassroomHeader extends StatelessWidget {
  const ClassroomHeader({super.key});

  // Mock data - sẽ được thay thế bằng data từ API/provider sau
  static const _courseTitle = '[-24%] COMBO Khóa Luyện Thi TOPIK II + IBT MockTest';
  static const _progress = 4;
  static const _studyPeriod = '2025-06-25 ~ 2025-09-23 (90 Ngày)';
  static const _reviewPeriod = '+10 Ngày';
  static const _totalDuration = '144:1:32';
  static const _completedLessons = '1/46';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tên khóa học
          Text(
            _courseTitle,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 16),
          // Button "Xoá lịch sử học tập"
          ElevatedButton(
            onPressed: () {
              // TODO: Implement clear history
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber.shade500,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Xoá lịch sử học tập',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Thông tin thời gian và tiến độ
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cột trái: Thời gian học
              Text(
                'Thời gian học: $_studyPeriod',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Thời gian ôn tập: $_reviewPeriod',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tổng thời gian bài giảng: $_totalDuration',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 16),
              // Cột phải: Tiến độ
              Row(
                children: [
                  Text(
                    'Bài học hoàn thành: $_completedLessons',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Tiến độ: $_progress%',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: _progress / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade500,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


