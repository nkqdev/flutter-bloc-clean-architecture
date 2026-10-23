import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/usecase.dart';
import 'package:flutter_bloc_clean_architecture/domain/usecases/user/get_user_profile_usecase.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/status.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/user/user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;

  UserProfileCubit({required this.getUserProfileUseCase})
    : super(const UserProfileState());

  Future<void> load() async {
    emit(state.copyWith(status: BlocStatus.loading, failure: null));
    final result = await getUserProfileUseCase(const NoParams());
    result.fold(
      (failure) =>
          emit(state.copyWith(status: BlocStatus.failure, failure: failure)),
      (user) => emit(state.copyWith(status: BlocStatus.success, user: user)),
    );
  }
}
