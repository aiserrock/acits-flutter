// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSerializers _$UserSerializersFromJson(Map<String, dynamic> json) =>
    UserSerializers(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      fathersName: json['fathers_name'] as String?,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
      dateJoined: json['date_joined'] == null
          ? null
          : DateTime.parse(json['date_joined'] as String),
      isVerified: json['is_verified'] as bool?,
      isOfferSigned: json['is_offer_signed'] as bool?,
    );

Map<String, dynamic> _$UserSerializersToJson(UserSerializers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'fathers_name': instance.fathersName,
      'full_name': instance.fullName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
      'date_joined': instance.dateJoined?.toIso8601String(),
      'is_verified': instance.isVerified,
      'is_offer_signed': instance.isOfferSigned,
    };
