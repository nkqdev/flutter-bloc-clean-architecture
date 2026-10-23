import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/auth/auth_session.dart';
import 'package:flutter_bloc_clean_architecture/domain/failures/failure.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/auth/login_usecase.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/auth/logout_usecase.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/usecase.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockLoginUseCase extends Mock implements LoginUseCase {}

class _MockLogoutUseCase extends Mock implements LogoutUseCase {}

void main() {
  late _MockLoginUseCase login;
  late _MockLogoutUseCase logout;

  const validInput = AuthState(username: 'admin', password: '123456');
  const failure = UnauthorizedFailure(message: 'Sai mật khẩu');

  setUpAll(() {
    registerFallbackValue(const LoginParams(username: '', password: ''));
    registerFallbackValue(const NoParams());
  });

  setUp(() {
    login = _MockLoginUseCase();
    logout = _MockLogoutUseCase();
  });

  AuthBloc build() => AuthBloc(loginUseCase: login, logoutUseCase: logout);

  blocTest<AuthBloc, AuthState>(
    'login success: loading, then authenticated with password cleared',
    setUp: () => when(
      () => login(any()),
    ).thenAnswer((_) async => const Right(AuthSession(accessToken: 'token'))),
    build: build,
    seed: () => validInput,
    act: (bloc) => bloc.add(const AuthEvent.login()),
    expect: () => [
      validInput.copyWith(status: BlocStatus.loading),
      validInput.copyWith(
        status: BlocStatus.success,
        isAuthenticated: true,
        password: '',
      ),
    ],
    verify: (_) => verify(
      () => login(
        any(
          that: isA<LoginParams>()
              .having((p) => p.username, 'username', 'admin')
              .having((p) => p.password, 'password', '123456'),
        ),
      ),
    ).called(1),
  );

  blocTest<AuthBloc, AuthState>(
    'login failure: loading, then failure kept in state',
    setUp: () =>
        when(() => login(any())).thenAnswer((_) async => const Left(failure)),
    build: build,
    seed: () => validInput,
    act: (bloc) => bloc.add(const AuthEvent.login()),
    expect: () => [
      validInput.copyWith(status: BlocStatus.loading),
      validInput.copyWith(status: BlocStatus.failure, failure: failure),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'invalid input: login is not called',
    build: build,
    seed: () => const AuthState(username: 'admin', password: '123'),
    act: (bloc) => bloc.add(const AuthEvent.login()),
    expect: () => <AuthState>[],
    verify: (_) => verifyNever(() => login(any())),
  );

  blocTest<AuthBloc, AuthState>(
    'login while already loading is ignored (double tap)',
    build: build,
    seed: () => validInput.copyWith(status: BlocStatus.loading),
    act: (bloc) => bloc.add(const AuthEvent.login()),
    expect: () => <AuthState>[],
    verify: (_) => verifyNever(() => login(any())),
  );

  blocTest<AuthBloc, AuthState>(
    'logout: loading, then signed out with a clean state',
    setUp: () =>
        when(() => logout(any())).thenAnswer((_) async => const Right(unit)),
    build: build,
    seed: () => const AuthState(username: 'admin', isAuthenticated: true),
    act: (bloc) => bloc.add(const AuthEvent.logout()),
    expect: () => [
      const AuthState(
        username: 'admin',
        isAuthenticated: true,
        status: BlocStatus.loading,
      ),
      const AuthState(status: BlocStatus.success),
    ],
  );
}
