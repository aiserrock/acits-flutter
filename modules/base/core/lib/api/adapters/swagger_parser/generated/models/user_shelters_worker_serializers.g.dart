// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_shelters_worker_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSheltersWorkerSerializers _$UserSheltersWorkerSerializersFromJson(
  Map<String, dynamic> json,
) => UserSheltersWorkerSerializers(
  shelter: (json['shelter'] as num?)?.toInt(),
  role: json['role'] == null ? null : RoleEnum.fromJson(json['role'] as String),
);

Map<String, dynamic> _$UserSheltersWorkerSerializersToJson(
  UserSheltersWorkerSerializers instance,
) => <String, dynamic>{'shelter': instance.shelter, 'role': instance.role};
