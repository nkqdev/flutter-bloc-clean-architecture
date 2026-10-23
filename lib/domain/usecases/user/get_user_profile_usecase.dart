import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_clean_architecture/domain/failures/failure.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/usecase.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/user/user.dart';
import 'package:flutter_bloc_clean_architecture/domain/repositories/user/user_repository.dart';

class GetUserProfileUseCase implements UseCase<User, NoParams> {
  final UserRepository repository;

  GetUserProfileUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return repository.getUserProfile();
  }
}
