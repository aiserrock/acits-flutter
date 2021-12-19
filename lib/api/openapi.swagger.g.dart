// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openapi.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Animal _$AnimalFromJson(Map<String, dynamic> json) => Animal(
      id: json['id'] as int?,
      url: json['url'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      avatarFilename: json['avatar_filename'] as String?,
      spec: json['spec'],
      specId: json['spec_id'] as int?,
      status: status131EnumFromJson(json['status'] as String?),
      dateJoined: json['date_joined'] == null
          ? null
          : DateTime.parse(json['date_joined'] as String),
      birthDate: json['birth_date'] == null
          ? null
          : DateTime.parse(json['birth_date'] as String),
      deathDate: json['death_date'] == null
          ? null
          : DateTime.parse(json['death_date'] as String),
      deathReason: json['death_reason'] as String?,
      placeOfCatch: json['place_of_catch'] as String?,
      placeOfRelease: json['place_of_release'] as String?,
      dateOfChipping: json['date_of_chipping'] == null
          ? null
          : DateTime.parse(json['date_of_chipping'] as String),
      chippingCode: json['chipping_code'] as String?,
      height: json['height'] as String?,
      weight: json['weight'] as String?,
      hasDocuments: json['has_documents'] as bool?,
      shelter: json['shelter'] as int?,
      curator: json['curator'],
      curatorId: json['curator_id'] as int?,
      applicant: json['applicant'],
      applicantId: json['applicant_id'] as int?,
      animalAttributes: (json['animal_attributes'] as List<dynamic>?)
              ?.map((e) =>
                  AnimalAttributeValue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
    );

Map<String, dynamic> _$AnimalToJson(Animal instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'name': instance.name,
      'avatar': instance.avatar,
      'avatar_filename': instance.avatarFilename,
      'spec': instance.spec,
      'spec_id': instance.specId,
      'status': status131EnumToJson(instance.status),
      'date_joined': instance.dateJoined?.toIso8601String(),
      'birth_date': _dateToJson(instance.birthDate),
      'death_date': _dateToJson(instance.deathDate),
      'death_reason': instance.deathReason,
      'place_of_catch': instance.placeOfCatch,
      'place_of_release': instance.placeOfRelease,
      'date_of_chipping': _dateToJson(instance.dateOfChipping),
      'chipping_code': instance.chippingCode,
      'height': instance.height,
      'weight': instance.weight,
      'has_documents': instance.hasDocuments,
      'shelter': instance.shelter,
      'curator': instance.curator,
      'curator_id': instance.curatorId,
      'applicant': instance.applicant,
      'applicant_id': instance.applicantId,
      'animal_attributes':
          instance.animalAttributes?.map((e) => e.toJson()).toList(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
    };

AnimalAttribute _$AnimalAttributeFromJson(Map<String, dynamic> json) =>
    AnimalAttribute(
      id: json['id'] as int?,
      name: json['name'] as String?,
      isRequired: json['is_required'] as bool?,
    );

Map<String, dynamic> _$AnimalAttributeToJson(AnimalAttribute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_required': instance.isRequired,
    };

AnimalAttributeValue _$AnimalAttributeValueFromJson(
        Map<String, dynamic> json) =>
    AnimalAttributeValue(
      attrId: json['attr_id'] as int?,
      name: json['name'] as String?,
      value: json['value'] as String?,
      isRequired: json['is_required'] as bool?,
    );

Map<String, dynamic> _$AnimalAttributeValueToJson(
        AnimalAttributeValue instance) =>
    <String, dynamic>{
      'attr_id': instance.attrId,
      'name': instance.name,
      'value': instance.value,
      'is_required': instance.isRequired,
    };

AnimalHistorySnapshot _$AnimalHistorySnapshotFromJson(
        Map<String, dynamic> json) =>
    AnimalHistorySnapshot(
      animal: json['animal'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      status: status131EnumFromJson(json['status'] as String?),
      height: json['height'] as String?,
      weight: json['weight'] as String?,
      shelterName: json['shelter_name'] as String?,
      editor: json['editor'] as String?,
    );

Map<String, dynamic> _$AnimalHistorySnapshotToJson(
        AnimalHistorySnapshot instance) =>
    <String, dynamic>{
      'animal': instance.animal,
      'created_at': instance.createdAt?.toIso8601String(),
      'status': status131EnumToJson(instance.status),
      'height': instance.height,
      'weight': instance.weight,
      'shelter_name': instance.shelterName,
      'editor': instance.editor,
    };

AnimalNote _$AnimalNoteFromJson(Map<String, dynamic> json) => AnimalNote(
      id: json['id'] as int?,
      url: json['url'] as String?,
      animal: json['animal'] as int?,
      content: json['content'] as String?,
      files: (json['files'] as List<dynamic>?)
              ?.map((e) => AnimalNoteFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      isUserCanEditOrDelete: json['is_user_can_edit_or_delete'] as bool?,
    );

Map<String, dynamic> _$AnimalNoteToJson(AnimalNote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'animal': instance.animal,
      'content': instance.content,
      'files': instance.files?.map((e) => e.toJson()).toList(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'is_user_can_edit_or_delete': instance.isUserCanEditOrDelete,
    };

AnimalNoteFile _$AnimalNoteFileFromJson(Map<String, dynamic> json) =>
    AnimalNoteFile(
      id: json['id'] as int?,
      file: json['file'] as String?,
      name: json['name'] as String?,
      filename: json['filename'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AnimalNoteFileToJson(AnimalNoteFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'file': instance.file,
      'name': instance.name,
      'filename': instance.filename,
      'created_at': instance.createdAt?.toIso8601String(),
    };

AnimalPrescription _$AnimalPrescriptionFromJson(Map<String, dynamic> json) =>
    AnimalPrescription(
      id: json['id'] as int?,
      myType: myTypeEnumFromJson(json['my_type'] as String?),
      duration: durationEnumFromJson(json['duration'] as String?),
      description: json['description'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      drugs: (json['drugs'] as List<dynamic>?)
              ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      executions: (json['executions'] as List<dynamic>?)
              ?.map((e) =>
                  PrescriptionExecution.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AnimalPrescriptionToJson(AnimalPrescription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'my_type': myTypeEnumToJson(instance.myType),
      'duration': durationEnumToJson(instance.duration),
      'description': instance.description,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'drugs': instance.drugs?.map((e) => e.toJson()).toList(),
      'executions': instance.executions?.map((e) => e.toJson()).toList(),
    };

Applicant _$ApplicantFromJson(Map<String, dynamic> json) => Applicant(
      id: json['id'] as int?,
      url: json['url'] as String?,
      shelter: json['shelter'] as int?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      contactDetails: json['contact_details'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      animalId: json['animal_id'] as int?,
      applicantFiles: (json['applicant_files'] as List<dynamic>?)
              ?.map((e) => ApplicantFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ApplicantToJson(Applicant instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'shelter': instance.shelter,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'contact_details': instance.contactDetails,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'animal_id': instance.animalId,
      'applicant_files':
          instance.applicantFiles?.map((e) => e.toJson()).toList(),
    };

ApplicantFile _$ApplicantFileFromJson(Map<String, dynamic> json) =>
    ApplicantFile(
      id: json['id'] as int?,
      file: json['file'] as String?,
      name: json['name'] as String?,
      filename: json['filename'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ApplicantFileToJson(ApplicantFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'file': instance.file,
      'name': instance.name,
      'filename': instance.filename,
      'created_at': instance.createdAt?.toIso8601String(),
    };

Approve _$ApproveFromJson(Map<String, dynamic> json) => Approve(
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ApproveToJson(Approve instance) => <String, dynamic>{
      'status': instance.status,
    };

Curator _$CuratorFromJson(Map<String, dynamic> json) => Curator(
      id: json['id'] as int?,
      url: json['url'] as String?,
      shelter: json['shelter'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$CuratorToJson(Curator instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'shelter': instance.shelter,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
    };

Decline _$DeclineFromJson(Map<String, dynamic> json) => Decline(
      status: json['status'] as String?,
    );

Map<String, dynamic> _$DeclineToJson(Decline instance) => <String, dynamic>{
      'status': instance.status,
    };

Drug _$DrugFromJson(Map<String, dynamic> json) => Drug(
      id: json['id'] as int?,
      name: json['name'] as String?,
      usageInstruction: json['usage_instruction'] as String?,
      formOfDrug: json['form_of_drug'] as int?,
      formOfDrugName: json['form_of_drug_name'] as String?,
    );

Map<String, dynamic> _$DrugToJson(Drug instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'usage_instruction': instance.usageInstruction,
      'form_of_drug': instance.formOfDrug,
      'form_of_drug_name': instance.formOfDrugName,
    };

Feedback _$FeedbackFromJson(Map<String, dynamic> json) => Feedback(
      shelterId: json['shelter_id'] as int?,
      shelterName: json['shelter_name'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      action: json['action'] as String?,
      email: json['email'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
      'shelter_id': instance.shelterId,
      'shelter_name': instance.shelterName,
      'date': _dateToJson(instance.date),
      'action': instance.action,
      'email': instance.email,
      'message': instance.message,
    };

PaginatedAnimalHistorySnapshotList _$PaginatedAnimalHistorySnapshotListFromJson(
        Map<String, dynamic> json) =>
    PaginatedAnimalHistorySnapshotList(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) =>
                  AnimalHistorySnapshot.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PaginatedAnimalHistorySnapshotListToJson(
        PaginatedAnimalHistorySnapshotList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results?.map((e) => e.toJson()).toList(),
    };

PaginatedAnimalList _$PaginatedAnimalListFromJson(Map<String, dynamic> json) =>
    PaginatedAnimalList(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => Animal.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PaginatedAnimalListToJson(
        PaginatedAnimalList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results?.map((e) => e.toJson()).toList(),
    };

PaginatedAnimalNoteList _$PaginatedAnimalNoteListFromJson(
        Map<String, dynamic> json) =>
    PaginatedAnimalNoteList(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => AnimalNote.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PaginatedAnimalNoteListToJson(
        PaginatedAnimalNoteList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results?.map((e) => e.toJson()).toList(),
    };

PaginatedAnimalPrescriptionList _$PaginatedAnimalPrescriptionListFromJson(
        Map<String, dynamic> json) =>
    PaginatedAnimalPrescriptionList(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
              ?.map(
                  (e) => AnimalPrescription.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PaginatedAnimalPrescriptionListToJson(
        PaginatedAnimalPrescriptionList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results?.map((e) => e.toJson()).toList(),
    };

PaginatedApplicantList _$PaginatedApplicantListFromJson(
        Map<String, dynamic> json) =>
    PaginatedApplicantList(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => Applicant.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PaginatedApplicantListToJson(
        PaginatedApplicantList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results?.map((e) => e.toJson()).toList(),
    };

PaginatedCuratorList _$PaginatedCuratorListFromJson(
        Map<String, dynamic> json) =>
    PaginatedCuratorList(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => Curator.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PaginatedCuratorListToJson(
        PaginatedCuratorList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results?.map((e) => e.toJson()).toList(),
    };

PaginatedPrescriptionExecutionTodayList
    _$PaginatedPrescriptionExecutionTodayListFromJson(
            Map<String, dynamic> json) =>
        PaginatedPrescriptionExecutionTodayList(
          count: json['count'] as int?,
          next: json['next'] as String?,
          previous: json['previous'] as String?,
          results: (json['results'] as List<dynamic>?)
                  ?.map((e) => PrescriptionExecutionToday.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              [],
        );

Map<String, dynamic> _$PaginatedPrescriptionExecutionTodayListToJson(
        PaginatedPrescriptionExecutionTodayList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results?.map((e) => e.toJson()).toList(),
    };

PaginatedPrescriptionList _$PaginatedPrescriptionListFromJson(
        Map<String, dynamic> json) =>
    PaginatedPrescriptionList(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => Prescription.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PaginatedPrescriptionListToJson(
        PaginatedPrescriptionList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results?.map((e) => e.toJson()).toList(),
    };

PaginatedShelterDrugList _$PaginatedShelterDrugListFromJson(
        Map<String, dynamic> json) =>
    PaginatedShelterDrugList(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => ShelterDrug.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PaginatedShelterDrugListToJson(
        PaginatedShelterDrugList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results?.map((e) => e.toJson()).toList(),
    };

PaginatedShelterShortSerializersList
    _$PaginatedShelterShortSerializersListFromJson(Map<String, dynamic> json) =>
        PaginatedShelterShortSerializersList(
          count: json['count'] as int?,
          next: json['next'] as String?,
          previous: json['previous'] as String?,
          results: (json['results'] as List<dynamic>?)
                  ?.map((e) => ShelterShortSerializers.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              [],
        );

Map<String, dynamic> _$PaginatedShelterShortSerializersListToJson(
        PaginatedShelterShortSerializersList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results?.map((e) => e.toJson()).toList(),
    };

PaginatedSpeciesList _$PaginatedSpeciesListFromJson(
        Map<String, dynamic> json) =>
    PaginatedSpeciesList(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => Species.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PaginatedSpeciesListToJson(
        PaginatedSpeciesList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results?.map((e) => e.toJson()).toList(),
    };

PaginatedUserSheltersAdminSerializersList
    _$PaginatedUserSheltersAdminSerializersListFromJson(
            Map<String, dynamic> json) =>
        PaginatedUserSheltersAdminSerializersList(
          count: json['count'] as int?,
          next: json['next'] as String?,
          previous: json['previous'] as String?,
          results: (json['results'] as List<dynamic>?)
                  ?.map((e) => UserSheltersAdminSerializers.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              [],
        );

Map<String, dynamic> _$PaginatedUserSheltersAdminSerializersListToJson(
        PaginatedUserSheltersAdminSerializersList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results?.map((e) => e.toJson()).toList(),
    };

PaginatedUserShortSerializersList _$PaginatedUserShortSerializersListFromJson(
        Map<String, dynamic> json) =>
    PaginatedUserShortSerializersList(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) =>
                  UserShortSerializers.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PaginatedUserShortSerializersListToJson(
        PaginatedUserShortSerializersList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results?.map((e) => e.toJson()).toList(),
    };

PatchedAnimal _$PatchedAnimalFromJson(Map<String, dynamic> json) =>
    PatchedAnimal(
      id: json['id'] as int?,
      url: json['url'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      avatarFilename: json['avatar_filename'] as String?,
      spec: json['spec'],
      specId: json['spec_id'] as int?,
      status: status131EnumFromJson(json['status'] as String?),
      dateJoined: json['date_joined'] == null
          ? null
          : DateTime.parse(json['date_joined'] as String),
      birthDate: json['birth_date'] == null
          ? null
          : DateTime.parse(json['birth_date'] as String),
      deathDate: json['death_date'] == null
          ? null
          : DateTime.parse(json['death_date'] as String),
      deathReason: json['death_reason'] as String?,
      placeOfCatch: json['place_of_catch'] as String?,
      placeOfRelease: json['place_of_release'] as String?,
      dateOfChipping: json['date_of_chipping'] == null
          ? null
          : DateTime.parse(json['date_of_chipping'] as String),
      chippingCode: json['chipping_code'] as String?,
      height: json['height'] as String?,
      weight: json['weight'] as String?,
      hasDocuments: json['has_documents'] as bool?,
      shelter: json['shelter'] as int?,
      curator: json['curator'],
      curatorId: json['curator_id'] as int?,
      applicant: json['applicant'],
      applicantId: json['applicant_id'] as int?,
      animalAttributes: (json['animal_attributes'] as List<dynamic>?)
              ?.map((e) =>
                  AnimalAttributeValue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
    );

Map<String, dynamic> _$PatchedAnimalToJson(PatchedAnimal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'name': instance.name,
      'avatar': instance.avatar,
      'avatar_filename': instance.avatarFilename,
      'spec': instance.spec,
      'spec_id': instance.specId,
      'status': status131EnumToJson(instance.status),
      'date_joined': instance.dateJoined?.toIso8601String(),
      'birth_date': _dateToJson(instance.birthDate),
      'death_date': _dateToJson(instance.deathDate),
      'death_reason': instance.deathReason,
      'place_of_catch': instance.placeOfCatch,
      'place_of_release': instance.placeOfRelease,
      'date_of_chipping': _dateToJson(instance.dateOfChipping),
      'chipping_code': instance.chippingCode,
      'height': instance.height,
      'weight': instance.weight,
      'has_documents': instance.hasDocuments,
      'shelter': instance.shelter,
      'curator': instance.curator,
      'curator_id': instance.curatorId,
      'applicant': instance.applicant,
      'applicant_id': instance.applicantId,
      'animal_attributes':
          instance.animalAttributes?.map((e) => e.toJson()).toList(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
    };

PatchedAnimalNote _$PatchedAnimalNoteFromJson(Map<String, dynamic> json) =>
    PatchedAnimalNote(
      id: json['id'] as int?,
      url: json['url'] as String?,
      animal: json['animal'] as int?,
      content: json['content'] as String?,
      files: (json['files'] as List<dynamic>?)
              ?.map((e) => AnimalNoteFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      isUserCanEditOrDelete: json['is_user_can_edit_or_delete'] as bool?,
    );

Map<String, dynamic> _$PatchedAnimalNoteToJson(PatchedAnimalNote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'animal': instance.animal,
      'content': instance.content,
      'files': instance.files?.map((e) => e.toJson()).toList(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'is_user_can_edit_or_delete': instance.isUserCanEditOrDelete,
    };

PatchedApplicant _$PatchedApplicantFromJson(Map<String, dynamic> json) =>
    PatchedApplicant(
      id: json['id'] as int?,
      url: json['url'] as String?,
      shelter: json['shelter'] as int?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      contactDetails: json['contact_details'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      animalId: json['animal_id'] as int?,
      applicantFiles: (json['applicant_files'] as List<dynamic>?)
              ?.map((e) => ApplicantFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PatchedApplicantToJson(PatchedApplicant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'shelter': instance.shelter,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'contact_details': instance.contactDetails,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'animal_id': instance.animalId,
      'applicant_files':
          instance.applicantFiles?.map((e) => e.toJson()).toList(),
    };

PatchedCurator _$PatchedCuratorFromJson(Map<String, dynamic> json) =>
    PatchedCurator(
      id: json['id'] as int?,
      url: json['url'] as String?,
      shelter: json['shelter'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$PatchedCuratorToJson(PatchedCurator instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'shelter': instance.shelter,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
    };

PatchedPrescription _$PatchedPrescriptionFromJson(Map<String, dynamic> json) =>
    PatchedPrescription(
      id: json['id'] as int?,
      url: json['url'] as String?,
      animal: json['animal'] as int?,
      myType: myTypeEnumFromJson(json['my_type'] as String?),
      duration: durationEnumFromJson(json['duration'] as String?),
      description: json['description'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      drugs: (json['drugs'] as List<dynamic>?)
              ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      executions: (json['executions'] as List<dynamic>?)
              ?.map((e) =>
                  PrescriptionExecution.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      files: (json['files'] as List<dynamic>?)
              ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PatchedPrescriptionToJson(
        PatchedPrescription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'animal': instance.animal,
      'my_type': myTypeEnumToJson(instance.myType),
      'duration': durationEnumToJson(instance.duration),
      'description': instance.description,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'drugs': instance.drugs?.map((e) => e.toJson()).toList(),
      'executions': instance.executions?.map((e) => e.toJson()).toList(),
      'files': instance.files?.map((e) => e.toJson()).toList(),
    };

PatchedUserChangePasswordSerializers
    _$PatchedUserChangePasswordSerializersFromJson(Map<String, dynamic> json) =>
        PatchedUserChangePasswordSerializers(
          id: json['id'] as int?,
          password: json['password'] as String?,
          rePassword: json['re_password'] as String?,
          oldPassword: json['old_password'] as String?,
        );

Map<String, dynamic> _$PatchedUserChangePasswordSerializersToJson(
        PatchedUserChangePasswordSerializers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'password': instance.password,
      're_password': instance.rePassword,
      'old_password': instance.oldPassword,
    };

PatchedUserSerializers _$PatchedUserSerializersFromJson(
        Map<String, dynamic> json) =>
    PatchedUserSerializers(
      id: json['id'] as int?,
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
    );

Map<String, dynamic> _$PatchedUserSerializersToJson(
        PatchedUserSerializers instance) =>
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
    };

PatchedUserSheltersAdminSerializers
    _$PatchedUserSheltersAdminSerializersFromJson(Map<String, dynamic> json) =>
        PatchedUserSheltersAdminSerializers(
          id: json['id'] as int?,
          user: json['user'],
          userId: json['user_id'] as int?,
          role: roleEnumFromJson(json['role'] as String?),
          isVerifiedByAdmin: json['is_verified_by_admin'] as bool?,
        );

Map<String, dynamic> _$PatchedUserSheltersAdminSerializersToJson(
        PatchedUserSheltersAdminSerializers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'user_id': instance.userId,
      'role': roleEnumToJson(instance.role),
      'is_verified_by_admin': instance.isVerifiedByAdmin,
    };

Prescription _$PrescriptionFromJson(Map<String, dynamic> json) => Prescription(
      id: json['id'] as int?,
      url: json['url'] as String?,
      animal: json['animal'] as int?,
      myType: myTypeEnumFromJson(json['my_type'] as String?),
      duration: durationEnumFromJson(json['duration'] as String?),
      description: json['description'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      drugs: (json['drugs'] as List<dynamic>?)
              ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      executions: (json['executions'] as List<dynamic>?)
              ?.map((e) =>
                  PrescriptionExecution.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      files: (json['files'] as List<dynamic>?)
              ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PrescriptionToJson(Prescription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'animal': instance.animal,
      'my_type': myTypeEnumToJson(instance.myType),
      'duration': durationEnumToJson(instance.duration),
      'description': instance.description,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'drugs': instance.drugs?.map((e) => e.toJson()).toList(),
      'executions': instance.executions?.map((e) => e.toJson()).toList(),
      'files': instance.files?.map((e) => e.toJson()).toList(),
    };

PrescriptionAnimal _$PrescriptionAnimalFromJson(Map<String, dynamic> json) =>
    PrescriptionAnimal(
      id: json['id'] as int?,
      name: json['name'] as String?,
      specName: json['spec_name'] as String?,
      specParentName: json['spec_parent_name'] as String?,
    );

Map<String, dynamic> _$PrescriptionAnimalToJson(PrescriptionAnimal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'spec_name': instance.specName,
      'spec_parent_name': instance.specParentName,
    };

PrescriptionDrug _$PrescriptionDrugFromJson(Map<String, dynamic> json) =>
    PrescriptionDrug(
      drugId: json['drug_id'] as int?,
      drugName: json['drug_name'] as String?,
      usageInstruction: json['usage_instruction'] as String?,
      formOfDrug: json['form_of_drug'] as String?,
      drugDosage: (json['drug_dosage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PrescriptionDrugToJson(PrescriptionDrug instance) =>
    <String, dynamic>{
      'drug_id': instance.drugId,
      'drug_name': instance.drugName,
      'usage_instruction': instance.usageInstruction,
      'form_of_drug': instance.formOfDrug,
      'drug_dosage': instance.drugDosage,
    };

PrescriptionExecution _$PrescriptionExecutionFromJson(
        Map<String, dynamic> json) =>
    PrescriptionExecution(
      id: json['id'] as int?,
      executeAt: json['execute_at'] == null
          ? null
          : DateTime.parse(json['execute_at'] as String),
      status: json['status'],
    );

Map<String, dynamic> _$PrescriptionExecutionToJson(
        PrescriptionExecution instance) =>
    <String, dynamic>{
      'id': instance.id,
      'execute_at': instance.executeAt?.toIso8601String(),
      'status': instance.status,
    };

PrescriptionExecutionToday _$PrescriptionExecutionTodayFromJson(
        Map<String, dynamic> json) =>
    PrescriptionExecutionToday(
      prescription: json['prescription'] as int?,
      animal: json['animal'] == null
          ? null
          : PrescriptionAnimal.fromJson(json['animal'] as Map<String, dynamic>),
      myType: myTypeEnumFromJson(json['my_type'] as String?),
      drugs: (json['drugs'] as List<dynamic>?)
              ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      description: json['description'] as String?,
      executeAt: json['execute_at'] == null
          ? null
          : DateTime.parse(json['execute_at'] as String),
    );

Map<String, dynamic> _$PrescriptionExecutionTodayToJson(
        PrescriptionExecutionToday instance) =>
    <String, dynamic>{
      'prescription': instance.prescription,
      'animal': instance.animal?.toJson(),
      'my_type': myTypeEnumToJson(instance.myType),
      'drugs': instance.drugs?.map((e) => e.toJson()).toList(),
      'description': instance.description,
      'execute_at': instance.executeAt?.toIso8601String(),
    };

PrescriptionFile _$PrescriptionFileFromJson(Map<String, dynamic> json) =>
    PrescriptionFile(
      id: json['id'] as int?,
      file: json['file'] as String?,
      name: json['name'] as String?,
      filename: json['filename'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$PrescriptionFileToJson(PrescriptionFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'file': instance.file,
      'name': instance.name,
      'filename': instance.filename,
      'created_at': instance.createdAt?.toIso8601String(),
    };

ShelterDrug _$ShelterDrugFromJson(Map<String, dynamic> json) => ShelterDrug(
      drug: json['drug'] == null
          ? null
          : Drug.fromJson(json['drug'] as Map<String, dynamic>),
      drugResiduesCount: json['drug_residues_count'] as int?,
    );

Map<String, dynamic> _$ShelterDrugToJson(ShelterDrug instance) =>
    <String, dynamic>{
      'drug': instance.drug?.toJson(),
      'drug_residues_count': instance.drugResiduesCount,
    };

ShelterSerializers _$ShelterSerializersFromJson(Map<String, dynamic> json) =>
    ShelterSerializers(
      name: json['name'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      region: json['region'] as String?,
      street: json['street'] as String?,
      house: json['house'] as String?,
      apartment: json['apartment'] as String?,
    );

Map<String, dynamic> _$ShelterSerializersToJson(ShelterSerializers instance) =>
    <String, dynamic>{
      'name': instance.name,
      'country': instance.country,
      'city': instance.city,
      'state': instance.state,
      'region': instance.region,
      'street': instance.street,
      'house': instance.house,
      'apartment': instance.apartment,
    };

ShelterShortSerializers _$ShelterShortSerializersFromJson(
        Map<String, dynamic> json) =>
    ShelterShortSerializers(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ShelterShortSerializersToJson(
        ShelterShortSerializers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Species _$SpeciesFromJson(Map<String, dynamic> json) => Species(
      id: json['id'] as int?,
      name: json['name'] as String?,
      level: json['level'],
      parentId: json['parent_id'] as int?,
      parentName: json['parent_name'] as String?,
      categoryName: json['category_name'] as String?,
    );

Map<String, dynamic> _$SpeciesToJson(Species instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'level': instance.level,
      'parent_id': instance.parentId,
      'parent_name': instance.parentName,
      'category_name': instance.categoryName,
    };

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
      status: json['status'] as String?,
    );

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'status': instance.status,
    };

TokenObtainPair _$TokenObtainPairFromJson(Map<String, dynamic> json) =>
    TokenObtainPair(
      username: json['username'] as String?,
      password: json['password'] as String?,
      access: json['access'] as String?,
      refresh: json['refresh'] as String?,
    );

Map<String, dynamic> _$TokenObtainPairToJson(TokenObtainPair instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'access': instance.access,
      'refresh': instance.refresh,
    };

TokenRefresh _$TokenRefreshFromJson(Map<String, dynamic> json) => TokenRefresh(
      access: json['access'] as String?,
      refresh: json['refresh'] as String?,
    );

Map<String, dynamic> _$TokenRefreshToJson(TokenRefresh instance) =>
    <String, dynamic>{
      'access': instance.access,
      'refresh': instance.refresh,
    };

UserChangePasswordSerializers _$UserChangePasswordSerializersFromJson(
        Map<String, dynamic> json) =>
    UserChangePasswordSerializers(
      id: json['id'] as int?,
      password: json['password'] as String?,
      rePassword: json['re_password'] as String?,
      oldPassword: json['old_password'] as String?,
    );

Map<String, dynamic> _$UserChangePasswordSerializersToJson(
        UserChangePasswordSerializers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'password': instance.password,
      're_password': instance.rePassword,
      'old_password': instance.oldPassword,
    };

UserCurrentShelterSerializers _$UserCurrentShelterSerializersFromJson(
        Map<String, dynamic> json) =>
    UserCurrentShelterSerializers(
      currentShelter: json['current_shelter'] as int?,
      currentShelterUserRole: json['current_shelter_user_role'] as String?,
      isUserCanEdit: json['is_user_can_edit'] as bool?,
      isUserCanDelete: json['is_user_can_delete'] as bool?,
    );

Map<String, dynamic> _$UserCurrentShelterSerializersToJson(
        UserCurrentShelterSerializers instance) =>
    <String, dynamic>{
      'current_shelter': instance.currentShelter,
      'current_shelter_user_role': instance.currentShelterUserRole,
      'is_user_can_edit': instance.isUserCanEdit,
      'is_user_can_delete': instance.isUserCanDelete,
    };

UserSerializers _$UserSerializersFromJson(Map<String, dynamic> json) =>
    UserSerializers(
      id: json['id'] as int?,
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
    };

UserShelterAdminSerializers _$UserShelterAdminSerializersFromJson(
        Map<String, dynamic> json) =>
    UserShelterAdminSerializers(
      id: json['id'] as int?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      fathersName: json['fathers_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
      password: json['password'] as String?,
      rePassword: json['re_password'] as String?,
      shelter: json['shelter'],
    );

Map<String, dynamic> _$UserShelterAdminSerializersToJson(
        UserShelterAdminSerializers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'fathers_name': instance.fathersName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
      'password': instance.password,
      're_password': instance.rePassword,
      'shelter': instance.shelter,
    };

UserShelterWorkerSerializers _$UserShelterWorkerSerializersFromJson(
        Map<String, dynamic> json) =>
    UserShelterWorkerSerializers(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      fathersName: json['fathers_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
      password: json['password'] as String?,
      rePassword: json['re_password'] as String?,
      shelter: json['shelter'] as int?,
      role: json['role'],
    );

Map<String, dynamic> _$UserShelterWorkerSerializersToJson(
        UserShelterWorkerSerializers instance) =>
    <String, dynamic>{
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
    };

UserSheltersAdminSerializers _$UserSheltersAdminSerializersFromJson(
        Map<String, dynamic> json) =>
    UserSheltersAdminSerializers(
      id: json['id'] as int?,
      user: json['user'],
      userId: json['user_id'] as int?,
      role: roleEnumFromJson(json['role'] as String?),
      isVerifiedByAdmin: json['is_verified_by_admin'] as bool?,
    );

Map<String, dynamic> _$UserSheltersAdminSerializersToJson(
        UserSheltersAdminSerializers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'user_id': instance.userId,
      'role': roleEnumToJson(instance.role),
      'is_verified_by_admin': instance.isVerifiedByAdmin,
    };

UserSheltersWorkerSerializers _$UserSheltersWorkerSerializersFromJson(
        Map<String, dynamic> json) =>
    UserSheltersWorkerSerializers(
      shelter: json['shelter'] as int?,
      role: roleEnumFromJson(json['role'] as String?),
    );

Map<String, dynamic> _$UserSheltersWorkerSerializersToJson(
        UserSheltersWorkerSerializers instance) =>
    <String, dynamic>{
      'shelter': instance.shelter,
      'role': roleEnumToJson(instance.role),
    };

UserShortSerializers _$UserShortSerializersFromJson(
        Map<String, dynamic> json) =>
    UserShortSerializers(
      id: json['id'] as int?,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$UserShortSerializersToJson(
        UserShortSerializers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
    };

ValuesForSelection _$ValuesForSelectionFromJson(Map<String, dynamic> json) =>
    ValuesForSelection(
      choicesName: (json['choices_name'] as List<dynamic>?)
              ?.map((e) =>
                  ValuesForSelectionItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ValuesForSelectionToJson(ValuesForSelection instance) =>
    <String, dynamic>{
      'choices_name': instance.choicesName?.map((e) => e.toJson()).toList(),
    };

ValuesForSelectionItem _$ValuesForSelectionItemFromJson(
        Map<String, dynamic> json) =>
    ValuesForSelectionItem(
      displayName: json['display_name'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$ValuesForSelectionItemToJson(
        ValuesForSelectionItem instance) =>
    <String, dynamic>{
      'display_name': instance.displayName,
      'value': instance.value,
    };
