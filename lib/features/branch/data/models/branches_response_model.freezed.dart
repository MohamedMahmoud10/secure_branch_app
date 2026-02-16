// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'branches_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BranchesResponseModel {

@HiveField(0) String get id;@HiveField(1) String? get name;@HiveField(2) String? get type;@HiveField(3) String? get address;@HiveField(4) double? get lat;@HiveField(5) double? get lng;@HiveField(6)@JsonKey(name: 'is_active') bool? get isActive;@HiveField(7) List<String>? get services;@HiveField(8) String? get phone;@HiveField(9)@JsonKey(name: 'working_hours') String? get workingHours;
/// Create a copy of BranchesResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BranchesResponseModelCopyWith<BranchesResponseModel> get copyWith => _$BranchesResponseModelCopyWithImpl<BranchesResponseModel>(this as BranchesResponseModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BranchesResponseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.address, address) || other.address == address)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.services, services)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.workingHours, workingHours) || other.workingHours == workingHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,address,lat,lng,isActive,const DeepCollectionEquality().hash(services),phone,workingHours);

@override
String toString() {
  return 'BranchesResponseModel(id: $id, name: $name, type: $type, address: $address, lat: $lat, lng: $lng, isActive: $isActive, services: $services, phone: $phone, workingHours: $workingHours)';
}


}

