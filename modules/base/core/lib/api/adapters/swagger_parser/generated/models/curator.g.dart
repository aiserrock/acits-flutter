// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Curator _$CuratorFromJson(Map<String, dynamic> json) => Curator(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  shelter: json['shelter'] as String?,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phone_number'] as String?,
  address: json['address'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$CuratorToJson(Curator instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'shelter': instance.shelter,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'email': instance.email,
  'phone_number': instance.phoneNumber,
  'address': instance.address,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};
