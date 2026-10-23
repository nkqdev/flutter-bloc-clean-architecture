import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc_clean_architecture/common/dimension/app_scale.dart';
import 'package:flutter_bloc_clean_architecture/common/services/event_bus/app_events.dart';
import 'package:flutter_bloc_clean_architecture/common/services/event_bus/event_bus_service.dart';
import 'package:flutter_bloc_clean_architecture/common/theme/app_theme.dart';
import 'package:flutter_bloc_clean_architecture/l10n/app_localizations.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/locale/locale_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/locale/locale_state.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/theme/theme_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/theme/theme_state.dart';
import 'package:flutter_bloc_clean_architecture/routes/app_route_generator.dart';
import 'package:flutter_bloc_clean_architecture/routes/app_route_names.dart';

/// Root MaterialApp: theme, localization, routing and global listeners.
class BaseApp extends StatefulWidget {
  final String initialRoute;

  const BaseApp({super.key, required this.initialRoute});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  late final StreamSubscription<SessionExpiredEvent> _sessionExpiredSub;

  @override
  void initState() {
    super.initState();
    // The first screen is drawn in this frame: hand over from native splash.
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => FlutterNativeSplash.remove(),
    );
    _sessionExpiredSub = EventBusService.instance
        .on<SessionExpiredEvent>()
        .listen((_) {
          BaseApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
            AppRouteNames.login,
            (route) => false,
          );
        });
  }

  @override
  void dispose() {
    _sessionExpiredSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!AppScale.enabled) return _buildApp();

    // Rebuilds on screen size changes, so styles read fresh scaled values.
    return ScreenUtilInit(
      designSize: AppScale.designSize,
      minTextAdapt: true,
      builder: (context, child) => _buildApp(),
    );
  }

  Widget _buildApp() {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<LocaleBloc, LocaleState>(
          builder: (context, localeState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: BaseApp.navigatorKey,
              onGenerateTitle: (context) =>
                  AppLocalizations.of(context)!.appTitle,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeState.isDarkTheme
                  ? ThemeMode.dark
                  : ThemeMode.light,
              locale: localeState.locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              initialRoute: widget.initialRoute,
              // Push only the initial route. The default would also push '/'
              // underneath it, leaving a stray page behind login/home.
              onGenerateInitialRoutes: (initialRoute) => [
                AppRouteGenerator.generateRoute(
                  RouteSettings(name: initialRoute),
                ),
              ],
              onGenerateRoute: AppRouteGenerator.generateRoute,
            );
          },
        );
      },
    );
  }
}
