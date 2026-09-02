// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelter_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShelterSerializers _$ShelterSerializersFromJson(Map<String, dynamic> json) =>
    ShelterSerializers(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      region: json['region'] as String?,
      street: json['street'] as String?,
      house: json['house'] as String?,
      apartment: json['apartment'] as String?,
      officialName: json['official_name'] as String?,
      ogrn: json['ogrn'] as String?,
      inn: json['inn'] as String?,
      kpp: json['kpp'] as String?,
      organizationEmail: json['organization_email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      websiteLink: json['website_link'] as String?,
      positionOfManager: json['position_of_manager'] as String?,
      firstNameOfManager: json['first_name_of_manager'] as String?,
      lastNameOfManager: json['last_name_of_manager'] as String?,
      middleNameOfManager: json['middle_name_of_manager'] as String?,
      fullNameOfTheBank: json['full_name_of_the_bank'] as String?,
      shortBankName: json['short_bank_name'] as String?,
      fullEnglishBankName: json['full_english_bank_name'] as String?,
      legalAddressOfTheBank: json['legal_address_of_the_bank'] as String?,
      postalAddressOfTheBank: json['postal_address_of_the_bank'] as String?,
      correspondentAccountOfTheBank:
          json['correspondent_account_of_the_bank'] as String?,
      paymentAccountOfTheOrganization:
          json['payment_account_of_the_organization'] as String?,
      bicOfTheBank: json['bic_of_the_bank'] as String?,
    );

Map<String, dynamic> _$ShelterSerializersToJson(
  ShelterSerializers instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'country': instance.country,
  'city': instance.city,
  'state': instance.state,
  'region': instance.region,
  'street': instance.street,
  'house': instance.house,
  'apartment': instance.apartment,
  'official_name': instance.officialName,
  'ogrn': instance.ogrn,
  'inn': instance.inn,
  'kpp': instance.kpp,
  'organization_email': instance.organizationEmail,
  'phone_number': instance.phoneNumber,
  'website_link': instance.websiteLink,
  'position_of_manager': instance.positionOfManager,
  'first_name_of_manager': instance.firstNameOfManager,
  'last_name_of_manager': instance.lastNameOfManager,
  'middle_name_of_manager': instance.middleNameOfManager,
  'full_name_of_the_bank': instance.fullNameOfTheBank,
  'short_bank_name': instance.shortBankName,
  'full_english_bank_name': instance.fullEnglishBankName,
  'legal_address_of_the_bank': instance.legalAddressOfTheBank,
  'postal_address_of_the_bank': instance.postalAddressOfTheBank,
  'correspondent_account_of_the_bank': instance.correspondentAccountOfTheBank,
  'payment_account_of_the_organization':
      instance.paymentAccountOfTheOrganization,
  'bic_of_the_bank': instance.bicOfTheBank,
};
