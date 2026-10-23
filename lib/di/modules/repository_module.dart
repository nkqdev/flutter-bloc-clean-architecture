import 'package:get_it/get_it.dart';
import 'package:flutter_bloc_clean_architecture/common/services/storage/auth_storage_service.dart';
import 'package:flutter_bloc_clean_architecture/data/api/auth_api_service.dart';
import 'package:flutter_bloc_clean_architecture/data/api/user_api_service.dart';
import 'package:flutter_bloc_clean_architecture/data/repositories/auth/auth_repository_impl.dart';
import 'package:flutter_bloc_clean_architecture/data/repositories/user/user_repository_impl.dart';
import 'package:flutter_bloc_clean_architecture/domain/repositories/auth/auth_repository.dart';
import 'package:flutter_bloc_clean_architecture/domain/repositories/user/user_repository.dart';

mixin RepositoryModule {
  static Future<void> register(GetIt instance) async {
    instance.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        instance<AuthApiService>(),
        instance<AuthStorageService>(),
      ),
    );
    instance.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(instance<UserApiService>()),
    );
  }
}
