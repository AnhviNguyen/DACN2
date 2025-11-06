import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Base configuration for Dio
final BaseOptions _baseOptions = BaseOptions(
  baseUrl: 'https://api.your-domain.com/api/v1', // placeholder, update per environment
  connectTimeout: const Duration(seconds: 15),
  receiveTimeout: const Duration(seconds: 30),
  sendTimeout: const Duration(seconds: 30),
  headers: <String, dynamic>{
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
);

Dio _createDio() {
  final dio = Dio(_baseOptions);

  // Add logging only in debug mode
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: false,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ),
    );
  }

  return dio;
}

// Riverpod provider for Dio instance
final dioProvider = Provider<Dio>((ref) {
  return _createDio();
});
