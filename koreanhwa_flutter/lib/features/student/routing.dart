import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koreanhwa_flutter/features/student/dashboard/presentation/pages/student_dashboard_page.dart';
import 'package:koreanhwa_flutter/features/student/lessons/classroom/presentation/pages/lesson_classroom_page.dart';
import 'package:koreanhwa_flutter/features/student/lessons/dashboard/presentation/pages/lesson_dashboard_page.dart';
import 'package:koreanhwa_flutter/features/student/lessons/info/presentation/pages/lesson_info_page.dart';
import 'package:koreanhwa_flutter/features/student/lessons/learning/presentation/pages/lesson_learning_page.dart';
import 'package:koreanhwa_flutter/features/student/roadmap/overview/presentation/pages/my_roadmap_page.dart';
import 'package:koreanhwa_flutter/features/student/topik/test_form/presentation/pages/test_form_page.dart';


final List<RouteBase> studentRoutes = <RouteBase>[
  GoRoute(
    path: '/student-dashboard',
    name: 'student-dashboard',
    pageBuilder:
        (context, state) => const MaterialPage(child: StudentDashboardPage()),
  ),
  GoRoute(
    path: '/my-roadmap',
    name: 'my-roadmap',
    pageBuilder:
        (context, state) => const MaterialPage(child: MyRoadmapPage()),
  ),
  GoRoute(
    path: '/lessons',
    name: 'lesson-dashboard',
    pageBuilder:
        (context, state) => const MaterialPage(child: LessonDashboardPage()),
  ),
  GoRoute(
    path: '/lesson-info',
    name: 'lesson-info',
    pageBuilder:
        (context, state) => const MaterialPage(child: LessonInfoPage()),
  ),
  GoRoute(
    path: '/lesson-classroom',
    name: 'lesson-classroom',
    pageBuilder:
        (context, state) => const MaterialPage(child: LessonClassroomPage()),
  ),
  GoRoute(
    path: '/lesson-learning',
    name: 'lesson-learning',
    pageBuilder:
        (context, state) => const MaterialPage(child: LessonLearningPage()),
  ),
  GoRoute(
    path: '/test-form',
    name: 'test-form',
    pageBuilder:
        (context, state) => const MaterialPage(child: TestFormPage()),
  ),
];
