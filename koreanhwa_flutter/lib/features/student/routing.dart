import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koreanhwa_flutter/features/student/dashboard/presentation/pages/student_dashboard_page.dart';

final List<RouteBase> studentRoutes = <RouteBase>[
  GoRoute(
    path: '/student-dashboard',
    name: 'student-dashboard',
    pageBuilder: (context, state) => const MaterialPage(child: StudentDashboardPage()),
  ),
];


