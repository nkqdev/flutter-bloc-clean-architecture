import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_list_event.freezed.dart';

@freezed
sealed class UserListEvent with _$UserListEvent {
  const factory UserListEvent.loadUsers({String? keyword}) = LoadUsers;

  const factory UserListEvent.loadMore() = LoadMoreUsers;

  const factory UserListEvent.refresh() = RefreshUsers;
}
