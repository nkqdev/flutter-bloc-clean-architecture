import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/common/services/logging/app_logger.dart';
import 'package:flutter_bloc_clean_architecture/common/services/logging/error_reporter.dart';

/// Logs every state change (debug builds only) and reports bloc errors.
///
/// States are printed with `toString()`: keep secrets out of it (see
/// `AuthState.toString`).
class AppBlocObserver extends BlocObserver {
  final ErrorReporter reporter;

  const AppBlocObserver(this.reporter);

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    AppLogger.debug('${bloc.runtimeType} ${change.nextState}');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    reporter.recordError(error, stackTrace, reason: '${bloc.runtimeType}');
    super.onError(bloc, error, stackTrace);
  }
}
