/// Compile-time configuration injected with
/// `--dart-define-from-file=env/<environment>.json`.
///
/// Never put secrets here: every value is compiled into the app binary and
/// can be extracted. The mobile app is a public OAuth client (no secret).
class ConfigsConstant {
  static const String appEnv = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'local',
  );

  static const String apiBaseUrl = String.fromEnvironment('API_BASE_URL');

  static const String clientId = String.fromEnvironment('APP_CLIENT_ID');

  static const int networkConnectTimeoutSeconds = int.fromEnvironment(
    'NETWORK_CONNECT_TIMEOUT_SECONDS',
    defaultValue: 30,
  );

  static const int networkReceiveTimeoutSeconds = int.fromEnvironment(
    'NETWORK_RECEIVE_TIMEOUT_SECONDS',
    defaultValue: 30,
  );

  /// Scale sizes with the screen (flutter_screenutil). Off for phone apps.
  static const bool enableScreenScaling = bool.fromEnvironment(
    'ENABLE_SCREEN_SCALING',
  );

  /// Design file size, used only when screen scaling is on.
  static const double designWidth =
      int.fromEnvironment('DESIGN_WIDTH', defaultValue: 390) * 1.0;

  static const double designHeight =
      int.fromEnvironment('DESIGN_HEIGHT', defaultValue: 844) * 1.0;

  /// Fails fast when the app is started without an env file.
  static void ensureConfigured() {
    if (apiBaseUrl.isEmpty) {
      throw StateError(
        'API_BASE_URL is missing. Run with '
        '--dart-define-from-file=env/<local|uat|production>.json',
      );
    }
  }
}
