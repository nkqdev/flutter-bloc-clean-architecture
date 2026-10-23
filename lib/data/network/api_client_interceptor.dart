import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc_clean_architecture/data/network/constants/api_version_constant.dart';
import 'package:flutter_bloc_clean_architecture/data/network/constants/request_extra_constant.dart';
import 'package:flutter_bloc_clean_architecture/data/network/constants/request_headers_constant.dart';
import 'package:flutter_bloc_clean_architecture/data/network/token_refresh_util.dart';
import 'package:flutter_bloc_clean_architecture/common/services/event_bus/app_events.dart';
import 'package:flutter_bloc_clean_architecture/common/services/event_bus/event_bus_service.dart';
import 'package:flutter_bloc_clean_architecture/common/services/storage/auth_storage_service.dart';
import 'package:flutter_bloc_clean_architecture/common/services/storage/locale_storage_service.dart';

/// Attaches common headers + bearer token and transparently refreshes the
/// token on 401.
///
/// Concurrent 401s share a single refresh call (single-flight); requests that
/// failed with an already-rotated token are replayed without refreshing again.
class ApiClientInterceptor extends Interceptor {
  final Dio dio;
  final AuthStorageService authStorageService;
  final TokenRefreshUtil tokenRefreshUtil;

  ApiClientInterceptor({
    required this.dio,
    required this.authStorageService,
    required this.tokenRefreshUtil,
  });

  Future<TokenRefreshResult>? _ongoingRefresh;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.putIfAbsent(
      RequestHeadersConstant.X_API_VERSION,
      () => ApiVersionConstant.v1_0,
    );
    options.headers[RequestHeadersConstant.ACCEPT_LANGUAGE] =
        LocaleStorageService.locale;

    final session = await authStorageService.getSession();
    if (session != null && session.accessToken.isNotEmpty) {
      options.headers[RequestHeadersConstant.AUTHORIZATION] =
          session.authorizationHeader;
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final shouldRefresh =
        err.response?.statusCode == 401 &&
        options.extra[RequestExtraConstant.skipAuthRefresh] != true &&
        options.extra[RequestExtraConstant.isRetried] != true;

    if (!shouldRefresh) return handler.next(err);

    final currentSession = await authStorageService.getSession();
    // Signed out (or the session was just invalidated): nothing to refresh.
    if (currentSession == null) return handler.next(err);

    final sentToken = options.headers[RequestHeadersConstant.AUTHORIZATION];
    final tokenAlreadyRotated = currentSession.authorizationHeader != sentToken;

    if (!tokenAlreadyRotated) {
      final result = await _refreshOnce();
      if (result != TokenRefreshResult.success) return handler.next(err);
    }

    try {
      options.extra[RequestExtraConstant.isRetried] = true;
      handler.resolve(await dio.fetch(options));
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  /// Runs at most one refresh at a time; concurrent callers await the same one.
  Future<TokenRefreshResult> _refreshOnce() {
    return _ongoingRefresh ??= _refresh().whenComplete(
      () => _ongoingRefresh = null,
    );
  }

  Future<TokenRefreshResult> _refresh() async {
    final result = await tokenRefreshUtil.refreshToken();
    if (result == TokenRefreshResult.invalidSession) {
      await authStorageService.deleteSession();
      EventBusService.instance.fire(const SessionExpiredEvent());
    }
    return result;
  }
}
