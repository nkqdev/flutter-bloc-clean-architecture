// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_list_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserListEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserListEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserListEvent()';
}


}

/// @nodoc
class $UserListEventCopyWith<$Res>  {
$UserListEventCopyWith(UserListEvent _, $Res Function(UserListEvent) __);
}


/// Adds pattern-matching-related methods to [UserListEvent].
extension UserListEventPatterns on UserListEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadUsers value)?  loadUsers,TResult Function( LoadMoreUsers value)?  loadMore,TResult Function( RefreshUsers value)?  refresh,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadUsers() when loadUsers != null:
return loadUsers(_that);case LoadMoreUsers() when loadMore != null:
return loadMore(_that);case RefreshUsers() when refresh != null:
return refresh(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadUsers value)  loadUsers,required TResult Function( LoadMoreUsers value)  loadMore,required TResult Function( RefreshUsers value)  refresh,}){
final _that = this;
switch (_that) {
case LoadUsers():
return loadUsers(_that);case LoadMoreUsers():
return loadMore(_that);case RefreshUsers():
return refresh(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadUsers value)?  loadUsers,TResult? Function( LoadMoreUsers value)?  loadMore,TResult? Function( RefreshUsers value)?  refresh,}){
final _that = this;
switch (_that) {
case LoadUsers() when loadUsers != null:
return loadUsers(_that);case LoadMoreUsers() when loadMore != null:
return loadMore(_that);case RefreshUsers() when refresh != null:
return refresh(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? keyword)?  loadUsers,TResult Function()?  loadMore,TResult Function()?  refresh,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadUsers() when loadUsers != null:
return loadUsers(_that.keyword);case LoadMoreUsers() when loadMore != null:
return loadMore();case RefreshUsers() when refresh != null:
return refresh();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? keyword)  loadUsers,required TResult Function()  loadMore,required TResult Function()  refresh,}) {final _that = this;
switch (_that) {
case LoadUsers():
return loadUsers(_that.keyword);case LoadMoreUsers():
return loadMore();case RefreshUsers():
return refresh();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? keyword)?  loadUsers,TResult? Function()?  loadMore,TResult? Function()?  refresh,}) {final _that = this;
switch (_that) {
case LoadUsers() when loadUsers != null:
return loadUsers(_that.keyword);case LoadMoreUsers() when loadMore != null:
return loadMore();case RefreshUsers() when refresh != null:
return refresh();case _:
  return null;

}
}

}

/// @nodoc


class LoadUsers implements UserListEvent {
  const LoadUsers({this.keyword});
  

 final  String? keyword;

/// Create a copy of UserListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadUsersCopyWith<LoadUsers> get copyWith => _$LoadUsersCopyWithImpl<LoadUsers>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadUsers&&(identical(other.keyword, keyword) || other.keyword == keyword));
}


@override
int get hashCode => Object.hash(runtimeType,keyword);

@override
String toString() {
  return 'UserListEvent.loadUsers(keyword: $keyword)';
}


}

/// @nodoc
abstract mixin class $LoadUsersCopyWith<$Res> implements $UserListEventCopyWith<$Res> {
  factory $LoadUsersCopyWith(LoadUsers value, $Res Function(LoadUsers) _then) = _$LoadUsersCopyWithImpl;
@useResult
$Res call({
 String? keyword
});




}
/// @nodoc
class _$LoadUsersCopyWithImpl<$Res>
    implements $LoadUsersCopyWith<$Res> {
  _$LoadUsersCopyWithImpl(this._self, this._then);

  final LoadUsers _self;
  final $Res Function(LoadUsers) _then;

/// Create a copy of UserListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? keyword = freezed,}) {
  return _then(LoadUsers(
keyword: freezed == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class LoadMoreUsers implements UserListEvent {
  const LoadMoreUsers();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadMoreUsers);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserListEvent.loadMore()';
}


}




/// @nodoc


class RefreshUsers implements UserListEvent {
  const RefreshUsers();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshUsers);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserListEvent.refresh()';
}


}




// dart format on
