/// Domain-level failure returned on the `Left` side of every repository call.
///
/// Pure Dart: no dependency on Dio, Flutter or localization. The data layer
/// maps exceptions into these types; the presentation layer translates them.
sealed class Failure {
  final String? message;
  final String? code;

  const Failure({this.message, this.code});

  @override
  String toString() => '$runtimeType(code: $code, message: $message)';
}

/// Cannot reach the server (offline, DNS, refused connection...).
final class NetworkFailure extends Failure {
  const NetworkFailure({super.message, super.code});
}

/// Connect / send / receive timeout.
final class TimeoutFailure extends Failure {
  const TimeoutFailure({super.message, super.code});
}

/// 401 - missing or expired credentials.
final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.message, super.code});
}

/// 403 - authenticated but not allowed.
final class ForbiddenFailure extends Failure {
  const ForbiddenFailure({super.message, super.code});
}

/// 404 - resource does not exist.
final class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message, super.code});
}

/// 400 / 422 - request rejected by business or validation rules.
final class ValidationFailure extends Failure {
  const ValidationFailure({super.message, super.code});
}

/// 5xx - server side error.
final class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure({this.statusCode, super.message, super.code});
}

/// Anything that does not fit the categories above.
final class UnknownFailure extends Failure {
  const UnknownFailure({super.message, super.code});
}
