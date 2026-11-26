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
  shelter: UserShelterWorkerSerializers._read_shelter(json['shelter']),
  role: UserShelterWorkerSerializers._read_role(json['role']),
  isOfferSigned: json['is_offer_signed'] as bool?,
  additionalProperties:
      UserShelterWorkerSerializers._extras(json, 'additionalProperties') == null
      ? const {}
      : UserShelterWorkerSerializers._readExtras(
          UserShelterWorkerSerializers._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$UserShelterWorkerSerializersToJson(
  UserShelterWorkerSerializers instance,
) => <String, dynamic>{
  'first_name': ?instance.firstName,
  'last_name': ?instance.lastName,
  'fathers_name': ?instance.fathersName,
  'email': ?instance.email,
  'phone_number': ?instance.phoneNumber,
  'address': ?instance.address,
  'password': ?instance.password,
  're_password': ?instance.rePassword,
  'shelter': ?UserShelterWorkerSerializers._write_shelter(instance.shelter),
  'role': ?UserShelterWorkerSerializers._write_role(instance.role),
  'is_offer_signed': ?instance.isOfferSigned,
};
