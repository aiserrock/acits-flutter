// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_admin_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAdminDto _$UserAdminDtoFromJson(Map<String, dynamic> json) => UserAdminDto(
  id: (json['id'] as num).toInt(),
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  email: json['email'] as String,
  isOfferSigned: json['is_offer_signed'] as bool,
  fathersName: json['fathers_name'] as String?,
  phoneNumber: json['phone_number'] as String?,
  address: json['address'] as String?,
  shelter: json['shelter'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UserAdminDtoToJson(UserAdminDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'fathers_name': instance.fathersName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
      'is_offer_signed': instance.isOfferSigned,
      'shelter': instance.shelter,
    };
