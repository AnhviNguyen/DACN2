import 'package:flutter/material.dart';

enum LessonCourseStatusType { active, newCourse, urgent }

class LessonSummaryStat {
  const LessonSummaryStat({
    required this.icon,
    required this.title,
    required this.total,
    required this.completed,
  });

  final IconData icon;
  final String title;
  final int total;
  final int completed;

  double get completionRate => total == 0 ? 0 : completed / total;
}

class LessonVideoSummary {
  const LessonVideoSummary({
    required this.icon,
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool highlight;
}

class LessonCourse {
  const LessonCourse({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.totalLessons,
    required this.completedLessons,
    required this.progressPercent,
    required this.duration,
    required this.statusLabel,
    required this.statusType,
  });

  final int id;
  final String title;
  final String subtitle;
  final int totalLessons;
  final int completedLessons;
  final int progressPercent;
  final String duration;
  final String statusLabel;
  final LessonCourseStatusType statusType;
}

class LessonCourseSectionData {
  const LessonCourseSectionData({
    required this.title,
    required this.actionLabel,
    required this.courses,
  });

  final String title;
  final String actionLabel;
  final List<LessonCourse> courses;
}

class LessonDashboardData {
  const LessonDashboardData._();

  static const headerTitle = 'Khóa học của tôi';
  static const dashboardNotice =
      'Dữ liệu dashboard có thể mất "1 ~ 2 phút" để tự động cập nhật những chỉ số mới nhất!';

  static const summaryStats = [
    LessonSummaryStat(
      icon: Icons.menu_book_rounded,
      title: 'Số khóa học đăng ký',
      total: 80,
      completed: 0,
    ),
    LessonSummaryStat(
      icon: Icons.play_circle_fill_rounded,
      title: 'Số video bài giảng',
      total: 2572,
      completed: 82,
    ),
    LessonSummaryStat(
      icon: Icons.assignment_turned_in_rounded,
      title: 'Số đề thi',
      total: 36,
      completed: 18,
    ),
  ];

  static const progressPercent = 3.2;

  static const videoSummaries = [
    LessonVideoSummary(
      icon: Icons.schedule_rounded,
      label: 'Tổng thời lượng video bài giảng',
      value: '737:23:52',
    ),
    LessonVideoSummary(
      icon: Icons.play_arrow_rounded,
      label: 'Tổng thời lượng video đã học',
      value: '56:26:54',
      highlight: true,
    ),
    LessonVideoSummary(
      icon: Icons.person_outline_rounded,
      label: 'Lần truy cập gần nhất',
      value: '2025-09-13 19:13:56',
    ),
    LessonVideoSummary(
      icon: Icons.event_available_rounded,
      label: 'Kết thúc khóa học cuối',
      value: '4762-07-11',
      highlight: true,
    ),
  ];

  static const ongoingCourses = [
    LessonCourse(
      id: 1,
      title: '[Gonggatm] Tiếng Hàn Sơ Cấp 2 (100 Bài Giảng)',
      subtitle: '(Sơ Cấp)',
      totalLessons: 100,
      completedLessons: 4,
      progressPercent: 4,
      duration: '2025-08-22 ~ 2026-03-20',
      statusLabel: 'Còn 189 ngày',
      statusType: LessonCourseStatusType.active,
    ),
    LessonCourse(
      id: 3,
      title: '[-30%] Tiếng Hàn Sơ Cấp 1 (100 Bài Giảng*)',
      subtitle: '(Mới)',
      totalLessons: 100,
      completedLessons: 7,
      progressPercent: 7,
      duration: '2025-08-22 ~ 2026-03-21',
      statusLabel: 'Còn 190 ngày',
      statusType: LessonCourseStatusType.active,
    ),
    LessonCourse(
      id: 4,
      title: '[NEW_Học thử MIỄN PHÍ] Bằng chữ cái tiếng Hàn (8 bài giảng)',
      subtitle: '(Sơ Cấp)',
      totalLessons: 8,
      completedLessons: 2,
      progressPercent: 21,
      duration: '2025-08-14 ~ 2025-09-22',
      statusLabel: 'Còn 10 ngày',
      statusType: LessonCourseStatusType.urgent,
    ),
  ];

  static const newCourses = [
    LessonCourse(
      id: 2,
      title: '[-30%] Tiếng Hàn Sơ Cấp 1 (100 Bài Giảng) - OFF',
      subtitle: '(Mới)',
      totalLessons: 100,
      completedLessons: 0,
      progressPercent: 0,
      duration: '2025-06-25 ~ 2030-12-16',
      statusLabel: 'Còn 1.943 ngày',
      statusType: LessonCourseStatusType.newCourse,
    ),
  ];

  static const completedCourses = [
    LessonCourse(
      id: 6,
      title: 'Luyện Thi TOPIK I - Tổng hợp 200 câu hỏi',
      subtitle: '(Đã hoàn thành)',
      totalLessons: 60,
      completedLessons: 60,
      progressPercent: 100,
      duration: 'Hoàn thành ngày 2025-08-01',
      statusLabel: 'Đã hoàn thành',
      statusType: LessonCourseStatusType.active,
    ),
    LessonCourse(
      id: 7,
      title: 'Giao Tiếp Thực Tế - Chủ đề hàng ngày',
      subtitle: '(Đã hoàn thành)',
      totalLessons: 40,
      completedLessons: 40,
      progressPercent: 100,
      duration: 'Hoàn thành ngày 2025-07-15',
      statusLabel: 'Đã hoàn thành',
      statusType: LessonCourseStatusType.active,
    ),
  ];

  static const interestCourses = [
    LessonCourse(
      id: 5,
      title: 'TOPIK II Chuyên sâu (Phần Nghe & Đọc)',
      subtitle: '(Quan tâm)',
      totalLessons: 120,
      completedLessons: 0,
      progressPercent: 0,
      duration: 'Dự kiến: 2025-11-01',
      statusLabel: 'Thử ngay',
      statusType: LessonCourseStatusType.newCourse,
    ),
  ];

  static const courseSections = [
    LessonCourseSectionData(
      title: 'Khóa học đang học',
      actionLabel: 'Xem thêm khóa học',
      courses: ongoingCourses,
    ),
    LessonCourseSectionData(
      title: 'Khóa học đã học',
      actionLabel: 'Xem thêm khóa học',
      courses: completedCourses,
    ),
    LessonCourseSectionData(
      title: 'Khóa học quan tâm',
      actionLabel: 'Khám phá thêm',
      courses: interestCourses,
    ),
  ];

  static List<LessonCourse> get detailedCourses => [
    ...ongoingCourses,
    ...completedCourses,
    ...newCourses,
  ];
}
