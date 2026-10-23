import 'package:get_it/get_it.dart';
import 'package:flutter_bloc_clean_architecture/common/services/storage/locale_storage_service.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/auth/login_usecase.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/auth/logout_usecase.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/user/get_user_profile_usecase.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/user/get_users_usecase.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/locale/locale_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/theme/theme_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/user/user_list_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/user/user_profile_cubit.dart';

mixin BlocModule {
  static Future<void> register(GetIt instance) async {
    // App-wide
    instance.registerFactory(
      () => LocaleBloc(instance<LocaleStorageService>()),
    );
    instance.registerFactory(() => ThemeBloc(instance<LocaleStorageService>()));

    // Auth
    instance.registerFactory(
      () => AuthBloc(
        loginUseCase: instance<LoginUseCase>(),
        logoutUseCase: instance<LogoutUseCase>(),
      ),
    );

    // User
    instance.registerFactory(
      () => UserListBloc(getUsersUseCase: instance<GetUsersUseCase>()),
    );
    instance.registerFactory(
      () => UserProfileCubit(
        getUserProfileUseCase: instance<GetUserProfileUseCase>(),
      ),
    );
  }
}
