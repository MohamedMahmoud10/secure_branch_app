// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transactions_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionsModels {

@JsonKey(name: 'merchant_name') String get merchantName; num get amount;@TransactionCategoryConverter() TransactionCategory get category;@JsonKey(name: 'doc_id') String? get documentId;@DateTimeConverter() DateTime? get createdAt;
/// Create a copy of TransactionsModels
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionsModelsCopyWith<TransactionsModels> get copyWith => _$TransactionsModelsCopyWithImpl<TransactionsModels>(this as TransactionsModels, _$identity);

  /// Serializes this TransactionsModels to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionsModels&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.category, category) || other.category == category)&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,merchantName,amount,category,documentId,createdAt);

@override
String toString() {
  return 'TransactionsModels(merchantName: $merchantName, amount: $amount, category: $category, documentId: $documentId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TransactionsModelsCopyWith<$Res>  {
  factory $TransactionsModelsCopyWith(TransactionsModels value, $Res Function(TransactionsModels) _then) = _$TransactionsModelsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'merchant_name') String merchantName, num amount,@TransactionCategoryConverter() TransactionCategory category,@JsonKey(name: 'doc_id') String? documentId,@DateTimeConverter() DateTime? createdAt
});




}
/// @nodoc
class _$TransactionsModelsCopyWithImpl<$Res>
    implements $TransactionsModelsCopyWith<$Res> {
  _$TransactionsModelsCopyWithImpl(this._self, this._then);

  final TransactionsModels _self;
  final $Res Function(TransactionsModels) _then;

/// Create a copy of TransactionsModels
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? merchantName = null,Object? amount = null,Object? category = null,Object? documentId = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
merchantName: null == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TransactionCategory,documentId: freezed == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionsModels].
extension TransactionsModelsPatterns on TransactionsModels {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionsModels value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionsModels() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionsModels value)  $default,){
final _that = this;
switch (_that) {
case _TransactionsModels():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionsModels value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionsModels() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'merchant_name')  String merchantName,  num amount, @TransactionCategoryConverter()  TransactionCategory category, @JsonKey(name: 'doc_id')  String? documentId, @DateTimeConverter()  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionsModels() when $default != null:
return $default(_that.merchantName,_that.amount,_that.category,_that.documentId,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'merchant_name')  String merchantName,  num amount, @TransactionCategoryConverter()  TransactionCategory category, @JsonKey(name: 'doc_id')  String? documentId, @DateTimeConverter()  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _TransactionsModels():
return $default(_that.merchantName,_that.amount,_that.category,_that.documentId,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'merchant_name')  String merchantName,  num amount, @TransactionCategoryConverter()  TransactionCategory category, @JsonKey(name: 'doc_id')  String? documentId, @DateTimeConverter()  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TransactionsModels() when $default != null:
return $default(_that.merchantName,_that.amount,_that.category,_that.documentId,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionsModels implements TransactionsModels {
   _TransactionsModels({@JsonKey(name: 'merchant_name') required this.merchantName, required this.amount, @TransactionCategoryConverter() required this.category, @JsonKey(name: 'doc_id') this.documentId, @DateTimeConverter() this.createdAt});
  factory _TransactionsModels.fromJson(Map<String, dynamic> json) => _$TransactionsModelsFromJson(json);

@override@JsonKey(name: 'merchant_name') final  String merchantName;
@override final  num amount;
@override@TransactionCategoryConverter() final  TransactionCategory category;
@override@JsonKey(name: 'doc_id') final  String? documentId;
@override@DateTimeConverter() final  DateTime? createdAt;

/// Create a copy of TransactionsModels
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionsModelsCopyWith<_TransactionsModels> get copyWith => __$TransactionsModelsCopyWithImpl<_TransactionsModels>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionsModelsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionsModels&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.category, category) || other.category == category)&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,merchantName,amount,category,documentId,createdAt);

@override
String toString() {
  return 'TransactionsModels(merchantName: $merchantName, amount: $amount, category: $category, documentId: $documentId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TransactionsModelsCopyWith<$Res> implements $TransactionsModelsCopyWith<$Res> {
  factory _$TransactionsModelsCopyWith(_TransactionsModels value, $Res Function(_TransactionsModels) _then) = __$TransactionsModelsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'merchant_name') String merchantName, num amount,@TransactionCategoryConverter() TransactionCategory category,@JsonKey(name: 'doc_id') String? documentId,@DateTimeConverter() DateTime? createdAt
});




}
/// @nodoc
class __$TransactionsModelsCopyWithImpl<$Res>
    implements _$TransactionsModelsCopyWith<$Res> {
  __$TransactionsModelsCopyWithImpl(this._self, this._then);

  final _TransactionsModels _self;
  final $Res Function(_TransactionsModels) _then;

/// Create a copy of TransactionsModels
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? merchantName = null,Object? amount = null,Object? category = null,Object? documentId = freezed,Object? createdAt = freezed,}) {
  return _then(_TransactionsModels(
merchantName: null == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TransactionCategory,documentId: freezed == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
