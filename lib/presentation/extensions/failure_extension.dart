import 'package:flutter_bloc_clean_architecture/domain/failures/failure.dart';
import 'package:flutter_bloc_clean_architecture/l10n/app_localizations.dart';

extension FailureLocalization on Failure {
  /// User-facing, localized description of this failure.
  String localize(AppLocalizations l10n) {
    return switch (this) {
      NetworkFailure() => l10n.errorConnection,
      TimeoutFailure() => l10n.errorTimeout,
      UnauthorizedFailure() => l10n.errorUnauthorized,
      ForbiddenFailure() => l10n.errorForbidden,
      NotFoundFailure() => l10n.errorNotFound,
      ServerFailure() => l10n.errorServer,
      ValidationFailure(:final message) ||
      UnknownFailure(:final message) => message ?? l10n.errorUnknown,
    };
  }
}
