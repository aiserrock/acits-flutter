// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_admin_write_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAdminWriteDto _$UserAdminWriteDtoFromJson(Map<String, dynamic> json) =>
    UserAdminWriteDto(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      rePassword: json['re_password'] as String,
      isOfferSigned: json['is_offer_signed'] as bool,
      shelter: ShelterWriteDto.fromJson(
        json['shelter'] as Map<String, dynamic>,
      ),
      fathersName: json['fathers_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$UserAdminWriteDtoToJson(UserAdminWriteDto instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'fathers_name': ?instance.fathersName,
      'email': instance.email,
      'phone_number': ?instance.phoneNumber,
      'address': ?instance.address,
      'password': instance.password,
      're_password': instance.rePassword,
      'is_offer_signed': instance.isOfferSigned,
      'shelter': instance.shelter,
    };
