// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDataAdapter extends TypeAdapter<UserDataModel> {
  @override
  final typeId = 1;

  @override
  UserDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDataModel(
      email: fields[0] as String,
      uId: fields[1] as String?,
      documentId: fields[2] as String?,
      createdAt: fields[3] as DateTime?,
      name: fields[4] as String?,
      deviceId: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserDataModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.uId)
      ..writeByte(2)
      ..write(obj.documentId)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.deviceId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) =>
    _UserDataModel(
      email: json['email'] as String,
      uId: json['uId'] as String?,
      documentId: json['docId'] as String?,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
        json['createdAt'],
        const MyJsonConverter().fromJson,
      ),
      name: json['name'] as String?,
      deviceId: json['deviceId'] as String?,
    );

Map<String, dynamic> _$UserDataModelToJson(_UserDataModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'uId': ?instance.uId,
      'docId': ?instance.documentId,
      'createdAt': ?_$JsonConverterToJson<Timestamp, DateTime>(
        instance.createdAt,
        const MyJsonConverter().toJson,
      ),
      'name': ?instance.name,
      'deviceId': ?instance.deviceId,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