/// @nodoc
abstract mixin class $BranchesResponseModelCopyWith<$Res>  {
  factory $BranchesResponseModelCopyWith(BranchesResponseModel value, $Res Function(BranchesResponseModel) _then) = _$BranchesResponseModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String? name,@HiveField(2) String? type,@HiveField(3) String? address,@HiveField(4) double? lat,@HiveField(5) double? lng,@HiveField(6)@JsonKey(name: 'is_active') bool? isActive,@HiveField(7) List<String>? services,@HiveField(8) String? phone,@HiveField(9)@JsonKey(name: 'working_hours') String? workingHours
});




}
/// @nodoc
class _$BranchesResponseModelCopyWithImpl<$Res>
    implements $BranchesResponseModelCopyWith<$Res> {
  _$BranchesResponseModelCopyWithImpl(this._self, this._then);

  final BranchesResponseModel _self;
  final $Res Function(BranchesResponseModel) _then;

/// Create a copy of BranchesResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? type = freezed,Object? address = freezed,Object? lat = freezed,Object? lng = freezed,Object? isActive = freezed,Object? services = freezed,Object? phone = freezed,Object? workingHours = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,services: freezed == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as List<String>?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,workingHours: freezed == workingHours ? _self.workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BranchesResponseModel].
extension BranchesResponseModelPatterns on BranchesResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BranchesResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BranchesResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BranchesResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _BranchesResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BranchesResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _BranchesResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String? name, @HiveField(2)  String? type, @HiveField(3)  String? address, @HiveField(4)  double? lat, @HiveField(5)  double? lng, @HiveField(6)@JsonKey(name: 'is_active')  bool? isActive, @HiveField(7)  List<String>? services, @HiveField(8)  String? phone, @HiveField(9)@JsonKey(name: 'working_hours')  String? workingHours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BranchesResponseModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.address,_that.lat,_that.lng,_that.isActive,_that.services,_that.phone,_that.workingHours);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String? name, @HiveField(2)  String? type, @HiveField(3)  String? address, @HiveField(4)  double? lat, @HiveField(5)  double? lng, @HiveField(6)@JsonKey(name: 'is_active')  bool? isActive, @HiveField(7)  List<String>? services, @HiveField(8)  String? phone, @HiveField(9)@JsonKey(name: 'working_hours')  String? workingHours)  $default,) {final _that = this;
switch (_that) {
case _BranchesResponseModel():
return $default(_that.id,_that.name,_that.type,_that.address,_that.lat,_that.lng,_that.isActive,_that.services,_that.phone,_that.workingHours);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  String? name, @HiveField(2)  String? type, @HiveField(3)  String? address, @HiveField(4)  double? lat, @HiveField(5)  double? lng, @HiveField(6)@JsonKey(name: 'is_active')  bool? isActive, @HiveField(7)  List<String>? services, @HiveField(8)  String? phone, @HiveField(9)@JsonKey(name: 'working_hours')  String? workingHours)?  $default,) {final _that = this;
switch (_that) {
case _BranchesResponseModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.address,_that.lat,_that.lng,_that.isActive,_that.services,_that.phone,_that.workingHours);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)
@HiveType(typeId: 2, adapterName: 'BranchesAdapter')
class _BranchesResponseModel extends BranchesResponseModel {
   _BranchesResponseModel({@HiveField(0) required this.id, @HiveField(1) this.name, @HiveField(2) this.type, @HiveField(3) this.address, @HiveField(4) this.lat, @HiveField(5) this.lng, @HiveField(6)@JsonKey(name: 'is_active') this.isActive, @HiveField(7) final  List<String>? services, @HiveField(8) this.phone, @HiveField(9)@JsonKey(name: 'working_hours') this.workingHours}): _services = services,super._();
  factory _BranchesResponseModel.fromJson(Map<String, dynamic> json) => _$BranchesResponseModelFromJson(json);

@override@HiveField(0) final  String id;
@override@HiveField(1) final  String? name;
@override@HiveField(2) final  String? type;
@override@HiveField(3) final  String? address;
@override@HiveField(4) final  double? lat;
@override@HiveField(5) final  double? lng;
@override@HiveField(6)@JsonKey(name: 'is_active') final  bool? isActive;
 final  List<String>? _services;
@override@HiveField(7) List<String>? get services {
  final value = _services;
  if (value == null) return null;
  if (_services is EqualUnmodifiableListView) return _services;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@HiveField(8) final  String? phone;
@override@HiveField(9)@JsonKey(name: 'working_hours') final  String? workingHours;

/// Create a copy of BranchesResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BranchesResponseModelCopyWith<_BranchesResponseModel> get copyWith => __$BranchesResponseModelCopyWithImpl<_BranchesResponseModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BranchesResponseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.address, address) || other.address == address)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._services, _services)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.workingHours, workingHours) || other.workingHours == workingHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,address,lat,lng,isActive,const DeepCollectionEquality().hash(_services),phone,workingHours);

@override
String toString() {
  return 'BranchesResponseModel(id: $id, name: $name, type: $type, address: $address, lat: $lat, lng: $lng, isActive: $isActive, services: $services, phone: $phone, workingHours: $workingHours)';
}


}

/// @nodoc
abstract mixin class _$BranchesResponseModelCopyWith<$Res> implements $BranchesResponseModelCopyWith<$Res> {
  factory _$BranchesResponseModelCopyWith(_BranchesResponseModel value, $Res Function(_BranchesResponseModel) _then) = __$BranchesResponseModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String? name,@HiveField(2) String? type,@HiveField(3) String? address,@HiveField(4) double? lat,@HiveField(5) double? lng,@HiveField(6)@JsonKey(name: 'is_active') bool? isActive,@HiveField(7) List<String>? services,@HiveField(8) String? phone,@HiveField(9)@JsonKey(name: 'working_hours') String? workingHours
});




}
/// @nodoc
class __$BranchesResponseModelCopyWithImpl<$Res>
    implements _$BranchesResponseModelCopyWith<$Res> {
  __$BranchesResponseModelCopyWithImpl(this._self, this._then);

  final _BranchesResponseModel _self;
  final $Res Function(_BranchesResponseModel) _then;

/// Create a copy of BranchesResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? type = freezed,Object? address = freezed,Object? lat = freezed,Object? lng = freezed,Object? isActive = freezed,Object? services = freezed,Object? phone = freezed,Object? workingHours = freezed,}) {
  return _then(_BranchesResponseModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,services: freezed == services ? _self._services : services // ignore: cast_nullable_to_non_nullable
as List<String>?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,workingHours: freezed == workingHours ? _self.workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
