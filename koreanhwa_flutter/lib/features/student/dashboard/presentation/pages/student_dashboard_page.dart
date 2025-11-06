import 'package:flutter/material.dart';
import 'package:koreanhwa_flutter/features/student/dashboard/presentation/widgets/streak_details_card.dart';
import 'package:koreanhwa_flutter/features/student/dashboard/presentation/widgets/recent_achievement_item.dart';
import 'package:koreanhwa_flutter/features/student/dashboard/presentation/widgets/leaderboard_card.dart';
import 'package:koreanhwa_flutter/features/student/dashboard/presentation/widgets/my_score_card.dart';
import 'package:koreanhwa_flutter/features/student/dashboard/presentation/widgets/course_card.dart';
// Mobile-first rewrite: all sections are simple cards stacked vertically.

class StudentDashboardPage extends StatelessWidget {
  const StudentDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Dashboard')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _headerCard(context),
              const SizedBox(height: 12),
              _levelPointsCard(),
              const SizedBox(height: 12),
              _levelProgressCard(),
              const SizedBox(height: 12),
              _streakCard(),
              const SizedBox(height: 12),
              _skillsProgressCard(),
              const SizedBox(height: 12),
              _dailyTasksCard(),
              const SizedBox(height: 12),
              const MyScoreCard(),
              const SizedBox(height: 12),
              const StreakDetailsCard(),
              const SizedBox(height: 12),
              _coursesSection(),
              const SizedBox(height: 12),
              _achievementsCard(),
              const SizedBox(height: 12),
              const LeaderboardCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerCard(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Xin chào!', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text('Tiếp tục hành trình học tiếng Hàn của bạn hôm nay', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _levelPointsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(gradient: const LinearGradient(colors: [Color(0xFF2563EB), Color(0xFF7C3AED)])),
      child: Row(
        children: [
          const Icon(Icons.school, color: Colors.white),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Cấp độ hiện tại • Trung cấp', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
              SizedBox(height: 6),
              Text('450 điểm', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _levelProgressCard() {
    // Mock theo React getProgressToNextLevel: 149/500 -> 30%
    const int current = 149;
    const int target = 500;
    final double percent = current / target; // 0.298 -> 30%
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(gradient: const LinearGradient(colors: [Color(0xFF22C55E), Color(0xFF0D9488)])),
      child: Row(
        children: [
          const Icon(Icons.trending_up, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Tiến độ cấp độ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('${(percent * 100).round()}%', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                Text('$current/$target điểm', style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
              ]),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: percent,
                  minHeight: 8,
                  backgroundColor: Colors.white24,
                  color: Colors.white,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _streakCard() {
    // Mock theo React: streak hiện tại 12 ngày, tổng 89 ngày
    const int streak = 12;
    const int totalDays = 89;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(gradient: const LinearGradient(colors: [Color(0xFFF97316), Color(0xFFDC2626)])),
      child: Row(
        children: [
          const Icon(Icons.local_fire_department, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Streak hiện tại', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text('$streak ngày', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 2),
              Text('Tổng: $totalDays ngày', style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _skillsProgressCard() {
    final items = const [
      ('Nghe', 0.75, Icons.headphones, 24, 30, 'up', 5, 'cyan'),
      ('Nói', 0.60, Icons.mic, 18, 25, 'up', 3, 'emerald'),
      ('Đọc', 0.85, Icons.menu_book, 32, 35, 'stable', 0, 'pink'),
      ('Viết', 0.45, Icons.edit, 12, 20, 'down', -2, 'red'),
    ];

    Color _getColorFromString(String colorStr) {
      switch (colorStr) {
        case 'cyan':
          return Colors.cyan;
        case 'emerald':
          return Colors.green;
        case 'pink':
          return Colors.pink;
        case 'red':
          return Colors.red;
        default:
          return const Color(0xFF3B82F6);
      }
    }

    Widget _getTrendIcon(String trend, int change) {
      switch (trend) {
        case 'up':
          return Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.arrow_upward, size: 16, color: Color(0xFF10B981)),
            const SizedBox(width: 2),
            Text('+$change%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF10B981))),
          ]);
        case 'down':
          return Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.arrow_downward, size: 16, color: Color(0xFFEF4444)),
            const SizedBox(width: 2),
            Text('$change%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFFEF4444))),
          ]);
        default: // stable
          return Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.remove, size: 16, color: Colors.grey),
            const SizedBox(width: 2),
            Text('$change%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.grey)),
          ]);
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Tiến độ học tập', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        ...items.map((e) {
          final progressColor = _getColorFromString(e.$8);
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Icon(e.$3, color: progressColor),
                const SizedBox(width: 10),
                SizedBox(width: 64, child: Text(e.$1, style: const TextStyle(fontWeight: FontWeight.w700))),
                const SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: e.$2,
                      minHeight: 10,
                      backgroundColor: const Color(0xFFF1F5F9),
                      color: progressColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Text('${(e.$2 * 100).round()}%', style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(width: 4),
                  _getTrendIcon(e.$6, e.$7),
                ]),
              ]),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.only(left: 34),
                child: Row(children: [
                  Text('${e.$4}h học', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  const SizedBox(width: 8),
                  Text('/ Mục tiêu: ${e.$5}%', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                ]),
              ),
            ]),
          );
        }),
      ]),
    );
  }

  Widget _dailyTasksCard() {
    final tasks = const [
      ('Học 20 từ vựng mới', true, 50, 'easy'),
      ('Luyện nghe 30 phút', true, 30, 'medium'),
      ('Làm bài tập ngữ pháp', false, 40, 'hard'),
      ('Viết 1 đoạn văn ngắn', false, 60, 'hard'),
    ];

    Color _difficultyBg(String d, bool filled) {
      switch (d) {
        case 'easy':
          return filled ? const Color(0xFFDCFCE7) : const Color(0xFFDCFCE7);
        case 'medium':
          return filled ? const Color(0xFFFEF9C3) : const Color(0xFFFEF9C3);
        default:
          return filled ? const Color(0xFFFEE2E2) : const Color(0xFFFEE2E2);
      }
    }

    Color _difficultyText(String d) {
      switch (d) {
        case 'easy':
          return const Color(0xFF166534);
        case 'medium':
          return const Color(0xFFA16207);
        default:
          return const Color(0xFF991B1B);
      }
    }

    String _difficultyLabel(String d) {
      switch (d) {
        case 'easy':
          return 'Dễ';
        case 'medium':
          return 'Trung bình';
        default:
          return 'Khó';
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Nhiệm vụ hôm nay', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        ...tasks.map((t) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: t.$2 ? const Color(0xFFF0FDF4) : Colors.white,
                border: Border.all(color: t.$2 ? const Color(0xFFBBF7D0) : Colors.grey.shade200),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(children: [
                Icon(t.$2 ? Icons.check_circle : Icons.schedule, color: t.$2 ? const Color(0xFF10B981) : Colors.grey),
                const SizedBox(width: 12),
                Expanded(child: Text(t.$1, style: TextStyle(fontWeight: t.$2 ? FontWeight.w700 : FontWeight.w500, color: Colors.black87))),
                const SizedBox(width: 8),
                // Difficulty chip
                Container(
                  margin: const EdgeInsets.only(right: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: _difficultyBg(t.$4, true), borderRadius: BorderRadius.circular(999)),
                  child: Text(_difficultyLabel(t.$4), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _difficultyText(t.$4))),
                ),
                // Points chip or Start button depending on completion
                if (t.$2)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFFE0F2FE), borderRadius: BorderRadius.circular(999)),
                    child: Text('+${t.$3} điểm', style: const TextStyle(color: Color(0xFF0369A1))),
                  )
                else
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {},
                    child: const Text('Bắt đầu', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                  ),
              ]),
            )),
      ]),
    );
  }

  Widget _achievementsCard() {
    final recentAchievements = const [
      (
        Icons.menu_book,
        'Hoàn thành 50 bài học',
        'Đã hoàn thành 50 bài học đầu tiên',
        100,
        '2024-01-15',
        Color(0xFFFB923C)
      ),
      (
        Icons.local_fire_department,
        'Streak 10 ngày',
        'Duy trì học tập 10 ngày liên tiếp',
        50,
        '2024-01-14',
        Color(0xFFF472B6)
      ),
      (
        Icons.center_focus_strong,
        'Thành thạo 100 từ vựng',
        'Học thuộc 100 từ vựng cơ bản',
        75,
        '2024-01-13',
        Color(0xFF22D3EE)
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Thành tích gần đây', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF047857))),
        const SizedBox(height: 12),
        ...recentAchievements.map((a) => RecentAchievementItem(
              icon: a.$1,
              title: a.$2,
              description: a.$3,
              points: a.$4,
              date: a.$5,
              color: a.$6,
            )),
      ]),
    );
  }

  Widget _coursesSection() {
    final courses = [
      {
        'color': Colors.blue,
        'date': '2025-09-01',
        'title': 'Bài 1: Chào hỏi cơ bản',
        'description': 'Học cách chào hỏi cơ bản trong tiếng Hàn',
        'progress': 75,
        'price': 15,
        'originalPrice': 20,
        'isFree': false,
        'pointsRequired': 15,
        'lessons': [
          {'title': 'Học bảng chữ cái', 'progress': 100, 'completedDate': '2025-09-02', 'pointsEarned': 10},
          {'title': 'Từ vựng chào hỏi', 'progress': 50, 'completedDate': null, 'pointsEarned': 0},
          {'title': 'Ngữ pháp cơ bản', 'progress': 75, 'completedDate': null, 'pointsEarned': 0},
        ],
      },
      {
        'color': Colors.green,
        'date': '2025-08-15',
        'title': 'Bài 2: Giới thiệu bản thân',
        'description': 'Học cách giới thiệu bản thân và người khác',
        'progress': 90,
        'price': 20,
        'originalPrice': 25,
        'isFree': false,
        'pointsRequired': 20,
        'lessons': [
          {'title': 'Từ vựng gia đình', 'progress': 100, 'completedDate': '2025-08-16', 'pointsEarned': 15},
          {'title': 'Ngữ pháp giới thiệu', 'progress': 100, 'completedDate': '2025-08-20', 'pointsEarned': 20},
          {'title': 'Luyện tập hội thoại', 'progress': 70, 'completedDate': null, 'pointsEarned': 0},
        ],
      },
      {
        'color': Colors.purple,
        'date': '2025-07-10',
        'title': 'Bài 3: Số đếm và thời gian',
        'description': 'Học cách đếm số và nói về thời gian',
        'progress': 60,
        'price': 0,
        'originalPrice': 0,
        'isFree': true,
        'pointsRequired': 0,
        'lessons': [
          {'title': 'Số đếm Hàn Quốc', 'progress': 100, 'completedDate': '2025-07-12', 'pointsEarned': 12},
          {'title': 'Cách nói thời gian', 'progress': 50, 'completedDate': null, 'pointsEarned': 0},
          {'title': 'Bài tập thực hành', 'progress': 30, 'completedDate': null, 'pointsEarned': 0},
        ],
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Các bài đã học', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF047857))),
        const SizedBox(height: 12),
        ...courses.map((c) => CourseCard(
              title: c['title'] as String,
              description: c['description'] as String,
              progress: c['progress'] as int,
              isFree: c['isFree'] as bool,
              price: c['price'] as int,
              originalPrice: c['originalPrice'] as int,
              pointsRequired: c['pointsRequired'] as int,
              lessons: (c['lessons'] as List).cast<Map<String, dynamic>>(),
              accentColor: c['color'] as Color,
            )),
      ]),
    );
  }

  BoxDecoration _cardDecoration({LinearGradient? gradient}) {
    return BoxDecoration(
      color: gradient == null ? Colors.white : null,
      gradient: gradient,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 16, offset: const Offset(0, 8))],
      border: gradient == null ? Border.all(color: Colors.grey.shade200) : null,
    );
  }
}
