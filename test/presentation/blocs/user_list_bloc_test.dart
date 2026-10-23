import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/common/paginated.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/user/user.dart';
import 'package:flutter_bloc_clean_architecture/domain/failures/failure.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/user/get_users_usecase.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/status.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/user/user_list_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/user/user_list_event.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/user/user_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetUsersUseCase extends Mock implements GetUsersUseCase {}

List<User> _users(int from, int count) => List.generate(
  count,
  (i) => User(id: '${from + i}', fullName: 'User ${from + i}'),
);

/// 45 users in total, 20 per page.
final _page1 = Paginated(
  items: _users(1, 20),
  pageNumber: 1,
  pageSize: 20,
  totalCount: 45,
);
final _page2 = Paginated(
  items: _users(21, 20),
  pageNumber: 2,
  pageSize: 20,
  totalCount: 45,
);

Matcher _pageParam(int page) =>
    isA<GetUsersParams>().having((p) => p.pageNumber, 'pageNumber', page);

void main() {
  late _MockGetUsersUseCase getUsers;

  final loadedPage1 = UserListState(
    status: BlocStatus.success,
    users: _page1.items,
    hasNextPage: true,
  );

  setUpAll(() => registerFallbackValue(const GetUsersParams()));
  setUp(() => getUsers = _MockGetUsersUseCase());

  UserListBloc build() => UserListBloc(getUsersUseCase: getUsers);

  blocTest<UserListBloc, UserListState>(
    'loadUsers: loading, then first page',
    setUp: () =>
        when(() => getUsers(any())).thenAnswer((_) async => Right(_page1)),
    build: build,
    act: (bloc) => bloc.add(const UserListEvent.loadUsers()),
    expect: () => [
      const UserListState(status: BlocStatus.loading),
      loadedPage1,
    ],
  );

  blocTest<UserListBloc, UserListState>(
    'loadUsers failure: failure state',
    setUp: () => when(
      () => getUsers(any()),
    ).thenAnswer((_) async => const Left(NetworkFailure())),
    build: build,
    act: (bloc) => bloc.add(const UserListEvent.loadUsers()),
    expect: () => [
      const UserListState(status: BlocStatus.loading),
      isA<UserListState>()
          .having((s) => s.status, 'status', BlocStatus.failure)
          .having((s) => s.failure, 'failure', isA<NetworkFailure>()),
    ],
  );

  blocTest<UserListBloc, UserListState>(
    'loadMore: appends page 2 and advances the page number',
    setUp: () => when(
      () => getUsers(any(that: _pageParam(2))),
    ).thenAnswer((_) async => Right(_page2)),
    build: build,
    seed: () => loadedPage1,
    act: (bloc) => bloc.add(const UserListEvent.loadMore()),
    expect: () => [
      loadedPage1.copyWith(isLoadingMore: true),
      loadedPage1.copyWith(
        users: [..._page1.items, ..._page2.items],
        pageNumber: 2,
        hasNextPage: true,
      ),
    ],
  );

  blocTest<UserListBloc, UserListState>(
    'loadMore twice while loading: only one request',
    setUp: () => when(() => getUsers(any(that: _pageParam(2)))).thenAnswer(
      (_) =>
          Future.delayed(const Duration(milliseconds: 20), () => Right(_page2)),
    ),
    build: build,
    seed: () => loadedPage1,
    act: (bloc) => bloc
      ..add(const UserListEvent.loadMore())
      ..add(const UserListEvent.loadMore()),
    wait: const Duration(milliseconds: 50),
    expect: () => [
      loadedPage1.copyWith(isLoadingMore: true),
      isA<UserListState>().having((s) => s.users.length, 'users', 40),
    ],
    verify: (_) => verify(() => getUsers(any())).called(1),
  );

  blocTest<UserListBloc, UserListState>(
    'loadMore on the last page: nothing happens',
    build: build,
    seed: () => loadedPage1.copyWith(hasNextPage: false),
    act: (bloc) => bloc.add(const UserListEvent.loadMore()),
    expect: () => <UserListState>[],
    verify: (_) => verifyNever(() => getUsers(any())),
  );

  blocTest<UserListBloc, UserListState>(
    'loadMore failure: keeps loaded users and stops the spinner',
    setUp: () => when(
      () => getUsers(any()),
    ).thenAnswer((_) async => const Left(TimeoutFailure())),
    build: build,
    seed: () => loadedPage1,
    act: (bloc) => bloc.add(const UserListEvent.loadMore()),
    expect: () => [
      loadedPage1.copyWith(isLoadingMore: true),
      isA<UserListState>()
          .having((s) => s.users, 'users', _page1.items)
          .having((s) => s.isLoadingMore, 'isLoadingMore', false)
          .having((s) => s.failure, 'failure', isA<TimeoutFailure>()),
    ],
  );
}
