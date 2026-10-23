import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/usecase.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/auth/login_usecase.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/auth/logout_usecase.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/status.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({required this.loginUseCase, required this.logoutUseCase})
    : super(const AuthState()) {
    on<AuthUsernameChangedEvent>(
      (event, emit) => emit(state.copyWith(username: event.username)),
    );
    on<AuthPasswordChangedEvent>(
      (event, emit) => emit(state.copyWith(password: event.password)),
    );
    on<AuthLoginEvent>(_onLogin);
    on<AuthLogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    if (!state.isValidInput || state.status.isLoading) return;

    emit(state.copyWith(status: BlocStatus.loading, failure: null));
    final result = await loginUseCase(
      LoginParams(username: state.username, password: state.password),
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(status: BlocStatus.failure, failure: failure)),
      (_) => emit(
        state.copyWith(
          status: BlocStatus.success,
          isAuthenticated: true,
          password: '',
        ),
      ),
    );
  }

  Future<void> _onLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading));
    await logoutUseCase(const NoParams());
    emit(const AuthState(status: BlocStatus.success, isAuthenticated: false));
  }
}
