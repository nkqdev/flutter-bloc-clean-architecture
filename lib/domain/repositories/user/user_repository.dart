import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_clean_architecture/domain/failures/failure.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/common/paginated.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/user/user.dart';

abstract class UserRepository {
  Future<Either<Failure, Paginated<User>>> getUsers({
    required int pageNumber,
    required int pageSize,
    String? keyword,
  });

  Future<Either<Failure, User>> getUserDetail({required String id});

  Future<Either<Failure, User>> getUserProfile();
}
