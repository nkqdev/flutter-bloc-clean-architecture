import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_clean_architecture/domain/failures/failure.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/usecase.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/auth/auth_session.dart';
import 'package:flutter_bloc_clean_architecture/domain/repositories/auth/auth_repository.dart';

class LoginParams {
  final String username;
  final String password;

  const LoginParams({required this.username, required this.password});
}

class LoginUseCase implements UseCase<AuthSession, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthSession>> call(LoginParams params) {
    return repository.login(
      username: params.username.trim(),
      password: params.password,
    );
  }
}
