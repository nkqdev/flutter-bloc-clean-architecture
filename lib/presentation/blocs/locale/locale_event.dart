import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'locale_event.freezed.dart';

@freezed
sealed class LocaleEvent with _$LocaleEvent {
  const factory LocaleEvent.localeChanged(Locale locale) = LocaleChanged;
}
