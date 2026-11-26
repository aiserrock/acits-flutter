// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_short_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserShortSerializers _$UserShortSerializersFromJson(
  Map<String, dynamic> json,
) => UserShortSerializers(
  id: UserShortSerializers._read_id(json['id']),
  fullName: json['full_name'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phone_number'] as String?,
  address: json['address'] as String?,
  additionalProperties:
      UserShortSerializers._extras(json, 'additionalProperties') == null
      ? const {}
      : UserShortSerializers._readExtras(
          UserShortSerializers._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$UserShortSerializersToJson(
  UserShortSerializers instance,
) => <String, dynamic>{
  'id': ?UserShortSerializers._write_id(instance.id),
  'full_name': ?instance.fullName,
  'email': ?instance.email,
  'phone_number': ?instance.phoneNumber,
  'address': ?instance.address,
};
