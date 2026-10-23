// Built on the Flutter BLoC Clean Architecture template by @nkqdev
// https://github.com/nkqdev/flutter-bloc-clean-architecture

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/app.dart';
import 'package:flutter_bloc_clean_architecture/common/constants/configs_constant.dart';
import 'package:flutter_bloc_clean_architecture/common/services/logging/app_error_handler.dart';
import 'package:flutter_bloc_clean_architecture/common/services/logging/error_reporter.dart';
import 'package:flutter_bloc_clean_architecture/common/services/storage/locale_storage_service.dart';
import 'package:flutter_bloc_clean_architecture/common/utils/app_utils.dart';
import 'package:flutter_bloc_clean_architecture/di/injection.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/auth/check_auth_status_usecase.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/usecase.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/app_bloc_observer.dart';
import 'package:flutter_bloc_clean_architecture/routes/app_route_names.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

/// Replace with a crash reporting implementation (Crashlytics, Sentry...).
const ErrorReporter _errorReporter = LogErrorReporter();

Future<void> main() async {
  // Fail fast, before anything is shown, when the env file is missing.
  ConfigsConstant.ensureConfigured();

  final binding = WidgetsFlutterBinding.ensureInitialized();
  // From here on, every uncaught error is reported.
  AppErrorHandler.init(_errorReporter);
  Bloc.observer = const AppBlocObserver(_errorReporter);

  // Keep the native splash on screen while the app starts. It is removed by
  // BaseApp once the first screen has been drawn.
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  final String initialRoute;
  try {
    initialRoute = await _bootstrap();
  } catch (_) {
    // Never leave the user stuck on the splash if startup fails.
    FlutterNativeSplash.remove();
    rethrow;
  }

  runApp(MainApp(initialRoute: initialRoute));
}

/// Does everything the first screen needs, then picks that screen.
Future<String> _bootstrap() async {
  // Environment: --dart-define-from-file=env/<local|uat|production>.json
  await AppUtils().init();
  await ServiceLocator.configureDependencies();

  // Language/theme are preloaded so the first frame matches the user's
  // settings; the session check decides the first route.
  final (_, authStatus) = await (
    getIt<LocaleStorageService>().load(),
    getIt<CheckAuthStatusUseCase>()(const NoParams()),
  ).wait;

  final isAuthenticated = authStatus.getOrElse(() => false);
  return isAuthenticated ? AppRouteNames.home : AppRouteNames.login;
}
