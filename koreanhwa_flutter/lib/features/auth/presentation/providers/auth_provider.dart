import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:koreanhwa_flutter/features/auth/models/user.dart';
import 'package:koreanhwa_flutter/shared/utils/api_client.dart';
import 'package:koreanhwa_flutter/shared/utils/local_storage_service.dart';
import 'dart:convert';

enum AuthState { initial, loading, authenticated, unauthenticated, error }

class AuthStatus {
  final AuthState status;
  final User? currentUser;
  final String? errorMessage;

  const AuthStatus({
    required this.status,
    this.currentUser,
    this.errorMessage,
  });

  AuthStatus copyWith({AuthState? status, User? currentUser, String? errorMessage}) {
    return AuthStatus(
      status: status ?? this.status,
      currentUser: currentUser ?? this.currentUser,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AuthNotifier extends Notifier<AuthStatus> {
  @override
  AuthStatus build() => const AuthStatus(status: AuthState.initial);

  String? get errorMessage => state.errorMessage;
  User? get currentUser => state.currentUser;

  Future<void> login(String email, String password) async {
    state = state.copyWith(status: AuthState.loading, errorMessage: null);

    final Dio dio = ref.read(dioProvider);
    final LocalStorageService storage = ref.read(localStorageServiceProvider);

    try {
      await storage.init();
      final Response<dynamic> response = await dio.post('/auth/login', data: <String, dynamic>{
        'email': email,
        'password': password,
      });
      final dynamic data = response.data;
      final String token = (data is Map && data['token'] is String) ? data['token'] as String : '';
      if (token.isEmpty) {
        throw Exception('Token không hợp lệ');
      }
      await storage.saveToken(token);
      if (data is Map && data['user'] is Map<String, dynamic>) {
        final user = User.fromJson(Map<String, dynamic>.from(data['user'] as Map));
        await storage.saveUser(jsonEncode(user.toJson()));
        state = state.copyWith(status: AuthState.authenticated, currentUser: user);
      } else {
        state = state.copyWith(status: AuthState.authenticated);
      }
    } catch (e) {
      state = state.copyWith(status: AuthState.error, errorMessage: e.toString());
    }
  }

  Future<void> register(String email, String password) async {
    state = state.copyWith(status: AuthState.loading, errorMessage: null);

    final Dio dio = ref.read(dioProvider);
    final LocalStorageService storage = ref.read(localStorageServiceProvider);

    try {
      await storage.init();
      final Response<dynamic> response = await dio.post('/auth/register', data: <String, dynamic>{
        'email': email,
        'password': password,
      });
      final dynamic data = response.data;
      final String token = (data is Map && data['token'] is String) ? data['token'] as String : '';
      if (token.isEmpty) {
        // Nếu API register không trả token, đánh dấu unauthenticated để buộc login
        state = state.copyWith(status: AuthState.unauthenticated);
        return;
      }
      await storage.saveToken(token);
      if (data is Map && data['user'] is Map<String, dynamic>) {
        final user = User.fromJson(Map<String, dynamic>.from(data['user'] as Map));
        await storage.saveUser(jsonEncode(user.toJson()));
        state = state.copyWith(currentUser: user);
      }
      state = state.copyWith(status: AuthState.authenticated);
    } catch (e) {
      state = state.copyWith(status: AuthState.error, errorMessage: e.toString());
    }
  }

  Future<void> logout() async {
    final LocalStorageService storage = ref.read(localStorageServiceProvider);
    await storage.deleteToken();
    state = state.copyWith(status: AuthState.unauthenticated, currentUser: null);
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthStatus>(AuthNotifier.new);

 


