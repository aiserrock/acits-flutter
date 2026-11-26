// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_shelters_worker_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSheltersWorkerSerializers _$UserSheltersWorkerSerializersFromJson(
  Map<String, dynamic> json,
) => UserSheltersWorkerSerializers(
  shelter: UserSheltersWorkerSerializers._read_shelter(json['shelter']),
  role: UserSheltersWorkerSerializers._read_role(json['role']),
  additionalProperties:
      UserSheltersWorkerSerializers._extras(json, 'additionalProperties') ==
          null
      ? const {}
      : UserSheltersWorkerSerializers._readExtras(
          UserSheltersWorkerSerializers._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$UserSheltersWorkerSerializersToJson(
  UserSheltersWorkerSerializers instance,
) => <String, dynamic>{
  'shelter': ?UserSheltersWorkerSerializers._write_shelter(instance.shelter),
  'role': ?UserSheltersWorkerSerializers._write_role(instance.role),
};
