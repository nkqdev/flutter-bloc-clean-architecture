import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.usernameChanged(String username) =
      AuthUsernameChangedEvent;

  const factory AuthEvent.passwordChanged(String password) =
      AuthPasswordChangedEvent;

  const factory AuthEvent.login() = AuthLoginEvent;

  const factory AuthEvent.logout() = AuthLogoutEvent;
}
