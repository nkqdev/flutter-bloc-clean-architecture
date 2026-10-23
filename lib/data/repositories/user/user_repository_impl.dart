import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_clean_architecture/domain/failures/failure.dart';
import 'package:flutter_bloc_clean_architecture/data/repositories/base_repository.dart';
import 'package:flutter_bloc_clean_architecture/data/api/user_api_service.dart';
import 'package:flutter_bloc_clean_architecture/data/models/user/mappers/user_model_mapper.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/common/paginated.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/user/user.dart';
import 'package:flutter_bloc_clean_architecture/domain/repositories/user/user_repository.dart';

class UserRepositoryImpl extends BaseRepository implements UserRepository {
  final UserApiService userApiService;

  UserRepositoryImpl(this.userApiService);

  @override
  Future<Either<Failure, Paginated<User>>> getUsers({
    required int pageNumber,
    required int pageSize,
    String? keyword,
  }) {
    return guard(() async {
      final response = await userApiService.getUsers(
        pageNumber: pageNumber,
        pageSize: pageSize,
        keyword: keyword,
      );
      return response.toEntity((item) => item.toEntity());
    });
  }

  @override
  Future<Either<Failure, User>> getUserDetail({required String id}) {
    return guard(
      () async => (await userApiService.getUserDetail(id)).toEntity(),
    );
  }

  @override
  Future<Either<Failure, User>> getUserProfile() {
    return guard(
      () async => (await userApiService.getUserProfile()).toEntity(),
    );
  }
}
