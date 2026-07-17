// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curator_write_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CuratorWriteDto _$CuratorWriteDtoFromJson(Map<String, dynamic> json) => CuratorWriteDto(
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  phoneNumber: json['phone_number'] as String,
  address: json['address'] as String,
  id: (json['id'] as num?)?.toInt(),
  shelter: json['shelter'] as String?,
  email: json['email'] as String?,
);

Map<String, dynamic> _$CuratorWriteDtoToJson(CuratorWriteDto instance) => <String, dynamic>{
  'id': ?instance.id,
  'shelter': ?instance.shelter,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'email': ?instance.email,
  'phone_number': instance.phoneNumber,
  'address': instance.address,
};
