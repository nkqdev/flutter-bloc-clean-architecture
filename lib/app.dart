import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/di/injection.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/locale/locale_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/theme/theme_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/widgets/material_app/base_app.dart';

class MainApp extends StatelessWidget {
  /// First screen, chosen during startup (login or home).
  final String initialRoute;

  const MainApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LocaleBloc>()),
        BlocProvider(create: (context) => getIt<ThemeBloc>()),
      ],
      child: BaseApp(initialRoute: initialRoute),
    );
  }
}
