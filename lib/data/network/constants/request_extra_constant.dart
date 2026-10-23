/// Keys stored in `RequestOptions.extra` to drive interceptor behaviour.
class RequestExtraConstant {
  /// Set on auth endpoints (login, refresh, logout): a 401 there must not
  /// trigger a token refresh.
  static const String skipAuthRefresh = 'skip_auth_refresh';

  /// Set on a request replayed after a successful refresh.
  static const String isRetried = 'is_retried';
}
