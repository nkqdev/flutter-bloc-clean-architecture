import 'package:flutter_bloc_clean_architecture/domain/entities/user/user.dart';
import 'package:flutter_bloc_clean_architecture/domain/failures/failure.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_state.freezed.dart';

@freezed
abstract class UserProfileState with _$UserProfileState {
  const factory UserProfileState({
    @Default(BlocStatus.initial) BlocStatus status,
    User? user,
    Failure? failure,
  }) = _UserProfileState;
}
