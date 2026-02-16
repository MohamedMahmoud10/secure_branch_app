// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branches_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BranchesAdapter extends TypeAdapter<_BranchesResponseModel> {
  @override
  final typeId = 2;

  @override
  _BranchesResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _BranchesResponseModel(
      id: fields[0] as String,
      name: fields[1] as String?,
      type: fields[2] as String?,
      address: fields[3] as String?,
      lat: (fields[4] as num?)?.toDouble(),
      lng: (fields[5] as num?)?.toDouble(),
      isActive: fields[6] as bool?,
      services: (fields[7] as List?)?.cast<String>(),
      phone: fields[8] as String?,
      workingHours: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _BranchesResponseModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.lat)
      ..writeByte(5)
      ..write(obj.lng)
      ..writeByte(6)
      ..write(obj.isActive)
      ..writeByte(7)
      ..write(obj.services)
      ..writeByte(8)
      ..write(obj.phone)
      ..writeByte(9)
      ..write(obj.workingHours);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BranchesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BranchesResponseModel _$BranchesResponseModelFromJson(
  Map<String, dynamic> json,
) => _BranchesResponseModel(
  id: json['id'] as String,
  name: json['name'] as String?,
  type: json['type'] as String?,
  address: json['address'] as String?,
  lat: (json['lat'] as num?)?.toDouble(),
  lng: (json['lng'] as num?)?.toDouble(),
  isActive: json['is_active'] as bool?,
  services: (json['services'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  phone: json['phone'] as String?,
  workingHours: json['working_hours'] as String?,
);

Map<String, dynamic> _$BranchesResponseModelToJson(
  _BranchesResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': ?instance.name,
  'type': ?instance.type,
  'address': ?instance.address,
  'lat': ?instance.lat,
  'lng': ?instance.lng,
  'is_active': ?instance.isActive,
  'services': ?instance.services,
  'phone': ?instance.phone,
  'working_hours': ?instance.workingHours,
};
