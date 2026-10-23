import 'package:flutter_bloc_clean_architecture/common/constants/configs_constant.dart';
import 'package:flutter_bloc_clean_architecture/common/services/storage/auth_storage_service.dart';
import 'package:flutter_bloc_clean_architecture/common/services/storage/locale_storage_service.dart';
import 'package:flutter_bloc_clean_architecture/data/network/api_client.dart';
import 'package:flutter_bloc_clean_architecture/data/api/auth_api_service.dart';
import 'package:flutter_bloc_clean_architecture/data/api/user_api_service.dart';
import 'package:get_it/get_it.dart';

/// Registers infrastructure: storage services, Dio and Retrofit services.
mixin CoreModule {
  static Future<void> register(GetIt sl) async {
    // Storage setup
    sl.registerSingleton<AuthStorageService>(AuthStorageService());
    sl.registerSingleton<LocaleStorageService>(LocaleStorageService());

    // Dio setup
    final dio = createDio(
      '${ConfigsConstant.apiBaseUrl}/api',
      authStorageService: sl<AuthStorageService>(),
    );

    // Retrofit setup
    sl.registerLazySingleton<AuthApiService>(() => AuthApiService(dio));
    sl.registerLazySingleton<UserApiService>(() => UserApiService(dio));
  }
}
