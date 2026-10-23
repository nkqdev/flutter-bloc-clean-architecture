import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Thin logging facade. Swap the body for a logging package later without
/// touching call sites.
///
/// `debug` and `info` are dropped in release builds; `warning` and `error`
/// always go through.
class AppLogger {
  static const String _name = 'App';

  static void debug(String message) {
    if (kReleaseMode) return;
    developer.log(message, name: _name, level: 500);
  }

  static void info(String message) {
    if (kReleaseMode) return;
    developer.log(message, name: _name, level: 800);
  }

  static void warning(String message, [Object? error, StackTrace? stack]) {
    developer.log(
      message,
      name: _name,
      level: 900,
      error: error,
      stackTrace: stack,
    );
  }

  static void error(String message, [Object? error, StackTrace? stack]) {
    developer.log(
      message,
      name: _name,
      level: 1000,
      error: error,
      stackTrace: stack,
    );
  }
}
