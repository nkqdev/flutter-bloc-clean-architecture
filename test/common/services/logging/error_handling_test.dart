import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/common/services/logging/app_error_handler.dart';
import 'package:flutter_bloc_clean_architecture/common/services/logging/error_reporter.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/app_bloc_observer.dart';
import 'package:flutter_test/flutter_test.dart';

class _RecordingReporter implements ErrorReporter {
  final errors = <(Object, bool)>[];

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stack, {
    String? reason,
    bool fatal = false,
  }) async => errors.add((error, fatal));
}

class _CounterCubit extends Cubit<int> {
  _CounterCubit() : super(0);
}

void main() {
  test('framework and async errors reach the reporter as fatal', () {
    final originalFlutterOnError = FlutterError.onError;
    final originalPlatformOnError = PlatformDispatcher.instance.onError;
    final reporter = _RecordingReporter();
    final frameworkError = StateError('build failed');
    final asyncError = StateError('async failed');

    try {
      AppErrorHandler.init(reporter);
      FlutterError.onError!(FlutterErrorDetails(exception: frameworkError));
      final handled = PlatformDispatcher.instance.onError!(
        asyncError,
        StackTrace.current,
      );

      expect(handled, isTrue);
      expect(reporter.errors, [(frameworkError, true), (asyncError, true)]);
    } finally {
      FlutterError.onError = originalFlutterOnError;
      PlatformDispatcher.instance.onError = originalPlatformOnError;
    }
  });

  test('bloc errors reach the reporter as non-fatal', () async {
    final reporter = _RecordingReporter();
    final observer = AppBlocObserver(reporter);
    final cubit = _CounterCubit();
    final error = StateError('handler failed');

    observer.onError(cubit, error, StackTrace.current);

    expect(reporter.errors, [(error, false)]);
    await cubit.close();
  });
}
