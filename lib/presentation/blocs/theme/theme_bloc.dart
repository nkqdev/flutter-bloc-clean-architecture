import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/common/services/storage/locale_storage_service.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/theme/theme_event.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/theme/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final LocaleStorageService _storageService;

  /// Starts from the value preloaded at startup: no async load, no flicker.
  ThemeBloc(LocaleStorageService storageService)
    : _storageService = storageService,
      super(ThemeState(isDarkTheme: storageService.isDarkTheme)) {
    on<ThemeChanged>((event, emit) async {
      emit(ThemeState(isDarkTheme: event.isDarkTheme));
      await _storageService.setTheme(event.isDarkTheme);
    });
  }
}
