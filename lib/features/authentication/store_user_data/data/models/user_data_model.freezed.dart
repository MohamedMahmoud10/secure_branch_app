// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserDataModel {

@HiveField(0) String get email;@HiveField(1) String? get uId;@JsonKey(name: 'docId')@HiveField(2) String? get documentId;@MyJsonConverter()@HiveField(3) DateTime? get createdAt;@HiveField(4) String? get name;/// Device identifier (e.g. Android fingerprint, iOS identifierForVendor).
/// Used to associate biometric enrollment with a device in Firestore.
@JsonKey(name: 'deviceId')@HiveField(5) String? get deviceId;
/// Create a copy of UserDataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserDataModelCopyWith<UserDataModel> get copyWith => _$UserDataModelCopyWithImpl<UserDataModel>(this as UserDataModel, _$identity);

  /// Serializes this UserDataModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserDataModel&&(identical(other.email, email) || other.email == email)&&(identical(other.uId, uId) || other.uId == uId)&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.name, name) || other.name == name)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,uId,documentId,createdAt,name,deviceId);

@override
String toString() {
  return 'UserDataModel(email: $email, uId: $uId, documentId: $documentId, createdAt: $createdAt, name: $name, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $UserDataModelCopyWith<$Res>  {
  factory $UserDataModelCopyWith(UserDataModel value, $Res Function(UserDataModel) _then) = _$UserDataModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String email,@HiveField(1) String? uId,@JsonKey(name: 'docId')@HiveField(2) String? documentId,@MyJsonConverter()@HiveField(3) DateTime? createdAt,@HiveField(4) String? name,@JsonKey(name: 'deviceId')@HiveField(5) String? deviceId
});




}
/// @nodoc
class _$UserDataModelCopyWithImpl<$Res>
    implements $UserDataModelCopyWith<$Res> {
  _$UserDataModelCopyWithImpl(this._self, this._then);

  final UserDataModel _self;
  final $Res Function(UserDataModel) _then;

/// Create a copy of UserDataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? uId = freezed,Object? documentId = freezed,Object? createdAt = freezed,Object? name = freezed,Object? deviceId = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,uId: freezed == uId ? _self.uId : uId // ignore: cast_nullable_to_non_nullable
as String?,documentId: freezed == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserDataModel].
extension UserDataModelPatterns on UserDataModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserDataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserDataModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserDataModel value)  $default,){
final _that = this;
switch (_that) {
case _UserDataModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserDataModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserDataModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String email, @HiveField(1)  String? uId, @JsonKey(name: 'docId')@HiveField(2)  String? documentId, @MyJsonConverter()@HiveField(3)  DateTime? createdAt, @HiveField(4)  String? name, @JsonKey(name: 'deviceId')@HiveField(5)  String? deviceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserDataModel() when $default != null:
return $default(_that.email,_that.uId,_that.documentId,_that.createdAt,_that.name,_that.deviceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String email, @HiveField(1)  String? uId, @JsonKey(name: 'docId')@HiveField(2)  String? documentId, @MyJsonConverter()@HiveField(3)  DateTime? createdAt, @HiveField(4)  String? name, @JsonKey(name: 'deviceId')@HiveField(5)  String? deviceId)  $default,) {final _that = this;
switch (_that) {
case _UserDataModel():
return $default(_that.email,_that.uId,_that.documentId,_that.createdAt,_that.name,_that.deviceId);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String email, @HiveField(1)  String? uId, @JsonKey(name: 'docId')@HiveField(2)  String? documentId, @MyJsonConverter()@HiveField(3)  DateTime? createdAt, @HiveField(4)  String? name, @JsonKey(name: 'deviceId')@HiveField(5)  String? deviceId)?  $default,) {final _that = this;
switch (_that) {
case _UserDataModel() when $default != null:
return $default(_that.email,_that.uId,_that.documentId,_that.createdAt,_that.name,_that.deviceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserDataModel extends UserDataModel {
   _UserDataModel({@HiveField(0) required this.email, @HiveField(1) this.uId, @JsonKey(name: 'docId')@HiveField(2) this.documentId, @MyJsonConverter()@HiveField(3) this.createdAt, @HiveField(4) this.name, @JsonKey(name: 'deviceId')@HiveField(5) this.deviceId}): super._();
  factory _UserDataModel.fromJson(Map<String, dynamic> json) => _$UserDataModelFromJson(json);

@override@HiveField(0) final  String email;
@override@HiveField(1) final  String? uId;
@override@JsonKey(name: 'docId')@HiveField(2) final  String? documentId;
@override@MyJsonConverter()@HiveField(3) final  DateTime? createdAt;
@override@HiveField(4) final  String? name;
/// Device identifier (e.g. Android fingerprint, iOS identifierForVendor).
/// Used to associate biometric enrollment with a device in Firestore.
@override@JsonKey(name: 'deviceId')@HiveField(5) final  String? deviceId;

/// Create a copy of UserDataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserDataModelCopyWith<_UserDataModel> get copyWith => __$UserDataModelCopyWithImpl<_UserDataModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserDataModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserDataModel&&(identical(other.email, email) || other.email == email)&&(identical(other.uId, uId) || other.uId == uId)&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.name, name) || other.name == name)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,uId,documentId,createdAt,name,deviceId);

@override
String toString() {
  return 'UserDataModel(email: $email, uId: $uId, documentId: $documentId, createdAt: $createdAt, name: $name, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class _$UserDataModelCopyWith<$Res> implements $UserDataModelCopyWith<$Res> {
  factory _$UserDataModelCopyWith(_UserDataModel value, $Res Function(_UserDataModel) _then) = __$UserDataModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String email,@HiveField(1) String? uId,@JsonKey(name: 'docId')@HiveField(2) String? documentId,@MyJsonConverter()@HiveField(3) DateTime? createdAt,@HiveField(4) String? name,@JsonKey(name: 'deviceId')@HiveField(5) String? deviceId
});




}
/// @nodoc
class __$UserDataModelCopyWithImpl<$Res>
    implements _$UserDataModelCopyWith<$Res> {
  __$UserDataModelCopyWithImpl(this._self, this._then);

  final _UserDataModel _self;
  final $Res Function(_UserDataModel) _then;

/// Create a copy of UserDataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? uId = freezed,Object? documentId = freezed,Object? createdAt = freezed,Object? name = freezed,Object? deviceId = freezed,}) {
  return _then(_UserDataModel(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,uId: freezed == uId ? _self.uId : uId // ignore: cast_nullable_to_non_nullable
as String?,documentId: freezed == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
