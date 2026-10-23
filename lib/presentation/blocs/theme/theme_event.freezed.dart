// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ThemeEvent {

 bool get isDarkTheme;
/// Create a copy of ThemeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeEventCopyWith<ThemeEvent> get copyWith => _$ThemeEventCopyWithImpl<ThemeEvent>(this as ThemeEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeEvent&&(identical(other.isDarkTheme, isDarkTheme) || other.isDarkTheme == isDarkTheme));
}


@override
int get hashCode => Object.hash(runtimeType,isDarkTheme);

@override
String toString() {
  return 'ThemeEvent(isDarkTheme: $isDarkTheme)';
}


}

/// @nodoc
abstract mixin class $ThemeEventCopyWith<$Res>  {
  factory $ThemeEventCopyWith(ThemeEvent value, $Res Function(ThemeEvent) _then) = _$ThemeEventCopyWithImpl;
@useResult
$Res call({
 bool isDarkTheme
});




}
/// @nodoc
class _$ThemeEventCopyWithImpl<$Res>
    implements $ThemeEventCopyWith<$Res> {
  _$ThemeEventCopyWithImpl(this._self, this._then);

  final ThemeEvent _self;
  final $Res Function(ThemeEvent) _then;

/// Create a copy of ThemeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isDarkTheme = null,}) {
  return _then(_self.copyWith(
isDarkTheme: null == isDarkTheme ? _self.isDarkTheme : isDarkTheme // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ThemeEvent].
extension ThemeEventPatterns on ThemeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ThemeChanged value)?  themeChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ThemeChanged() when themeChanged != null:
return themeChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ThemeChanged value)  themeChanged,}){
final _that = this;
switch (_that) {
case ThemeChanged():
return themeChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ThemeChanged value)?  themeChanged,}){
final _that = this;
switch (_that) {
case ThemeChanged() when themeChanged != null:
return themeChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool isDarkTheme)?  themeChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ThemeChanged() when themeChanged != null:
return themeChanged(_that.isDarkTheme);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool isDarkTheme)  themeChanged,}) {final _that = this;
switch (_that) {
case ThemeChanged():
return themeChanged(_that.isDarkTheme);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool isDarkTheme)?  themeChanged,}) {final _that = this;
switch (_that) {
case ThemeChanged() when themeChanged != null:
return themeChanged(_that.isDarkTheme);case _:
  return null;

}
}

}

/// @nodoc


class ThemeChanged implements ThemeEvent {
  const ThemeChanged(this.isDarkTheme);
  

@override final  bool isDarkTheme;

/// Create a copy of ThemeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeChangedCopyWith<ThemeChanged> get copyWith => _$ThemeChangedCopyWithImpl<ThemeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeChanged&&(identical(other.isDarkTheme, isDarkTheme) || other.isDarkTheme == isDarkTheme));
}


@override
int get hashCode => Object.hash(runtimeType,isDarkTheme);

@override
String toString() {
  return 'ThemeEvent.themeChanged(isDarkTheme: $isDarkTheme)';
}


}

/// @nodoc
abstract mixin class $ThemeChangedCopyWith<$Res> implements $ThemeEventCopyWith<$Res> {
  factory $ThemeChangedCopyWith(ThemeChanged value, $Res Function(ThemeChanged) _then) = _$ThemeChangedCopyWithImpl;
@override @useResult
$Res call({
 bool isDarkTheme
});




}
/// @nodoc
class _$ThemeChangedCopyWithImpl<$Res>
    implements $ThemeChangedCopyWith<$Res> {
  _$ThemeChangedCopyWithImpl(this._self, this._then);

  final ThemeChanged _self;
  final $Res Function(ThemeChanged) _then;

/// Create a copy of ThemeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isDarkTheme = null,}) {
  return _then(ThemeChanged(
null == isDarkTheme ? _self.isDarkTheme : isDarkTheme // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
