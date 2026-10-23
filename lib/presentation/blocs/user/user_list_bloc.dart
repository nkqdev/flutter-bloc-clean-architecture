import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/common/paginated.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/user/get_users_usecase.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/status.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/user/user_list_event.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/user/user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final GetUsersUseCase getUsersUseCase;

  UserListBloc({required this.getUsersUseCase}) : super(const UserListState()) {
    on<LoadUsers>(_onLoadUsers);
    on<RefreshUsers>(
      (event, emit) => _onLoadUsers(LoadUsers(keyword: state.keyword), emit),
    );
    on<LoadMoreUsers>(_onLoadMore);
  }

  Future<void> _onLoadUsers(
    LoadUsers event,
    Emitter<UserListState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading, keyword: event.keyword));

    final result = await getUsersUseCase(
      GetUsersParams(keyword: event.keyword),
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(status: BlocStatus.failure, failure: failure)),
      (page) => emit(
        state.copyWith(
          status: BlocStatus.success,
          users: page.items,
          pageNumber: Paginated.firstPage,
          hasNextPage: page.hasNextPage,
        ),
      ),
    );
  }

  Future<void> _onLoadMore(
    LoadMoreUsers event,
    Emitter<UserListState> emit,
  ) async {
    if (!state.hasNextPage || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));
    final nextPage = state.pageNumber + 1;
    final result = await getUsersUseCase(
      GetUsersParams(pageNumber: nextPage, keyword: state.keyword),
    );
    result.fold(
      (failure) => emit(state.copyWith(isLoadingMore: false, failure: failure)),
      (page) => emit(
        state.copyWith(
          isLoadingMore: false,
          users: [...state.users, ...page.items],
          pageNumber: nextPage,
          hasNextPage: page.hasNextPage,
        ),
      ),
    );
  }
}
