import 'package:get_it/get_it.dart';
import 'package:flutter_bloc_clean_architecture/domain/repositories/auth/auth_repository.dart';
import 'package:flutter_bloc_clean_architecture/domain/repositories/user/user_repository.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/auth/check_auth_status_usecase.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/auth/login_usecase.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/auth/logout_usecase.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/user/get_user_profile_usecase.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/user/get_users_usecase.dart';

mixin UseCaseModule {
  static Future<void> register(GetIt instance) async {
    // Auth
    instance.registerLazySingleton(
      () => LoginUseCase(instance<AuthRepository>()),
    );
    instance.registerLazySingleton(
      () => LogoutUseCase(instance<AuthRepository>()),
    );
    instance.registerLazySingleton(
      () => CheckAuthStatusUseCase(instance<AuthRepository>()),
    );

    // User
    instance.registerLazySingleton(
      () => GetUsersUseCase(instance<UserRepository>()),
    );
    instance.registerLazySingleton(
      () => GetUserProfileUseCase(instance<UserRepository>()),
    );
  }
}
