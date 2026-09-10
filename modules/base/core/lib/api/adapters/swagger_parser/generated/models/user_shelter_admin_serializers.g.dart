// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_shelter_admin_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserShelterAdminSerializers _$UserShelterAdminSerializersFromJson(
  Map<String, dynamic> json,
) => UserShelterAdminSerializers(
  id: (json['id'] as num?)?.toInt(),
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  fathersName: json['fathers_name'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phone_number'] as String?,
  address: json['address'] as String?,
  password: json['password'] as String?,
  rePassword: json['re_password'] as String?,
  isOfferSigned: json['is_offer_signed'] as bool?,
  shelter: json['shelter'] == null
      ? null
      : ShelterSerializers.fromJson(json['shelter'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserShelterAdminSerializersToJson(
  UserShelterAdminSerializers instance,
) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'fathers_name': instance.fathersName,
  'email': instance.email,
  'phone_number': instance.phoneNumber,
  'address': instance.address,
  'password': instance.password,
  're_password': instance.rePassword,
  'is_offer_signed': instance.isOfferSigned,
  'shelter': instance.shelter,
};
