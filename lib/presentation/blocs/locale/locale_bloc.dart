import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/common/services/storage/locale_storage_service.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/locale/locale_event.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/locale/locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final LocaleStorageService _storageService;

  /// Starts from the value preloaded at startup: no async load, no flicker.
  LocaleBloc(LocaleStorageService storageService)
    : _storageService = storageService,
      super(LocaleState(locale: Locale(storageService.languageCode))) {
    on<LocaleChanged>(_onChangeLocale);
  }

  Future<void> _onChangeLocale(
    LocaleChanged event,
    Emitter<LocaleState> emit,
  ) async {
    emit(LocaleState(locale: event.locale));
    await _storageService.setLocale(event.locale.languageCode);
  }
}
