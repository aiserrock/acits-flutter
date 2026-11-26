// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patched_animal_sitter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchedAnimalSitter _$PatchedAnimalSitterFromJson(Map<String, dynamic> json) =>
    PatchedAnimalSitter(
      id: PatchedAnimalSitter._read_id(json['id']),
      url: json['url'] as String?,
      shelter: json['shelter'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      createdAt: PatchedAnimalSitter._read_createdAt(json['created_at']),
      updatedAt: PatchedAnimalSitter._read_updatedAt(json['updated_at']),
      additionalProperties:
          PatchedAnimalSitter._extras(json, 'additionalProperties') == null
          ? const {}
          : PatchedAnimalSitter._readExtras(
              PatchedAnimalSitter._extras(json, 'additionalProperties'),
            ),
    );

Map<String, dynamic> _$PatchedAnimalSitterToJson(
  PatchedAnimalSitter instance,
) => <String, dynamic>{
  'id': ?PatchedAnimalSitter._write_id(instance.id),
  'url': ?instance.url,
  'shelter': ?instance.shelter,
  'first_name': ?instance.firstName,
  'last_name': ?instance.lastName,
  'email': ?instance.email,
  'phone_number': ?instance.phoneNumber,
  'address': ?instance.address,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'created_at': ?PatchedAnimalSitter._write_createdAt(instance.createdAt),
  'updated_at': ?PatchedAnimalSitter._write_updatedAt(instance.updatedAt),
};
