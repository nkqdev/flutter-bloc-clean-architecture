// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthUsernameChangedEvent value)?  usernameChanged,TResult Function( AuthPasswordChangedEvent value)?  passwordChanged,TResult Function( AuthLoginEvent value)?  login,TResult Function( AuthLogoutEvent value)?  logout,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthUsernameChangedEvent() when usernameChanged != null:
return usernameChanged(_that);case AuthPasswordChangedEvent() when passwordChanged != null:
return passwordChanged(_that);case AuthLoginEvent() when login != null:
return login(_that);case AuthLogoutEvent() when logout != null:
return logout(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthUsernameChangedEvent value)  usernameChanged,required TResult Function( AuthPasswordChangedEvent value)  passwordChanged,required TResult Function( AuthLoginEvent value)  login,required TResult Function( AuthLogoutEvent value)  logout,}){
final _that = this;
switch (_that) {
case AuthUsernameChangedEvent():
return usernameChanged(_that);case AuthPasswordChangedEvent():
return passwordChanged(_that);case AuthLoginEvent():
return login(_that);case AuthLogoutEvent():
return logout(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthUsernameChangedEvent value)?  usernameChanged,TResult? Function( AuthPasswordChangedEvent value)?  passwordChanged,TResult? Function( AuthLoginEvent value)?  login,TResult? Function( AuthLogoutEvent value)?  logout,}){
final _that = this;
switch (_that) {
case AuthUsernameChangedEvent() when usernameChanged != null:
return usernameChanged(_that);case AuthPasswordChangedEvent() when passwordChanged != null:
return passwordChanged(_that);case AuthLoginEvent() when login != null:
return login(_that);case AuthLogoutEvent() when logout != null:
return logout(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String username)?  usernameChanged,TResult Function( String password)?  passwordChanged,TResult Function()?  login,TResult Function()?  logout,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthUsernameChangedEvent() when usernameChanged != null:
return usernameChanged(_that.username);case AuthPasswordChangedEvent() when passwordChanged != null:
return passwordChanged(_that.password);case AuthLoginEvent() when login != null:
return login();case AuthLogoutEvent() when logout != null:
return logout();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String username)  usernameChanged,required TResult Function( String password)  passwordChanged,required TResult Function()  login,required TResult Function()  logout,}) {final _that = this;
switch (_that) {
case AuthUsernameChangedEvent():
return usernameChanged(_that.username);case AuthPasswordChangedEvent():
return passwordChanged(_that.password);case AuthLoginEvent():
return login();case AuthLogoutEvent():
return logout();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String username)?  usernameChanged,TResult? Function( String password)?  passwordChanged,TResult? Function()?  login,TResult? Function()?  logout,}) {final _that = this;
switch (_that) {
case AuthUsernameChangedEvent() when usernameChanged != null:
return usernameChanged(_that.username);case AuthPasswordChangedEvent() when passwordChanged != null:
return passwordChanged(_that.password);case AuthLoginEvent() when login != null:
return login();case AuthLogoutEvent() when logout != null:
return logout();case _:
  return null;

}
}

}

/// @nodoc


class AuthUsernameChangedEvent implements AuthEvent {
  const AuthUsernameChangedEvent(this.username);
  

 final  String username;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthUsernameChangedEventCopyWith<AuthUsernameChangedEvent> get copyWith => _$AuthUsernameChangedEventCopyWithImpl<AuthUsernameChangedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthUsernameChangedEvent&&(identical(other.username, username) || other.username == username));
}


@override
int get hashCode => Object.hash(runtimeType,username);

@override
String toString() {
  return 'AuthEvent.usernameChanged(username: $username)';
}


}

/// @nodoc
abstract mixin class $AuthUsernameChangedEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthUsernameChangedEventCopyWith(AuthUsernameChangedEvent value, $Res Function(AuthUsernameChangedEvent) _then) = _$AuthUsernameChangedEventCopyWithImpl;
@useResult
$Res call({
 String username
});




}
/// @nodoc
class _$AuthUsernameChangedEventCopyWithImpl<$Res>
    implements $AuthUsernameChangedEventCopyWith<$Res> {
  _$AuthUsernameChangedEventCopyWithImpl(this._self, this._then);

  final AuthUsernameChangedEvent _self;
  final $Res Function(AuthUsernameChangedEvent) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? username = null,}) {
  return _then(AuthUsernameChangedEvent(
null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthPasswordChangedEvent implements AuthEvent {
  const AuthPasswordChangedEvent(this.password);
  

 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthPasswordChangedEventCopyWith<AuthPasswordChangedEvent> get copyWith => _$AuthPasswordChangedEventCopyWithImpl<AuthPasswordChangedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthPasswordChangedEvent&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,password);

@override
String toString() {
  return 'AuthEvent.passwordChanged(password: $password)';
}


}

/// @nodoc
abstract mixin class $AuthPasswordChangedEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthPasswordChangedEventCopyWith(AuthPasswordChangedEvent value, $Res Function(AuthPasswordChangedEvent) _then) = _$AuthPasswordChangedEventCopyWithImpl;
@useResult
$Res call({
 String password
});




}
/// @nodoc
class _$AuthPasswordChangedEventCopyWithImpl<$Res>
    implements $AuthPasswordChangedEventCopyWith<$Res> {
  _$AuthPasswordChangedEventCopyWithImpl(this._self, this._then);

  final AuthPasswordChangedEvent _self;
  final $Res Function(AuthPasswordChangedEvent) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? password = null,}) {
  return _then(AuthPasswordChangedEvent(
null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthLoginEvent implements AuthEvent {
  const AuthLoginEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthLoginEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.login()';
}


}




/// @nodoc


class AuthLogoutEvent implements AuthEvent {
  const AuthLogoutEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthLogoutEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.logout()';
}


}




// dart format on
