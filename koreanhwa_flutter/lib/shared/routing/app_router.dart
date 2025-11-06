import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:koreanhwa_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:koreanhwa_flutter/features/auth/presentation/pages/register_page.dart';
import 'package:koreanhwa_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:koreanhwa_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:koreanhwa_flutter/features/home/presentation/pages/home_page.dart';
import 'package:koreanhwa_flutter/features/student/routing.dart';
import 'package:koreanhwa_flutter/features/admin/routing.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/student-dashboard',
    /*redirect: (context, state) {
      final authStatus = ref.read(authProvider);
      final path = state.uri.path;

      if (authStatus.status == AuthState.unauthenticated || authStatus.status == AuthState.initial) {
        if (path != '/login' && path != '/register') return '/login';
        return null;
      }

      if (authStatus.status == AuthState.authenticated && (path == '/' || path == '/login' || path == '/register')) {
        final user = authStatus.currentUser;
        if (user != null) {
          if (user.role == 'admin') return '/admin-dashboard';
          return '/student-dashboard';
        }
      }

      return null;
    },*/
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) => const MaterialPage(child: HomePage()),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        pageBuilder: (context, state) => const MaterialPage(child: DashboardPage()),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        pageBuilder: (context, state) => const MaterialPage(child: RegisterPage()),
      ),
      ...studentRoutes,
      ...adminRoutes,
    ],
  );
});
