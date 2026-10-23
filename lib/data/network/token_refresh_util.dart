import 'package:dio/dio.dart';
import 'package:flutter_bloc_clean_architecture/data/network/constants/api_endpoints_constant.dart';
import 'package:flutter_bloc_clean_architecture/common/constants/configs_constant.dart';
import 'package:flutter_bloc_clean_architecture/common/enums/grant_type_enum.dart';
import 'package:flutter_bloc_clean_architecture/common/services/storage/auth_storage_service.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/auth/auth_session.dart';

enum TokenRefreshResult {
  /// New tokens were stored.
  success,

  /// The refresh token is missing or rejected: the user must sign in again.
  invalidSession,

  /// The refresh call itself failed (network, timeout, 5xx): keep the session.
  failed,
}

/// Refreshes the access token using a dedicated Dio instance
/// (no auth interceptor, to avoid refresh loops).
class TokenRefreshUtil {
  final AuthStorageService authStorageService;
  final Dio _dio;

  TokenRefreshUtil({
    required String baseUrl,
    required this.authStorageService,
    Dio? dio,
  }) : _dio = dio ?? Dio(BaseOptions(baseUrl: baseUrl));

  Future<TokenRefreshResult> refreshToken() async {
    final session = await authStorageService.getSession();
    final refreshToken = session?.refreshToken;
    if (session == null || refreshToken == null || refreshToken.isEmpty) {
      return TokenRefreshResult.invalidSession;
    }

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpointsConstant.refreshToken,
        data: {
          'grantType': GrantTypeEnum.refreshToken.key,
          'refreshToken': refreshToken,
          'clientId': ConfigsConstant.clientId,
        },
      );
      final data = response.data;
      final accessToken = data?['accessToken'] as String?;
      if (accessToken == null || accessToken.isEmpty) {
        return TokenRefreshResult.invalidSession;
      }

      await authStorageService.saveSession(
        AuthSession(
          accessToken: accessToken,
          refreshToken: data?['refreshToken'] as String? ?? refreshToken,
          tokenType: data?['tokenType'] as String? ?? session.tokenType,
          expiresIn: data?['expiresIn'] as int?,
        ),
      );
      return TokenRefreshResult.success;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final isRejected = statusCode == 400 || statusCode == 401;
      return isRejected
          ? TokenRefreshResult.invalidSession
          : TokenRefreshResult.failed;
    }
  }
}
