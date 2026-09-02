// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_worker_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWorkerDto _$UserWorkerDtoFromJson(Map<String, dynamic> json) =>
    UserWorkerDto(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      isOfferSigned: json['is_offer_signed'] as bool,
      fathersName: json['fathers_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
      shelter: (json['shelter'] as num?)?.toInt(),
      role: json['role'] as String?,
    );

Map<String, dynamic> _$UserWorkerDtoToJson(UserWorkerDto instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'fathers_name': instance.fathersName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
      'shelter': instance.shelter,
      'role': instance.role,
      'is_offer_signed': instance.isOfferSigned,
    };
