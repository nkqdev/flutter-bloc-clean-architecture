import 'package:flutter_bloc_clean_architecture/common/services/logging/app_logger.dart';

/// Where unexpected errors go.
///
/// Plug a crash reporting service (Firebase Crashlytics, Sentry...) by
/// implementing this interface and passing it to `AppErrorHandler.init` and
/// `AppBlocObserver` in `main.dart`.
abstract class ErrorReporter {
  Future<void> recordError(
    Object error,
    StackTrace? stack, {
    String? reason,
    bool fatal = false,
  });
}

/// Default reporter: writes to the log only.
class LogErrorReporter implements ErrorReporter {
  const LogErrorReporter();

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stack, {
    String? reason,
    bool fatal = false,
  }) async {
    AppLogger.error(
      '${fatal ? 'FATAL' : 'Error'}${reason == null ? '' : ': $reason'}',
      error,
      stack,
    );
  }
}
