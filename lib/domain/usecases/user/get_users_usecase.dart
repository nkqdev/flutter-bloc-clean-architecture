import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_clean_architecture/domain/failures/failure.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/usecase.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/common/paginated.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/user/user.dart';
import 'package:flutter_bloc_clean_architecture/domain/repositories/user/user_repository.dart';

class GetUsersParams {
  final int pageNumber;
  final int pageSize;
  final String? keyword;

  const GetUsersParams({
    this.pageNumber = Paginated.firstPage,
    this.pageSize = Paginated.defaultPageSize,
    this.keyword,
  });
}

class GetUsersUseCase implements UseCase<Paginated<User>, GetUsersParams> {
  final UserRepository repository;

  GetUsersUseCase(this.repository);

  @override
  Future<Either<Failure, Paginated<User>>> call(GetUsersParams params) {
    return repository.getUsers(
      pageNumber: params.pageNumber,
      pageSize: params.pageSize,
      keyword: params.keyword,
    );
  }
}
