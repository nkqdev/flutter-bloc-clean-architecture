// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locale_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocaleEvent {

 Locale get locale;
/// Create a copy of LocaleEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocaleEventCopyWith<LocaleEvent> get copyWith => _$LocaleEventCopyWithImpl<LocaleEvent>(this as LocaleEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocaleEvent&&(identical(other.locale, locale) || other.locale == locale));
}


@override
int get hashCode => Object.hash(runtimeType,locale);

@override
String toString() {
  return 'LocaleEvent(locale: $locale)';
}


}

/// @nodoc
abstract mixin class $LocaleEventCopyWith<$Res>  {
  factory $LocaleEventCopyWith(LocaleEvent value, $Res Function(LocaleEvent) _then) = _$LocaleEventCopyWithImpl;
@useResult
$Res call({
 Locale locale
});




}
/// @nodoc
class _$LocaleEventCopyWithImpl<$Res>
    implements $LocaleEventCopyWith<$Res> {
  _$LocaleEventCopyWithImpl(this._self, this._then);

  final LocaleEvent _self;
  final $Res Function(LocaleEvent) _then;

/// Create a copy of LocaleEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? locale = null,}) {
  return _then(_self.copyWith(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale,
  ));
}

}


/// Adds pattern-matching-related methods to [LocaleEvent].
extension LocaleEventPatterns on LocaleEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LocaleChanged value)?  localeChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LocaleChanged() when localeChanged != null:
return localeChanged(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LocaleChanged value)  localeChanged,}){
final _that = this;
switch (_that) {
case LocaleChanged():
return localeChanged(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LocaleChanged value)?  localeChanged,}){
final _that = this;
switch (_that) {
case LocaleChanged() when localeChanged != null:
return localeChanged(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Locale locale)?  localeChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LocaleChanged() when localeChanged != null:
return localeChanged(_that.locale);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Locale locale)  localeChanged,}) {final _that = this;
switch (_that) {
case LocaleChanged():
return localeChanged(_that.locale);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Locale locale)?  localeChanged,}) {final _that = this;
switch (_that) {
case LocaleChanged() when localeChanged != null:
return localeChanged(_that.locale);case _:
  return null;

}
}

}

/// @nodoc


class LocaleChanged implements LocaleEvent {
  const LocaleChanged(this.locale);
  

@override final  Locale locale;

/// Create a copy of LocaleEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocaleChangedCopyWith<LocaleChanged> get copyWith => _$LocaleChangedCopyWithImpl<LocaleChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocaleChanged&&(identical(other.locale, locale) || other.locale == locale));
}


@override
int get hashCode => Object.hash(runtimeType,locale);

@override
String toString() {
  return 'LocaleEvent.localeChanged(locale: $locale)';
}


}

/// @nodoc
abstract mixin class $LocaleChangedCopyWith<$Res> implements $LocaleEventCopyWith<$Res> {
  factory $LocaleChangedCopyWith(LocaleChanged value, $Res Function(LocaleChanged) _then) = _$LocaleChangedCopyWithImpl;
@override @useResult
$Res call({
 Locale locale
});




}
/// @nodoc
class _$LocaleChangedCopyWithImpl<$Res>
    implements $LocaleChangedCopyWith<$Res> {
  _$LocaleChangedCopyWithImpl(this._self, this._then);

  final LocaleChanged _self;
  final $Res Function(LocaleChanged) _then;

/// Create a copy of LocaleEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locale = null,}) {
  return _then(LocaleChanged(
null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale,
  ));
}


}

// dart format on
