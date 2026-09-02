// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_short_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserShortSerializers _$UserShortSerializersFromJson(
  Map<String, dynamic> json,
) => UserShortSerializers(
  id: (json['id'] as num?)?.toInt(),
  fullName: json['full_name'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phone_number'] as String?,
  address: json['address'] as String?,
);

Map<String, dynamic> _$UserShortSerializersToJson(
  UserShortSerializers instance,
) => <String, dynamic>{
  'id': instance.id,
  'full_name': instance.fullName,
  'email': instance.email,
  'phone_number': instance.phoneNumber,
  'address': instance.address,
};
