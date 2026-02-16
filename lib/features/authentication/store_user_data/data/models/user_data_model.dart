import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:secure_branch_app/core/utilities/converters/app_converters.dart';

part 'user_data_model.freezed.dart';

part 'user_data_model.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@HiveType(typeId: 1, adapterName: 'UserDataAdapter')
abstract class UserDataModel with _$UserDataModel {
  factory UserDataModel({
    @HiveField(0) required String email,
    @HiveField(1) String? uId,
    @JsonKey(name: 'doc_id') @HiveField(2) String? documentId,

    @DateTimeConverter() @HiveField(3) DateTime? createdAt,

    @HiveField(4) String? name,

    @JsonKey(name: 'deviceId') @HiveField(5) String? deviceId,

    @JsonKey(name: 'biometricPublicKey')
    @HiveField(6)
    String? biometricPublicKey,

    @JsonKey(name: 'biometricEnabled')
    @HiveField(7)
    @Default(false)
    bool biometricEnabled,
  }) = _UserDataModel;

  UserDataModel._();

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);
}
