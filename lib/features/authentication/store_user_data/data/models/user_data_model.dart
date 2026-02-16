import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive_ce.dart';

part 'user_data_model.freezed.dart';

part 'user_data_model.g.dart';

class MyJsonConverter implements JsonConverter<DateTime, Timestamp> {
  const MyJsonConverter();

  @override
  DateTime fromJson(Timestamp json) => json.toDate();

  @override
  Timestamp toJson(DateTime object) => Timestamp.fromDate(object);
}

@Freezed(makeCollectionsUnmodifiable: false)
@HiveType(typeId: 1, adapterName: 'UserDataAdapter')
abstract class UserDataModel with _$UserDataModel {
  factory UserDataModel({
    @HiveField(0) required String email,
    @HiveField(1) String? uId,

    @JsonKey(name: 'docId') @HiveField(2) String? documentId,

    @MyJsonConverter() @HiveField(3) DateTime? createdAt,
  }) = _UserDataModel;

  UserDataModel._();

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);
}
