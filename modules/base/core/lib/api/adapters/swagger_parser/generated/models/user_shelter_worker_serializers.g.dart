// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_shelter_worker_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserShelterWorkerSerializers _$UserShelterWorkerSerializersFromJson(
  Map<String, dynamic> json,
) => UserShelterWorkerSerializers(
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  fathersName: json['fathers_name'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phone_number'] as String?,
  address: json['address'] as String?,
  password: json['password'] as String?,
  rePassword: json['re_password'] as String?,
  shelter: (json['shelter'] as num?)?.toInt(),
  role: json['role'] == null ? null : RoleEnum.fromJson(json['role'] as String),
  isOfferSigned: json['is_offer_signed'] as bool?,
);

Map<String, dynamic> _$UserShelterWorkerSerializersToJson(
  UserShelterWorkerSerializers instance,
) => <String, dynamic>{
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'fathers_name': instance.fathersName,
  'email': instance.email,
  'phone_number': instance.phoneNumber,
  'address': instance.address,
  'password': instance.password,
  're_password': instance.rePassword,
  'shelter': instance.shelter,
  'role': instance.role,
  'is_offer_signed': instance.isOfferSigned,
};
