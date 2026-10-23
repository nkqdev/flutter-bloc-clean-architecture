import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_clean_architecture/common/constants/configs_constant.dart';
import 'package:flutter_bloc_clean_architecture/common/enums/grant_type_enum.dart';
import 'package:flutter_bloc_clean_architecture/domain/failures/failure.dart';
import 'package:flutter_bloc_clean_architecture/data/repositories/base_repository.dart';
import 'package:flutter_bloc_clean_architecture/common/services/storage/auth_storage_service.dart';
import 'package:flutter_bloc_clean_architecture/data/api/auth_api_service.dart';
import 'package:flutter_bloc_clean_architecture/data/models/auth/mappers/auth_info_model_mapper.dart';
import 'package:flutter_bloc_clean_architecture/data/models/auth/request/login_request_model.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/auth/auth_session.dart';
import 'package:flutter_bloc_clean_architecture/domain/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  final AuthApiService authApiService;
  final AuthStorageService authStorageService;

  AuthRepositoryImpl(this.authApiService, this.authStorageService);

  @override
  Future<Either<Failure, AuthSession>> login({
    required String username,
    required String password,
  }) {
    return guard(() async {
      final response = await authApiService.login(
        LoginRequestModel(
          username: username,
          password: password,
          grantType: GrantTypeEnum.password.key,
          clientId: ConfigsConstant.clientId,
        ),
      );
      final session = response.toEntity();
      await authStorageService.saveSession(session);
      return session;
    });
  }

  @override
  Future<Either<Failure, Unit>> logout() {
    return guard(() async {
      try {
        await authApiService.logout();
      } finally {
        await authStorageService.deleteSession();
      }
      return unit;
    });
  }

  @override
  Future<bool> isAuthenticated() async {
    final session = await authStorageService.getSession();
    return session != null && session.accessToken.isNotEmpty;
  }
}
