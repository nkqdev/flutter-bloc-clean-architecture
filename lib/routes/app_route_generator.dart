import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/di/injection.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/user/user_list_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/user/user_list_event.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/user/user_profile_cubit.dart';
import 'package:flutter_bloc_clean_architecture/presentation/screens/auth/login_screen.dart';
import 'package:flutter_bloc_clean_architecture/presentation/screens/home/home_screen.dart';
import 'package:flutter_bloc_clean_architecture/presentation/screens/user/user_list_screen.dart';
import 'package:flutter_bloc_clean_architecture/routes/app_route_names.dart';
import 'package:flutter_bloc_clean_architecture/routes/arguments/user_list_argument.dart';

class AppRouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.login:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (context) => getIt<AuthBloc>(),
            child: const LoginScreen(),
          ),
        );

      case AppRouteNames.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<AuthBloc>()),
              BlocProvider(
                create: (context) => getIt<UserProfileCubit>()..load(),
              ),
            ],
            child: const HomeScreen(),
          ),
        );

      case AppRouteNames.userList:
        final argument = settings.arguments as UserListArgument?;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (context) =>
                getIt<UserListBloc>()
                  ..add(UserListEvent.loadUsers(keyword: argument?.keyword)),
            child: const UserListScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
