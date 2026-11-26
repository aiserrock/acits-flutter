// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patched_user_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchedUserSerializers _$PatchedUserSerializersFromJson(
  Map<String, dynamic> json,
) => PatchedUserSerializers(
  id: PatchedUserSerializers._read_id(json['id']),
  username: json['username'] as String?,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  fathersName: json['fathers_name'] as String?,
  fullName: json['full_name'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phone_number'] as String?,
  address: json['address'] as String?,
  dateJoined: PatchedUserSerializers._read_dateJoined(json['date_joined']),
  isVerified: json['is_verified'] as bool?,
  isOfferSigned: json['is_offer_signed'] as bool?,
  additionalProperties:
      PatchedUserSerializers._extras(json, 'additionalProperties') == null
      ? const {}
      : PatchedUserSerializers._readExtras(
          PatchedUserSerializers._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PatchedUserSerializersToJson(
  PatchedUserSerializers instance,
) => <String, dynamic>{
  'id': ?PatchedUserSerializers._write_id(instance.id),
  'username': ?instance.username,
  'first_name': ?instance.firstName,
  'last_name': ?instance.lastName,
  'fathers_name': ?instance.fathersName,
  'full_name': ?instance.fullName,
  'email': ?instance.email,
  'phone_number': ?instance.phoneNumber,
  'address': ?instance.address,
  'date_joined': ?PatchedUserSerializers._write_dateJoined(instance.dateJoined),
  'is_verified': ?instance.isVerified,
  'is_offer_signed': ?instance.isOfferSigned,
};
