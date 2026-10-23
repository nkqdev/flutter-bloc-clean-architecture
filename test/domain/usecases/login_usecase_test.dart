import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_clean_architecture/domain/failures/failure.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/auth/auth_session.dart';
import 'package:flutter_bloc_clean_architecture/domain/repositories/auth/auth_repository.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/auth/login_usecase.dart';

class _FakeAuthRepository implements AuthRepository {
  String? lastUsername;

  @override
  Future<Either<Failure, AuthSession>> login({
    required String username,
    required String password,
  }) async {
    lastUsername = username;
    return const Right(AuthSession(accessToken: 'token'));
  }

  @override
  Future<Either<Failure, Unit>> logout() async => const Right(unit);

  @override
  Future<bool> isAuthenticated() async => true;
}

void main() {
  test('LoginUseCase trims username and returns session', () async {
    final repository = _FakeAuthRepository();
    final useCase = LoginUseCase(repository);

    final result = await useCase(
      const LoginParams(username: '  admin  ', password: '123456'),
    );

    expect(repository.lastUsername, 'admin');
    expect(result.isRight(), isTrue);
  });
}
