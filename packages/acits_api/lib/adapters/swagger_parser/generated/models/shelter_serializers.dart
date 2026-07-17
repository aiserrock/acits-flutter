// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'shelter_serializers.g.dart';

/// Shelter serializer.
@JsonSerializable()
class ShelterSerializers {
  const ShelterSerializers({
    required this.id,
    required this.name,
    required this.country,
    required this.city,
    this.state,
    this.region,
    this.street,
    this.house,
    this.apartment,
    this.officialName,
    this.ogrn,
    this.inn,
    this.kpp,
    this.organizationEmail,
    this.phoneNumber,
    this.websiteLink,
    this.positionOfManager,
    this.firstNameOfManager,
    this.lastNameOfManager,
    this.middleNameOfManager,
    this.fullNameOfTheBank,
    this.shortBankName,
    this.fullEnglishBankName,
    this.legalAddressOfTheBank,
    this.postalAddressOfTheBank,
    this.correspondentAccountOfTheBank,
    this.paymentAccountOfTheOrganization,
    this.bicOfTheBank,
  });
  
  factory ShelterSerializers.fromJson(Map<String, Object?> json) => _$ShelterSerializersFromJson(json);
  
  final int id;
  final String name;

  /// Country where shelter is located
  final String country;

  /// City where shelter is located
  final String city;

  /// State where shelter is located
  final String? state;

  /// Region where shelter is located
  final String? region;

  /// Street where shelter is located
  final String? street;

  /// House where shelter is located
  final String? house;

  /// Apartment where shelter is located
  final String? apartment;
  @JsonKey(name: 'official_name')
  final String? officialName;
  final String? ogrn;
  final String? inn;
  final String? kpp;
  @JsonKey(name: 'organization_email')
  final String? organizationEmail;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'website_link')
  final String? websiteLink;
  @JsonKey(name: 'position_of_manager')
  final String? positionOfManager;
  @JsonKey(name: 'first_name_of_manager')
  final String? firstNameOfManager;
  @JsonKey(name: 'last_name_of_manager')
  final String? lastNameOfManager;
  @JsonKey(name: 'middle_name_of_manager')
  final String? middleNameOfManager;
  @JsonKey(name: 'full_name_of_the_bank')
  final String? fullNameOfTheBank;
  @JsonKey(name: 'short_bank_name')
  final String? shortBankName;
  @JsonKey(name: 'full_english_bank_name')
  final String? fullEnglishBankName;
  @JsonKey(name: 'legal_address_of_the_bank')
  final String? legalAddressOfTheBank;
  @JsonKey(name: 'postal_address_of_the_bank')
  final String? postalAddressOfTheBank;
  @JsonKey(name: 'correspondent_account_of_the_bank')
  final String? correspondentAccountOfTheBank;
  @JsonKey(name: 'payment_account_of_the_organization')
  final String? paymentAccountOfTheOrganization;
  @JsonKey(name: 'bic_of_the_bank')
  final String? bicOfTheBank;

  Map<String, Object?> toJson() => _$ShelterSerializersToJson(this);
}
