import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_clean_architecture/app.dart';
import 'package:flutter_bloc_clean_architecture/common/services/storage/locale_storage_service.dart';
import 'package:flutter_bloc_clean_architecture/common/utils/app_utils.dart';
import 'package:flutter_bloc_clean_architecture/di/injection.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/auth/auth_session.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/common/paginated.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/user/user.dart';
import 'package:flutter_bloc_clean_architecture/domain/failures/failure.dart';
import 'package:flutter_bloc_clean_architecture/domain/repositories/auth/auth_repository.dart';
import 'package:flutter_bloc_clean_architecture/domain/repositories/user/user_repository.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/auth/login_usecase.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/auth/logout_usecase.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/user/get_user_profile_usecase.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/locale/locale_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/theme/theme_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/user/user_profile_cubit.dart';
import 'package:flutter_bloc_clean_architecture/presentation/screens/auth/login_screen.dart';
import 'package:flutter_bloc_clean_architecture/presentation/screens/home/home_screen.dart';
import 'package:flutter_bloc_clean_architecture/presentation/widgets/material_app/base_app.dart';
import 'package:flutter_bloc_clean_architecture/routes/app_route_names.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

class _FakeAuthRepository implements AuthRepository {
  @override
  Future<Either<Failure, AuthSession>> login({
    required String username,
    required String password,
  }) async => const Right(AuthSession(accessToken: 'token'));

  @override
  Future<Either<Failure, Unit>> logout() async => const Right(unit);

  @override
  Future<bool> isAuthenticated() async => true;
}

class _FakeUserRepository implements UserRepository {
  static const _user = User(id: '1', fullName: 'Nguyen Van A');

  @override
  Future<Either<Failure, User>> getUserProfile() async => const Right(_user);

  @override
  Future<Either<Failure, User>> getUserDetail({required String id}) async =>
      const Right(_user);

  @override
  Future<Either<Failure, Paginated<User>>> getUsers({
    required int pageNumber,
    required int pageSize,
    String? keyword,
  }) async => const Right(
    Paginated(items: [_user], pageNumber: 1, pageSize: 20, totalCount: 1),
  );
}

void main() {
  setUpAll(() async {
    PackageInfo.setMockInitialValues(
      appName: 'test',
      packageName: 'test',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
    );
    await AppUtils().init();
  });

  setUp(() async {
    await getIt.reset();
    final authRepository = _FakeAuthRepository();
    final storage = LocaleStorageService();
    getIt
      ..registerFactory(() => LocaleBloc(storage))
      ..registerFactory(() => ThemeBloc(storage))
      ..registerFactory(
        () => AuthBloc(
          loginUseCase: LoginUseCase(authRepository),
          logoutUseCase: LogoutUseCase(authRepository),
        ),
      )
      ..registerFactory(
        () => UserProfileCubit(
          getUserProfileUseCase: GetUserProfileUseCase(_FakeUserRepository()),
        ),
      );
  });

  bool canPop() => BaseApp.navigatorKey.currentState!.canPop();

  testWidgets('signed out: opens login directly, nothing underneath', (
    tester,
  ) async {
    await tester.pumpWidget(const MainApp(initialRoute: AppRouteNames.login));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(canPop(), isFalse);
  });

  testWidgets('signed in: opens home directly, nothing underneath', (
    tester,
  ) async {
    await tester.pumpWidget(const MainApp(initialRoute: AppRouteNames.home));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Nguyen Van A'), findsOneWidget);
    expect(canPop(), isFalse);
  });
}
