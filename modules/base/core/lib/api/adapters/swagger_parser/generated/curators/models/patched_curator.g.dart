// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patched_curator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchedCurator _$PatchedCuratorFromJson(Map<String, dynamic> json) =>
    PatchedCurator(
      id: PatchedCurator._read_id(json['id']),
      url: json['url'] as String?,
      shelter: json['shelter'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      createdAt: PatchedCurator._read_createdAt(json['created_at']),
      updatedAt: PatchedCurator._read_updatedAt(json['updated_at']),
      additionalProperties:
          PatchedCurator._extras(json, 'additionalProperties') == null
          ? const {}
          : PatchedCurator._readExtras(
              PatchedCurator._extras(json, 'additionalProperties'),
            ),
    );

Map<String, dynamic> _$PatchedCuratorToJson(PatchedCurator instance) =>
    <String, dynamic>{
      'id': ?PatchedCurator._write_id(instance.id),
      'url': ?instance.url,
      'shelter': ?instance.shelter,
      'first_name': ?instance.firstName,
      'last_name': ?instance.lastName,
      'email': ?instance.email,
      'phone_number': ?instance.phoneNumber,
      'address': ?instance.address,
      'created_by': ?instance.createdBy,
      'updated_by': ?instance.updatedBy,
      'created_at': ?PatchedCurator._write_createdAt(instance.createdAt),
      'updated_at': ?PatchedCurator._write_updatedAt(instance.updatedAt),
    };
