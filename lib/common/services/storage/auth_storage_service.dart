import 'dart:convert';

import 'package:flutter_bloc_clean_architecture/common/constants/storage_key_constant.dart';
import 'package:flutter_bloc_clean_architecture/common/services/logging/app_logger.dart';
import 'package:flutter_bloc_clean_architecture/common/services/storage/base_storage_service.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/auth/auth_session.dart';

/// Persists the auth session in secure storage and keeps an in-memory copy,
/// so reading the token on every request does not hit secure storage.
class AuthStorageService extends BaseStorageService {
  AuthSession? _cachedSession;
  bool _isLoaded = false;

  Future<AuthSession?> getSession() async {
    if (_isLoaded) return _cachedSession;

    try {
      final value = await storage.read(key: StorageKeyConstant.AUTH_INFO);
      _cachedSession = value == null ? null : _decode(value);
    } catch (e) {
      AppLogger.warning('Failed to read auth session', e);
      _cachedSession = null;
    }
    _isLoaded = true;
    return _cachedSession;
  }

  Future<void> saveSession(AuthSession session) async {
    _cachedSession = session;
    _isLoaded = true;
    try {
      await storage.write(
        key: StorageKeyConstant.AUTH_INFO,
        value: jsonEncode({
          'accessToken': session.accessToken,
          'refreshToken': session.refreshToken,
          'tokenType': session.tokenType,
          'expiresIn': session.expiresIn,
        }),
      );
    } catch (e) {
      AppLogger.warning('Failed to save auth session', e);
    }
  }

  Future<void> deleteSession() async {
    _cachedSession = null;
    _isLoaded = true;
    try {
      await storage.delete(key: StorageKeyConstant.AUTH_INFO);
    } catch (e) {
      AppLogger.warning('Failed to delete auth session', e);
    }
  }

  AuthSession _decode(String value) {
    final json = jsonDecode(value) as Map<String, dynamic>;
    return AuthSession(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String?,
      tokenType: json['tokenType'] as String? ?? 'Bearer',
      expiresIn: json['expiresIn'] as int?,
    );
  }
}
