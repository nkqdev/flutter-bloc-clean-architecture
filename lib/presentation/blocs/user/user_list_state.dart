import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/common/paginated.dart';
import 'package:flutter_bloc_clean_architecture/domain/failures/failure.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/user/user.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/status.dart';

part 'user_list_state.freezed.dart';

@freezed
abstract class UserListState with _$UserListState {
  const factory UserListState({
    @Default(<User>[]) List<User> users,
    @Default(BlocStatus.initial) BlocStatus status,
    @Default(Paginated.firstPage) int pageNumber,
    @Default(false) bool hasNextPage,
    @Default(false) bool isLoadingMore,
    String? keyword,
    Failure? failure,
  }) = _UserListState;
}
