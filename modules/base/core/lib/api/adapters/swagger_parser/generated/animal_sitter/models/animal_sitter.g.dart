// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_sitter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalSitter _$AnimalSitterFromJson(Map<String, dynamic> json) => AnimalSitter(
  id: AnimalSitter._read_id(json['id']),
  url: json['url'] as String?,
  shelter: json['shelter'] as String?,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phone_number'] as String?,
  address: json['address'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  createdAt: AnimalSitter._read_createdAt(json['created_at']),
  updatedAt: AnimalSitter._read_updatedAt(json['updated_at']),
  additionalProperties:
      AnimalSitter._extras(json, 'additionalProperties') == null
      ? const {}
      : AnimalSitter._readExtras(
          AnimalSitter._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$AnimalSitterToJson(AnimalSitter instance) =>
    <String, dynamic>{
      'id': ?AnimalSitter._write_id(instance.id),
      'url': ?instance.url,
      'shelter': ?instance.shelter,
      'first_name': ?instance.firstName,
      'last_name': ?instance.lastName,
      'email': ?instance.email,
      'phone_number': ?instance.phoneNumber,
      'address': ?instance.address,
      'created_by': ?instance.createdBy,
      'updated_by': ?instance.updatedBy,
      'created_at': ?AnimalSitter._write_createdAt(instance.createdAt),
      'updated_at': ?AnimalSitter._write_updatedAt(instance.updatedAt),
    };
