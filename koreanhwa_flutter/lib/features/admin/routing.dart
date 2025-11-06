import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koreanhwa_flutter/features/admin/dashboard/presentation/pages/admin_dashboard_page.dart';
import 'package:koreanhwa_flutter/features/student/dashboard/presentation/pages/student_dashboard_page.dart';

final List<RouteBase> adminRoutes = <RouteBase>[
  GoRoute(
    path: '/admin-dashboard',
    name: 'admin-dashboard',
    pageBuilder: (context, state) => const MaterialPage(child: StudentDashboardPage()),
  ),
];


