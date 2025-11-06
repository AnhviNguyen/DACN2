import 'package:hive/hive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalStorageService {
  static const String _authBoxName = 'authBox';
  static const String _tokenKey = 'token';
  static const String _userKey = 'user';

  Box<dynamic>? _authBox;

  Future<void> init() async {
    _authBox ??= await Hive.openBox<dynamic>(_authBoxName);
  }

  Future<void> saveToken(String token) async {
    final box = _authBox ?? await Hive.openBox<dynamic>(_authBoxName);
    await box.put(_tokenKey, token);
  }

  String? getToken() {
    final box = _authBox;
    if (box == null) return null;
    return box.get(_tokenKey) as String?;
  }

  Future<void> deleteToken() async {
    final box = _authBox ?? await Hive.openBox<dynamic>(_authBoxName);
    await box.delete(_tokenKey);
  }

  Future<void> saveUser(String userJson) async {
    final box = _authBox ?? await Hive.openBox<dynamic>(_authBoxName);
    await box.put(_userKey, userJson);
  }

  String? getUser() {
    final box = _authBox;
    if (box == null) return null;
    final dynamic val = box.get(_userKey);
    return val is String ? val : null;
  }
}

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});


