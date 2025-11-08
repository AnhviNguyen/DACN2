import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koreanhwa_flutter/features/student/dashboard/presentation/pages/student_dashboard_page.dart';
import 'package:koreanhwa_flutter/features/student/lessons/presentation/pages/lesson_dashboard_page.dart';
import 'package:koreanhwa_flutter/features/student/lessons/presentation/pages/lesson_info_page.dart';


final List<RouteBase> studentRoutes = <RouteBase>[
  GoRoute(
    path: '/student-dashboard',
    name: 'student-dashboard',
    pageBuilder:
        (context, state) => const MaterialPage(child: StudentDashboardPage()),
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
];
