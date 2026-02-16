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

    /// Device identifier (e.g. Android fingerprint, iOS identifierForVendor).
    /// Used to associate biometric enrollment with a device in Firestore.
    @JsonKey(name: 'deviceId') @HiveField(5) String? deviceId,
  }) = _UserDataModel;

  UserDataModel._();

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);
}
