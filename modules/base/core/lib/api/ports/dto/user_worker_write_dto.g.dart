// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_worker_write_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWorkerWriteDto _$UserWorkerWriteDtoFromJson(Map<String, dynamic> json) =>
    UserWorkerWriteDto(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      rePassword: json['re_password'] as String,
      role: json['role'] as String,
      isOfferSigned: json['is_offer_signed'] as bool,
      shelter: (json['shelter'] as num?)?.toInt(),
      fathersName: json['fathers_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$UserWorkerWriteDtoToJson(UserWorkerWriteDto instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'fathers_name': ?instance.fathersName,
      'email': instance.email,
      'phone_number': ?instance.phoneNumber,
      'address': ?instance.address,
      'password': instance.password,
      're_password': instance.rePassword,
      'shelter': ?instance.shelter,
      'role': instance.role,
      'is_offer_signed': instance.isOfferSigned,
    };
