import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc_clean_architecture/domain/failures/failure.dart';
import 'package:flutter_bloc_clean_architecture/common/utils/validator.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/status.dart';

part 'auth_state.freezed.dart';

/// `toStringOverride: false` + a custom [toString]: the password must never
/// reach logs (BlocObserver, crash reports, debug prints).
@Freezed(toStringOverride: false)
abstract class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState({
    @Default('') String username,
    @Default('') String password,
    @Default(BlocStatus.initial) BlocStatus status,
    @Default(false) bool isAuthenticated,
    Failure? failure,
  }) = _AuthState;

  bool get isValidInput =>
      Validator.isNotEmpty(username) && Validator.isPassword(password);

  @override
  String toString() =>
      'AuthState(username: $username, password: ${password.isEmpty ? '' : '***'}, '
      'status: $status, isAuthenticated: $isAuthenticated, failure: $failure)';
}
