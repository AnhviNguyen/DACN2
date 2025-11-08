import 'package:flutter/material.dart';

import '../lesson_dashboard_data.dart';
import '../widgets/lesson_course_detail_list.dart';
import '../widgets/lesson_course_section.dart';
import '../widgets/lesson_dashboard_header.dart';
import '../widgets/lesson_notice_card.dart';
import '../widgets/lesson_progress_ring.dart';
import '../widgets/lesson_summary_stats_section.dart';
import '../widgets/lesson_video_summary_section.dart';

class LessonDashboardPage extends StatelessWidget {
  const LessonDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFFBEB), Color(0xFFFEF3C7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LessonDashboardHeader(
                  title: LessonDashboardData.headerTitle,
                ),
                const SizedBox(height: 16),
                const LessonNoticeCard(
                  message: LessonDashboardData.dashboardNotice,
                ),
                const SizedBox(height: 24),
                LessonSummaryStatsSection(
                  stats: LessonDashboardData.summaryStats,
                ),
                const SizedBox(height: 24),
                LessonProgressRing(
                  percent: LessonDashboardData.progressPercent,
                ),
                const SizedBox(height: 24),
                const LessonVideoSummarySection(
                  items: LessonDashboardData.videoSummaries,
                ),
                const SizedBox(height: 32),
                ...LessonDashboardData.courseSections.map(
                  (section) => Padding(
                    padding: const EdgeInsets.only(bottom: 28),
                    child: LessonCourseSection(section: section),
                  ),
                ),
                const SizedBox(height: 12),
                LessonCourseDetailList(
                  courses: LessonDashboardData.detailedCourses,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
