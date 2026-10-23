import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_clean_architecture/common/services/logging/error_reporter.dart';

/// Routes every uncaught error to an [ErrorReporter].
class AppErrorHandler {
  /// Call once at the very start of `main`, before anything can throw.
  static void init(ErrorReporter reporter) {
    // Errors thrown by the framework (build, layout, paint, gestures...).
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      reporter.recordError(
        details.exception,
        details.stack,
        reason: details.context?.toDescription(),
        fatal: true,
      );
    };

    // Uncaught async errors that never reached the framework.
    PlatformDispatcher.instance.onError = (error, stack) {
      reporter.recordError(error, stack, fatal: true);
      return true;
    };
  }
}
