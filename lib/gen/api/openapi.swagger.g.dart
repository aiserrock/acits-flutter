// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openapi.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Adopter _$AdopterFromJson(Map<String, dynamic> json) => Adopter(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  shelter: json['shelter'] as String?,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phone_number'] as String,
  address: json['address'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$AdopterToJson(Adopter instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'shelter': instance.shelter,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'email': instance.email,
  'phone_number': instance.phoneNumber,
  'address': instance.address,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};

Adoption _$AdoptionFromJson(Map<String, dynamic> json) => Adoption(
  startDate: json['start_date'] == null
      ? null
      : DateTime.parse(json['start_date'] as String),
  endDate: json['end_date'] == null
      ? null
      : DateTime.parse(json['end_date'] as String),
  adopter: (json['adopter'] as num?)?.toInt(),
);

Map<String, dynamic> _$AdoptionToJson(Adoption instance) => <String, dynamic>{
  'start_date': _dateToJson(instance.startDate),
  'end_date': _dateToJson(instance.endDate),
  'adopter': instance.adopter,
};

AnalysisPrescription _$AnalysisPrescriptionFromJson(
  Map<String, dynamic> json,
) => AnalysisPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num).toInt(),
  myType: analysisPrescriptionMyTypeEnumFromJson(json['my_type']),
  duration: durationEnumNullableFromJson(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs:
      (json['drugs'] as List<dynamic>?)
          ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  executions:
      (json['executions'] as List<dynamic>?)
          ?.map(
            (e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  files:
      (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$AnalysisPrescriptionToJson(
  AnalysisPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'my_type': analysisPrescriptionMyTypeEnumToJson(instance.myType),
  'duration': durationEnumNullableToJson(instance.duration),
  'description': instance.description,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'drugs': instance.drugs.map((e) => e.toJson()).toList(),
  'executions': instance.executions.map((e) => e.toJson()).toList(),
  'files': instance.files?.map((e) => e.toJson()).toList(),
};

AnimalAttribute _$AnimalAttributeFromJson(Map<String, dynamic> json) =>
    AnimalAttribute(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      isRequired: json['is_required'] as bool?,
    );

Map<String, dynamic> _$AnimalAttributeToJson(AnimalAttribute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_required': instance.isRequired,
    };

AnimalAttributeValue _$AnimalAttributeValueFromJson(
  Map<String, dynamic> json,
) => AnimalAttributeValue(
  attrId: (json['attr_id'] as num).toInt(),
  name: json['name'] as String,
  value: json['value'] as String,
  isRequired: json['is_required'] as bool?,
);

Map<String, dynamic> _$AnimalAttributeValueToJson(
  AnimalAttributeValue instance,
) => <String, dynamic>{
  'attr_id': instance.attrId,
  'name': instance.name,
  'value': instance.value,
  'is_required': instance.isRequired,
};

AnimalHistorySnapshot _$AnimalHistorySnapshotFromJson(
  Map<String, dynamic> json,
) => AnimalHistorySnapshot(
  animal: (json['animal'] as num).toInt(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  status: status69fEnumNullableFromJson(json['status']),
  height: json['height'] as String?,
  weight: json['weight'] as String?,
  shelterName: json['shelter_name'] as String,
  editor: json['editor'] as String,
);

Map<String, dynamic> _$AnimalHistorySnapshotToJson(
  AnimalHistorySnapshot instance,
) => <String, dynamic>{
  'animal': instance.animal,
  'created_at': instance.createdAt?.toIso8601String(),
  'status': status69fEnumNullableToJson(instance.status),
  'height': instance.height,
  'weight': instance.weight,
  'shelter_name': instance.shelterName,
  'editor': instance.editor,
};

AnimalImageRead _$AnimalImageReadFromJson(Map<String, dynamic> json) =>
    AnimalImageRead(
      id: (json['id'] as num?)?.toInt(),
      isPrimary: json['is_primary'] as bool?,
      filename: json['filename'] as String?,
      image: ImageThumbnails.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnimalImageReadToJson(AnimalImageRead instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_primary': instance.isPrimary,
      'filename': instance.filename,
      'image': instance.image.toJson(),
    };

AnimalImageWrite _$AnimalImageWriteFromJson(Map<String, dynamic> json) =>
    AnimalImageWrite(
      isPrimary: json['is_primary'] as bool?,
      name: json['name'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$AnimalImageWriteToJson(AnimalImageWrite instance) =>
    <String, dynamic>{
      'is_primary': instance.isPrimary,
      'name': instance.name,
      'image': instance.image,
    };

AnimalNote _$AnimalNoteFromJson(Map<String, dynamic> json) => AnimalNote(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num).toInt(),
  content: json['content'] as String,
  files:
      (json['files'] as List<dynamic>?)
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
      id: (json['id'] as num?)?.toInt(),
      file: json['file'] as String,
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

AnimalRead _$AnimalReadFromJson(Map<String, dynamic> json) => AnimalRead(
  id: (json['id'] as num?)?.toInt(),
  uuid: json['uuid'] as String?,
  url: json['url'] as String?,
  name: json['name'] as String?,
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => AnimalImageRead.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  spec: json['spec'] == null
      ? null
      : Species.fromJson(json['spec'] as Map<String, dynamic>),
  status: status69fEnumNullableFromJson(json['status']),
  dateJoined: DateTime.parse(json['date_joined'] as String),
  birthDate: json['birth_date'] == null
      ? null
      : DateTime.parse(json['birth_date'] as String),
  deathDate: json['death_date'] == null
      ? null
      : DateTime.parse(json['death_date'] as String),
  deathReason: json['death_reason'] as String?,
  defaultImageId: (json['default_image_id'] as num?)?.toInt(),
  placeOfCatch: json['place_of_catch'] as String,
  placeOfRelease: json['place_of_release'] as String?,
  dateOfChipping: json['date_of_chipping'] == null
      ? null
      : DateTime.parse(json['date_of_chipping'] as String),
  chippingCode: json['chipping_code'] as String?,
  height: json['height'] as String?,
  weight: json['weight'] as String?,
  hasDocuments: json['has_documents'] as bool?,
  shelter: (json['shelter'] as num).toInt(),
  curator: json['curator'] == null
      ? null
      : Curator.fromJson(json['curator'] as Map<String, dynamic>),
  applicant: json['applicant'] == null
      ? null
      : Applicant.fromJson(json['applicant'] as Map<String, dynamic>),
  animalAttributes:
      (json['animal_attributes'] as List<dynamic>?)
          ?.map((e) => AnimalAttributeValue.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  deletedAt: json['deleted_at'] == null
      ? null
      : DateTime.parse(json['deleted_at'] as String),
  adoption: json['adoption'] as String?,
  release: json['release'] as String?,
  overstay: json['overstay'] as String?,
  canBeShared: json['can_be_shared'] as bool?,
);

Map<String, dynamic> _$AnimalReadToJson(AnimalRead instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'url': instance.url,
      'name': instance.name,
      'images': instance.images.map((e) => e.toJson()).toList(),
      'spec': instance.spec?.toJson(),
      'status': status69fEnumNullableToJson(instance.status),
      'date_joined': _dateToJson(instance.dateJoined),
      'birth_date': _dateToJson(instance.birthDate),
      'death_date': _dateToJson(instance.deathDate),
      'death_reason': instance.deathReason,
      'default_image_id': instance.defaultImageId,
      'place_of_catch': instance.placeOfCatch,
      'place_of_release': instance.placeOfRelease,
      'date_of_chipping': _dateToJson(instance.dateOfChipping),
      'chipping_code': instance.chippingCode,
      'height': instance.height,
      'weight': instance.weight,
      'has_documents': instance.hasDocuments,
      'shelter': instance.shelter,
      'curator': instance.curator?.toJson(),
      'applicant': instance.applicant?.toJson(),
      'animal_attributes': instance.animalAttributes
          .map((e) => e.toJson())
          .toList(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'adoption': instance.adoption,
      'release': instance.release,
      'overstay': instance.overstay,
      'can_be_shared': instance.canBeShared,
    };

AnimalShort _$AnimalShortFromJson(Map<String, dynamic> json) => AnimalShort(
  id: (json['id'] as num?)?.toInt(),
  uuid: json['uuid'] as String?,
  name: json['name'] as String?,
  specName: json['spec_name'] as String?,
  specParentName: json['spec_parent_name'] as String?,
  avatar: json['avatar'] as String?,
  defaultImageId: (json['default_image_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$AnimalShortToJson(AnimalShort instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'name': instance.name,
      'spec_name': instance.specName,
      'spec_parent_name': instance.specParentName,
      'avatar': instance.avatar,
      'default_image_id': instance.defaultImageId,
    };

AnimalSitter _$AnimalSitterFromJson(Map<String, dynamic> json) => AnimalSitter(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  shelter: json['shelter'] as String?,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phone_number'] as String,
  address: json['address'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$AnimalSitterToJson(AnimalSitter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'shelter': instance.shelter,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

AnimalStatsResponse _$AnimalStatsResponseFromJson(Map<String, dynamic> json) =>
    AnimalStatsResponse(
      breeds:
          (json['breeds'] as List<dynamic>?)
              ?.map(
                (e) =>
                    BreedsSpeciesStatsItem.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      species:
          (json['species'] as List<dynamic>?)
              ?.map(
                (e) =>
                    BreedsSpeciesStatsItem.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      dateJoined:
          (json['date_joined'] as List<dynamic>?)
              ?.map(
                (e) => DateJoinedStatsItem.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      statusTransitions:
          (json['status_transitions'] as List<dynamic>?)
              ?.map(
                (e) =>
                    StatusTransitionsItem.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$AnimalStatsResponseToJson(
  AnimalStatsResponse instance,
) => <String, dynamic>{
  'breeds': instance.breeds?.map((e) => e.toJson()).toList(),
  'species': instance.species?.map((e) => e.toJson()).toList(),
  'date_joined': instance.dateJoined?.map((e) => e.toJson()).toList(),
  'status_transitions': instance.statusTransitions
      ?.map((e) => e.toJson())
      .toList(),
};

AnimalWrite _$AnimalWriteFromJson(Map<String, dynamic> json) => AnimalWrite(
  name: json['name'] as String?,
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => AnimalImageWrite.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  validImages:
      (json['valid_images'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      [],
  specId: (json['spec_id'] as num?)?.toInt(),
  status: status69fEnumNullableFromJson(json['status']),
  dateJoined: DateTime.parse(json['date_joined'] as String),
  birthDate: json['birth_date'] == null
      ? null
      : DateTime.parse(json['birth_date'] as String),
  deathDate: json['death_date'] == null
      ? null
      : DateTime.parse(json['death_date'] as String),
  deathReason: json['death_reason'] as String?,
  defaultImageId: (json['default_image_id'] as num?)?.toInt(),
  placeOfCatch: json['place_of_catch'] as String,
  placeOfRelease: json['place_of_release'] as String?,
  dateOfChipping: json['date_of_chipping'] == null
      ? null
      : DateTime.parse(json['date_of_chipping'] as String),
  chippingCode: json['chipping_code'] as String?,
  height: json['height'] as String?,
  weight: json['weight'] as String?,
  shelter: (json['shelter'] as num).toInt(),
  curatorId: (json['curator_id'] as num?)?.toInt(),
  applicantId: (json['applicant_id'] as num?)?.toInt(),
  animalAttributes:
      (json['animal_attributes'] as List<dynamic>?)
          ?.map((e) => AnimalAttributeValue.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  canBeShared: json['can_be_shared'] as bool?,
);

Map<String, dynamic> _$AnimalWriteToJson(AnimalWrite instance) =>
    <String, dynamic>{
      'name': instance.name,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'valid_images': instance.validImages,
      'spec_id': instance.specId,
      'status': status69fEnumNullableToJson(instance.status),
      'date_joined': _dateToJson(instance.dateJoined),
      'birth_date': _dateToJson(instance.birthDate),
      'death_date': _dateToJson(instance.deathDate),
      'death_reason': instance.deathReason,
      'default_image_id': instance.defaultImageId,
      'place_of_catch': instance.placeOfCatch,
      'place_of_release': instance.placeOfRelease,
      'date_of_chipping': _dateToJson(instance.dateOfChipping),
      'chipping_code': instance.chippingCode,
      'height': instance.height,
      'weight': instance.weight,
      'shelter': instance.shelter,
      'curator_id': instance.curatorId,
      'applicant_id': instance.applicantId,
      'animal_attributes': instance.animalAttributes
          .map((e) => e.toJson())
          .toList(),
      'can_be_shared': instance.canBeShared,
    };

Applicant _$ApplicantFromJson(Map<String, dynamic> json) => Applicant(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  shelter: (json['shelter'] as num?)?.toInt(),
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  email: json['email'] as String?,
  phoneNumber: json['phone_number'] as String,
  contactDetails: json['contact_details'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  animalId: (json['animal_id'] as num?)?.toInt(),
  applicantFiles:
      (json['applicant_files'] as List<dynamic>?)
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
  'applicant_files': instance.applicantFiles?.map((e) => e.toJson()).toList(),
};

ApplicantFile _$ApplicantFileFromJson(Map<String, dynamic> json) =>
    ApplicantFile(
      id: (json['id'] as num?)?.toInt(),
      file: json['file'] as String,
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

AppointmentPrescription _$AppointmentPrescriptionFromJson(
  Map<String, dynamic> json,
) => AppointmentPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num).toInt(),
  myType: appointmentPrescriptionMyTypeEnumFromJson(json['my_type']),
  duration: durationEnumNullableFromJson(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs:
      (json['drugs'] as List<dynamic>?)
          ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  executions:
      (json['executions'] as List<dynamic>?)
          ?.map(
            (e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  files:
      (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$AppointmentPrescriptionToJson(
  AppointmentPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'my_type': appointmentPrescriptionMyTypeEnumToJson(instance.myType),
  'duration': durationEnumNullableToJson(instance.duration),
  'description': instance.description,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'drugs': instance.drugs.map((e) => e.toJson()).toList(),
  'executions': instance.executions.map((e) => e.toJson()).toList(),
  'files': instance.files?.map((e) => e.toJson()).toList(),
};

Approve _$ApproveFromJson(Map<String, dynamic> json) =>
    Approve(status: json['status'] as String);

Map<String, dynamic> _$ApproveToJson(Approve instance) => <String, dynamic>{
  'status': instance.status,
};

BreedsSpeciesStatsItem _$BreedsSpeciesStatsItemFromJson(
  Map<String, dynamic> json,
) => BreedsSpeciesStatsItem(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$BreedsSpeciesStatsItemToJson(
  BreedsSpeciesStatsItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'count': instance.count,
};

CourseOfTreatmentPrescription _$CourseOfTreatmentPrescriptionFromJson(
  Map<String, dynamic> json,
) => CourseOfTreatmentPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num).toInt(),
  myType: courseOfTreatmentPrescriptionMyTypeEnumFromJson(json['my_type']),
  duration: durationEnumNullableFromJson(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs:
      (json['drugs'] as List<dynamic>?)
          ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  executions:
      (json['executions'] as List<dynamic>?)
          ?.map(
            (e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  files:
      (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$CourseOfTreatmentPrescriptionToJson(
  CourseOfTreatmentPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'my_type': courseOfTreatmentPrescriptionMyTypeEnumToJson(instance.myType),
  'duration': durationEnumNullableToJson(instance.duration),
  'description': instance.description,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'drugs': instance.drugs.map((e) => e.toJson()).toList(),
  'executions': instance.executions.map((e) => e.toJson()).toList(),
  'files': instance.files?.map((e) => e.toJson()).toList(),
};

Curator _$CuratorFromJson(Map<String, dynamic> json) => Curator(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  shelter: json['shelter'] as String?,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  email: json['email'] as String?,
  phoneNumber: json['phone_number'] as String,
  address: json['address'] as String,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
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
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};

DateJoinedInnerSpeciesCounts _$DateJoinedInnerSpeciesCountsFromJson(
  Map<String, dynamic> json,
) => DateJoinedInnerSpeciesCounts(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  count: (json['count'] as num).toInt(),
  breeds:
      (json['breeds'] as List<dynamic>?)
          ?.map(
            (e) => BreedsSpeciesStatsItem.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
);

Map<String, dynamic> _$DateJoinedInnerSpeciesCountsToJson(
  DateJoinedInnerSpeciesCounts instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'count': instance.count,
  'breeds': instance.breeds?.map((e) => e.toJson()).toList(),
};

DateJoinedStatsItem _$DateJoinedStatsItemFromJson(Map<String, dynamic> json) =>
    DateJoinedStatsItem(
      dateJoined: DateTime.parse(json['date_joined'] as String),
      count: (json['count'] as num).toInt(),
      species:
          (json['species'] as List<dynamic>?)
              ?.map(
                (e) => DateJoinedInnerSpeciesCounts.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$DateJoinedStatsItemToJson(
  DateJoinedStatsItem instance,
) => <String, dynamic>{
  'date_joined': _dateToJson(instance.dateJoined),
  'count': instance.count,
  'species': instance.species?.map((e) => e.toJson()).toList(),
};

Decline _$DeclineFromJson(Map<String, dynamic> json) =>
    Decline(status: json['status'] as String);

Map<String, dynamic> _$DeclineToJson(Decline instance) => <String, dynamic>{
  'status': instance.status,
};

Drug _$DrugFromJson(Map<String, dynamic> json) => Drug(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String,
  usageInstruction: json['usage_instruction'] as String,
  formOfDrug: (json['form_of_drug'] as num).toInt(),
  formOfDrugName: json['form_of_drug_name'] as String?,
);

Map<String, dynamic> _$DrugToJson(Drug instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'usage_instruction': instance.usageInstruction,
  'form_of_drug': instance.formOfDrug,
  'form_of_drug_name': instance.formOfDrugName,
};

Email _$EmailFromJson(Map<String, dynamic> json) =>
    Email(email: json['email'] as String);

Map<String, dynamic> _$EmailToJson(Email instance) => <String, dynamic>{
  'email': instance.email,
};

Feedback _$FeedbackFromJson(Map<String, dynamic> json) => Feedback(
  shelterId: (json['shelter_id'] as num).toInt(),
  shelterName: json['shelter_name'] as String,
  date: DateTime.parse(json['date'] as String),
  action: json['action'] as String,
  email: json['email'] as String,
  message: json['message'] as String,
);

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
  'shelter_id': instance.shelterId,
  'shelter_name': instance.shelterName,
  'date': _dateToJson(instance.date),
  'action': instance.action,
  'email': instance.email,
  'message': instance.message,
};

ImageThumbnails _$ImageThumbnailsFromJson(Map<String, dynamic> json) =>
    ImageThumbnails(
      large: json['large'] as String,
      medium: json['medium'] as String,
      small: json['small'] as String,
    );

Map<String, dynamic> _$ImageThumbnailsToJson(ImageThumbnails instance) =>
    <String, dynamic>{
      'large': instance.large,
      'medium': instance.medium,
      'small': instance.small,
    };

OtherPrescription _$OtherPrescriptionFromJson(Map<String, dynamic> json) =>
    OtherPrescription(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
      animal: (json['animal'] as num).toInt(),
      myType: otherPrescriptionMyTypeEnumFromJson(json['my_type']),
      duration: durationEnumNullableFromJson(json['duration']),
      description: json['description'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      drugs:
          (json['drugs'] as List<dynamic>?)
              ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      executions:
          (json['executions'] as List<dynamic>?)
              ?.map(
                (e) =>
                    PrescriptionExecution.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      files:
          (json['files'] as List<dynamic>?)
              ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$OtherPrescriptionToJson(OtherPrescription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'animal': instance.animal,
      'my_type': otherPrescriptionMyTypeEnumToJson(instance.myType),
      'duration': durationEnumNullableToJson(instance.duration),
      'description': instance.description,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'drugs': instance.drugs.map((e) => e.toJson()).toList(),
      'executions': instance.executions.map((e) => e.toJson()).toList(),
      'files': instance.files?.map((e) => e.toJson()).toList(),
    };

Overstay _$OverstayFromJson(Map<String, dynamic> json) => Overstay(
  startDate: json['start_date'] == null
      ? null
      : DateTime.parse(json['start_date'] as String),
  endDate: json['end_date'] == null
      ? null
      : DateTime.parse(json['end_date'] as String),
  animalSitter: (json['animal_sitter'] as num?)?.toInt(),
);

Map<String, dynamic> _$OverstayToJson(Overstay instance) => <String, dynamic>{
  'start_date': _dateToJson(instance.startDate),
  'end_date': _dateToJson(instance.endDate),
  'animal_sitter': instance.animalSitter,
};

PaginatedAdopterList _$PaginatedAdopterListFromJson(
  Map<String, dynamic> json,
) => PaginatedAdopterList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => Adopter.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PaginatedAdopterListToJson(
  PaginatedAdopterList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results?.map((e) => e.toJson()).toList(),
};

PaginatedAdoptionList _$PaginatedAdoptionListFromJson(
  Map<String, dynamic> json,
) => PaginatedAdoptionList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => Adoption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PaginatedAdoptionListToJson(
  PaginatedAdoptionList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results?.map((e) => e.toJson()).toList(),
};

PaginatedAnimalHistorySnapshotList _$PaginatedAnimalHistorySnapshotListFromJson(
  Map<String, dynamic> json,
) => PaginatedAnimalHistorySnapshotList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results:
      (json['results'] as List<dynamic>?)
          ?.map(
            (e) => AnimalHistorySnapshot.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
);

Map<String, dynamic> _$PaginatedAnimalHistorySnapshotListToJson(
  PaginatedAnimalHistorySnapshotList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results?.map((e) => e.toJson()).toList(),
};

PaginatedAnimalNoteList _$PaginatedAnimalNoteListFromJson(
  Map<String, dynamic> json,
) => PaginatedAnimalNoteList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => AnimalNote.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PaginatedAnimalNoteListToJson(
  PaginatedAnimalNoteList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results?.map((e) => e.toJson()).toList(),
};

PaginatedAnimalReadList _$PaginatedAnimalReadListFromJson(
  Map<String, dynamic> json,
) => PaginatedAnimalReadList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => AnimalRead.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PaginatedAnimalReadListToJson(
  PaginatedAnimalReadList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results?.map((e) => e.toJson()).toList(),
};

PaginatedAnimalSitterList _$PaginatedAnimalSitterListFromJson(
  Map<String, dynamic> json,
) => PaginatedAnimalSitterList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => AnimalSitter.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PaginatedAnimalSitterListToJson(
  PaginatedAnimalSitterList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results?.map((e) => e.toJson()).toList(),
};

PaginatedApplicantList _$PaginatedApplicantListFromJson(
  Map<String, dynamic> json,
) => PaginatedApplicantList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => Applicant.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PaginatedApplicantListToJson(
  PaginatedApplicantList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results?.map((e) => e.toJson()).toList(),
};

PaginatedCuratorList _$PaginatedCuratorListFromJson(
  Map<String, dynamic> json,
) => PaginatedCuratorList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => Curator.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PaginatedCuratorListToJson(
  PaginatedCuratorList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results?.map((e) => e.toJson()).toList(),
};

PaginatedOverstayList _$PaginatedOverstayListFromJson(
  Map<String, dynamic> json,
) => PaginatedOverstayList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => Overstay.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PaginatedOverstayListToJson(
  PaginatedOverstayList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results?.map((e) => e.toJson()).toList(),
};

PaginatedPrescriptionExecutionTodayList
_$PaginatedPrescriptionExecutionTodayListFromJson(Map<String, dynamic> json) =>
    PaginatedPrescriptionExecutionTodayList(
      count: (json['count'] as num?)?.toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results:
          (json['results'] as List<dynamic>?)
              ?.map(
                (e) => PrescriptionExecutionToday.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$PaginatedPrescriptionExecutionTodayListToJson(
  PaginatedPrescriptionExecutionTodayList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results?.map((e) => e.toJson()).toList(),
};

PaginatedPrescriptionList _$PaginatedPrescriptionListFromJson(
  Map<String, dynamic> json,
) => PaginatedPrescriptionList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => Prescription.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PaginatedPrescriptionListToJson(
  PaginatedPrescriptionList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results?.map((e) => e.toJson()).toList(),
};

PaginatedReleaseSerializersList _$PaginatedReleaseSerializersListFromJson(
  Map<String, dynamic> json,
) => PaginatedReleaseSerializersList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => ReleaseSerializers.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PaginatedReleaseSerializersListToJson(
  PaginatedReleaseSerializersList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results?.map((e) => e.toJson()).toList(),
};

PaginatedShelterDrugList _$PaginatedShelterDrugListFromJson(
  Map<String, dynamic> json,
) => PaginatedShelterDrugList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => ShelterDrug.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PaginatedShelterDrugListToJson(
  PaginatedShelterDrugList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results?.map((e) => e.toJson()).toList(),
};

PaginatedShelterShortSerializersList
_$PaginatedShelterShortSerializersListFromJson(Map<String, dynamic> json) =>
    PaginatedShelterShortSerializersList(
      count: (json['count'] as num?)?.toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results:
          (json['results'] as List<dynamic>?)
              ?.map(
                (e) =>
                    ShelterShortSerializers.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$PaginatedShelterShortSerializersListToJson(
  PaginatedShelterShortSerializersList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results?.map((e) => e.toJson()).toList(),
};

PaginatedSpeciesList _$PaginatedSpeciesListFromJson(
  Map<String, dynamic> json,
) => PaginatedSpeciesList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => Species.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PaginatedSpeciesListToJson(
  PaginatedSpeciesList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results?.map((e) => e.toJson()).toList(),
};

PaginatedUserSheltersAdminSerializersList
_$PaginatedUserSheltersAdminSerializersListFromJson(
  Map<String, dynamic> json,
) => PaginatedUserSheltersAdminSerializersList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results:
      (json['results'] as List<dynamic>?)
          ?.map(
            (e) => UserSheltersAdminSerializers.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      [],
);

Map<String, dynamic> _$PaginatedUserSheltersAdminSerializersListToJson(
  PaginatedUserSheltersAdminSerializersList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results?.map((e) => e.toJson()).toList(),
};

PaginatedUserShortSerializersList _$PaginatedUserShortSerializersListFromJson(
  Map<String, dynamic> json,
) => PaginatedUserShortSerializersList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => UserShortSerializers.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PaginatedUserShortSerializersListToJson(
  PaginatedUserShortSerializersList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results?.map((e) => e.toJson()).toList(),
};

ParasitesPrescriptionExtraAttr _$ParasitesPrescriptionExtraAttrFromJson(
  Map<String, dynamic> json,
) => ParasitesPrescriptionExtraAttr(
  parasitesType: parasitesTypeEnumNullableFromJson(json['parasites_type']),
  reaction: json['reaction'] as String?,
);

Map<String, dynamic> _$ParasitesPrescriptionExtraAttrToJson(
  ParasitesPrescriptionExtraAttr instance,
) => <String, dynamic>{
  'parasites_type': parasitesTypeEnumNullableToJson(instance.parasitesType),
  'reaction': instance.reaction,
};

ParasitesTreatmentPrescription _$ParasitesTreatmentPrescriptionFromJson(
  Map<String, dynamic> json,
) => ParasitesTreatmentPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num).toInt(),
  myType: parasitesTreatmentPrescriptionMyTypeEnumFromJson(json['my_type']),
  extraTypeAttributes: ParasitesPrescriptionExtraAttr.fromJson(
    json['extra_type_attributes'] as Map<String, dynamic>,
  ),
  duration: durationEnumNullableFromJson(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs:
      (json['drugs'] as List<dynamic>?)
          ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  executions:
      (json['executions'] as List<dynamic>?)
          ?.map(
            (e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  files:
      (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$ParasitesTreatmentPrescriptionToJson(
  ParasitesTreatmentPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'my_type': parasitesTreatmentPrescriptionMyTypeEnumToJson(instance.myType),
  'extra_type_attributes': instance.extraTypeAttributes.toJson(),
  'duration': durationEnumNullableToJson(instance.duration),
  'description': instance.description,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'drugs': instance.drugs.map((e) => e.toJson()).toList(),
  'executions': instance.executions.map((e) => e.toJson()).toList(),
  'files': instance.files?.map((e) => e.toJson()).toList(),
};

PatchedAdopter _$PatchedAdopterFromJson(Map<String, dynamic> json) =>
    PatchedAdopter(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
      shelter: json['shelter'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$PatchedAdopterToJson(PatchedAdopter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'shelter': instance.shelter,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

PatchedAdoption _$PatchedAdoptionFromJson(Map<String, dynamic> json) =>
    PatchedAdoption(
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      adopter: (json['adopter'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PatchedAdoptionToJson(PatchedAdoption instance) =>
    <String, dynamic>{
      'start_date': _dateToJson(instance.startDate),
      'end_date': _dateToJson(instance.endDate),
      'adopter': instance.adopter,
    };

PatchedAnalysisPrescription _$PatchedAnalysisPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedAnalysisPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num?)?.toInt(),
  myType: analysisPrescriptionMyTypeEnumNullableFromJson(json['my_type']),
  duration: durationEnumNullableFromJson(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs:
      (json['drugs'] as List<dynamic>?)
          ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  executions:
      (json['executions'] as List<dynamic>?)
          ?.map(
            (e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  files:
      (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PatchedAnalysisPrescriptionToJson(
  PatchedAnalysisPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'my_type': analysisPrescriptionMyTypeEnumNullableToJson(instance.myType),
  'duration': durationEnumNullableToJson(instance.duration),
  'description': instance.description,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'drugs': instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': instance.executions?.map((e) => e.toJson()).toList(),
  'files': instance.files?.map((e) => e.toJson()).toList(),
};

PatchedAnimalNote _$PatchedAnimalNoteFromJson(Map<String, dynamic> json) =>
    PatchedAnimalNote(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
      animal: (json['animal'] as num?)?.toInt(),
      content: json['content'] as String?,
      files:
          (json['files'] as List<dynamic>?)
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

PatchedAnimalSitter _$PatchedAnimalSitterFromJson(Map<String, dynamic> json) =>
    PatchedAnimalSitter(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
      shelter: json['shelter'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$PatchedAnimalSitterToJson(
  PatchedAnimalSitter instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'shelter': instance.shelter,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'email': instance.email,
  'phone_number': instance.phoneNumber,
  'address': instance.address,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};

PatchedAnimalWrite _$PatchedAnimalWriteFromJson(Map<String, dynamic> json) =>
    PatchedAnimalWrite(
      name: json['name'] as String?,
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => AnimalImageWrite.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      validImages:
          (json['valid_images'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      specId: (json['spec_id'] as num?)?.toInt(),
      status: status69fEnumNullableFromJson(json['status']),
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
      defaultImageId: (json['default_image_id'] as num?)?.toInt(),
      placeOfCatch: json['place_of_catch'] as String?,
      placeOfRelease: json['place_of_release'] as String?,
      dateOfChipping: json['date_of_chipping'] == null
          ? null
          : DateTime.parse(json['date_of_chipping'] as String),
      chippingCode: json['chipping_code'] as String?,
      height: json['height'] as String?,
      weight: json['weight'] as String?,
      shelter: (json['shelter'] as num?)?.toInt(),
      curatorId: (json['curator_id'] as num?)?.toInt(),
      applicantId: (json['applicant_id'] as num?)?.toInt(),
      animalAttributes:
          (json['animal_attributes'] as List<dynamic>?)
              ?.map(
                (e) => AnimalAttributeValue.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      canBeShared: json['can_be_shared'] as bool?,
    );

Map<String, dynamic> _$PatchedAnimalWriteToJson(PatchedAnimalWrite instance) =>
    <String, dynamic>{
      'name': instance.name,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'valid_images': instance.validImages,
      'spec_id': instance.specId,
      'status': status69fEnumNullableToJson(instance.status),
      'date_joined': _dateToJson(instance.dateJoined),
      'birth_date': _dateToJson(instance.birthDate),
      'death_date': _dateToJson(instance.deathDate),
      'death_reason': instance.deathReason,
      'default_image_id': instance.defaultImageId,
      'place_of_catch': instance.placeOfCatch,
      'place_of_release': instance.placeOfRelease,
      'date_of_chipping': _dateToJson(instance.dateOfChipping),
      'chipping_code': instance.chippingCode,
      'height': instance.height,
      'weight': instance.weight,
      'shelter': instance.shelter,
      'curator_id': instance.curatorId,
      'applicant_id': instance.applicantId,
      'animal_attributes': instance.animalAttributes
          ?.map((e) => e.toJson())
          .toList(),
      'can_be_shared': instance.canBeShared,
    };

PatchedApplicant _$PatchedApplicantFromJson(Map<String, dynamic> json) =>
    PatchedApplicant(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
      shelter: (json['shelter'] as num?)?.toInt(),
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
      animalId: (json['animal_id'] as num?)?.toInt(),
      applicantFiles:
          (json['applicant_files'] as List<dynamic>?)
              ?.map((e) => ApplicantFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PatchedApplicantToJson(
  PatchedApplicant instance,
) => <String, dynamic>{
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
  'applicant_files': instance.applicantFiles?.map((e) => e.toJson()).toList(),
};

PatchedAppointmentPrescription _$PatchedAppointmentPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedAppointmentPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num?)?.toInt(),
  myType: appointmentPrescriptionMyTypeEnumNullableFromJson(json['my_type']),
  duration: durationEnumNullableFromJson(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs:
      (json['drugs'] as List<dynamic>?)
          ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  executions:
      (json['executions'] as List<dynamic>?)
          ?.map(
            (e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  files:
      (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PatchedAppointmentPrescriptionToJson(
  PatchedAppointmentPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'my_type': appointmentPrescriptionMyTypeEnumNullableToJson(instance.myType),
  'duration': durationEnumNullableToJson(instance.duration),
  'description': instance.description,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'drugs': instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': instance.executions?.map((e) => e.toJson()).toList(),
  'files': instance.files?.map((e) => e.toJson()).toList(),
};

PatchedCourseOfTreatmentPrescription
_$PatchedCourseOfTreatmentPrescriptionFromJson(Map<String, dynamic> json) =>
    PatchedCourseOfTreatmentPrescription(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
      animal: (json['animal'] as num?)?.toInt(),
      myType: courseOfTreatmentPrescriptionMyTypeEnumNullableFromJson(
        json['my_type'],
      ),
      duration: durationEnumNullableFromJson(json['duration']),
      description: json['description'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      drugs:
          (json['drugs'] as List<dynamic>?)
              ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      executions:
          (json['executions'] as List<dynamic>?)
              ?.map(
                (e) =>
                    PrescriptionExecution.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      files:
          (json['files'] as List<dynamic>?)
              ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PatchedCourseOfTreatmentPrescriptionToJson(
  PatchedCourseOfTreatmentPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'my_type': courseOfTreatmentPrescriptionMyTypeEnumNullableToJson(
    instance.myType,
  ),
  'duration': durationEnumNullableToJson(instance.duration),
  'description': instance.description,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'drugs': instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': instance.executions?.map((e) => e.toJson()).toList(),
  'files': instance.files?.map((e) => e.toJson()).toList(),
};

PatchedCurator _$PatchedCuratorFromJson(Map<String, dynamic> json) =>
    PatchedCurator(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
      shelter: json['shelter'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
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
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

PatchedOtherPrescription _$PatchedOtherPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedOtherPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num?)?.toInt(),
  myType: otherPrescriptionMyTypeEnumNullableFromJson(json['my_type']),
  duration: durationEnumNullableFromJson(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs:
      (json['drugs'] as List<dynamic>?)
          ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  executions:
      (json['executions'] as List<dynamic>?)
          ?.map(
            (e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  files:
      (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PatchedOtherPrescriptionToJson(
  PatchedOtherPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'my_type': otherPrescriptionMyTypeEnumNullableToJson(instance.myType),
  'duration': durationEnumNullableToJson(instance.duration),
  'description': instance.description,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'drugs': instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': instance.executions?.map((e) => e.toJson()).toList(),
  'files': instance.files?.map((e) => e.toJson()).toList(),
};

PatchedOverstay _$PatchedOverstayFromJson(Map<String, dynamic> json) =>
    PatchedOverstay(
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      animalSitter: (json['animal_sitter'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PatchedOverstayToJson(PatchedOverstay instance) =>
    <String, dynamic>{
      'start_date': _dateToJson(instance.startDate),
      'end_date': _dateToJson(instance.endDate),
      'animal_sitter': instance.animalSitter,
    };

PatchedParasitesTreatmentPrescription
_$PatchedParasitesTreatmentPrescriptionFromJson(Map<String, dynamic> json) =>
    PatchedParasitesTreatmentPrescription(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
      animal: (json['animal'] as num?)?.toInt(),
      myType: parasitesTreatmentPrescriptionMyTypeEnumNullableFromJson(
        json['my_type'],
      ),
      extraTypeAttributes: json['extra_type_attributes'] == null
          ? null
          : ParasitesPrescriptionExtraAttr.fromJson(
              json['extra_type_attributes'] as Map<String, dynamic>,
            ),
      duration: durationEnumNullableFromJson(json['duration']),
      description: json['description'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      drugs:
          (json['drugs'] as List<dynamic>?)
              ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      executions:
          (json['executions'] as List<dynamic>?)
              ?.map(
                (e) =>
                    PrescriptionExecution.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      files:
          (json['files'] as List<dynamic>?)
              ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PatchedParasitesTreatmentPrescriptionToJson(
  PatchedParasitesTreatmentPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'my_type': parasitesTreatmentPrescriptionMyTypeEnumNullableToJson(
    instance.myType,
  ),
  'extra_type_attributes': instance.extraTypeAttributes?.toJson(),
  'duration': durationEnumNullableToJson(instance.duration),
  'description': instance.description,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'drugs': instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': instance.executions?.map((e) => e.toJson()).toList(),
  'files': instance.files?.map((e) => e.toJson()).toList(),
};

PatchedPrescription _$PatchedPrescriptionFromJson(Map<String, dynamic> json) =>
    PatchedPrescription();

Map<String, dynamic> _$PatchedPrescriptionToJson(
  PatchedPrescription instance,
) => <String, dynamic>{};

PatchedReadmissionPrescription _$PatchedReadmissionPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedReadmissionPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num?)?.toInt(),
  myType: readmissionPrescriptionMyTypeEnumNullableFromJson(json['my_type']),
  duration: durationEnumNullableFromJson(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs:
      (json['drugs'] as List<dynamic>?)
          ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  executions:
      (json['executions'] as List<dynamic>?)
          ?.map(
            (e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  files:
      (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PatchedReadmissionPrescriptionToJson(
  PatchedReadmissionPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'my_type': readmissionPrescriptionMyTypeEnumNullableToJson(instance.myType),
  'duration': durationEnumNullableToJson(instance.duration),
  'description': instance.description,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'drugs': instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': instance.executions?.map((e) => e.toJson()).toList(),
  'files': instance.files?.map((e) => e.toJson()).toList(),
};

PatchedReleaseSerializers _$PatchedReleaseSerializersFromJson(
  Map<String, dynamic> json,
) => PatchedReleaseSerializers(
  id: (json['id'] as num?)?.toInt(),
  place: json['place'] as String?,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  veterinarianName: json['veterinarian_name'] as String?,
  veterinarianSurname: json['veterinarian_surname'] as String?,
  veterinarianPatronymic: json['veterinarian_patronymic'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$PatchedReleaseSerializersToJson(
  PatchedReleaseSerializers instance,
) => <String, dynamic>{
  'id': instance.id,
  'place': instance.place,
  'date': _dateToJson(instance.date),
  'veterinarian_name': instance.veterinarianName,
  'veterinarian_surname': instance.veterinarianSurname,
  'veterinarian_patronymic': instance.veterinarianPatronymic,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};

PatchedRemovingStitchesPrescription
_$PatchedRemovingStitchesPrescriptionFromJson(Map<String, dynamic> json) =>
    PatchedRemovingStitchesPrescription(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
      animal: (json['animal'] as num?)?.toInt(),
      myType: removingStitchesPrescriptionMyTypeEnumNullableFromJson(
        json['my_type'],
      ),
      duration: durationEnumNullableFromJson(json['duration']),
      description: json['description'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      drugs:
          (json['drugs'] as List<dynamic>?)
              ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      executions:
          (json['executions'] as List<dynamic>?)
              ?.map(
                (e) =>
                    PrescriptionExecution.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      files:
          (json['files'] as List<dynamic>?)
              ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PatchedRemovingStitchesPrescriptionToJson(
  PatchedRemovingStitchesPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'my_type': removingStitchesPrescriptionMyTypeEnumNullableToJson(
    instance.myType,
  ),
  'duration': durationEnumNullableToJson(instance.duration),
  'description': instance.description,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'drugs': instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': instance.executions?.map((e) => e.toJson()).toList(),
  'files': instance.files?.map((e) => e.toJson()).toList(),
};

PatchedShelterSerializers _$PatchedShelterSerializersFromJson(
  Map<String, dynamic> json,
) => PatchedShelterSerializers(
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

Map<String, dynamic> _$PatchedShelterSerializersToJson(
  PatchedShelterSerializers instance,
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

PatchedUserChangePasswordSerializers
_$PatchedUserChangePasswordSerializersFromJson(Map<String, dynamic> json) =>
    PatchedUserChangePasswordSerializers(
      id: (json['id'] as num?)?.toInt(),
      password: json['password'] as String?,
      rePassword: json['re_password'] as String?,
      oldPassword: json['old_password'] as String?,
    );

Map<String, dynamic> _$PatchedUserChangePasswordSerializersToJson(
  PatchedUserChangePasswordSerializers instance,
) => <String, dynamic>{
  'id': instance.id,
  'password': instance.password,
  're_password': instance.rePassword,
  'old_password': instance.oldPassword,
};

PatchedUserSerializers _$PatchedUserSerializersFromJson(
  Map<String, dynamic> json,
) => PatchedUserSerializers(
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

Map<String, dynamic> _$PatchedUserSerializersToJson(
  PatchedUserSerializers instance,
) => <String, dynamic>{
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

PatchedUserSheltersAdminSerializers
_$PatchedUserSheltersAdminSerializersFromJson(Map<String, dynamic> json) =>
    PatchedUserSheltersAdminSerializers(
      id: (json['id'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : UserSerializers.fromJson(json['user'] as Map<String, dynamic>),
      userId: (json['user_id'] as num?)?.toInt(),
      role: roleEnumNullableFromJson(json['role']),
      isVerifiedByAdmin: json['is_verified_by_admin'] as bool?,
    );

Map<String, dynamic> _$PatchedUserSheltersAdminSerializersToJson(
  PatchedUserSheltersAdminSerializers instance,
) => <String, dynamic>{
  'id': instance.id,
  'user': instance.user?.toJson(),
  'user_id': instance.userId,
  'role': roleEnumNullableToJson(instance.role),
  'is_verified_by_admin': instance.isVerifiedByAdmin,
};

PatchedVaccinationPrescription _$PatchedVaccinationPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedVaccinationPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num?)?.toInt(),
  myType: vaccinationPrescriptionMyTypeEnumNullableFromJson(json['my_type']),
  duration: durationEnumNullableFromJson(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs:
      (json['drugs'] as List<dynamic>?)
          ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  executions:
      (json['executions'] as List<dynamic>?)
          ?.map(
            (e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  files:
      (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PatchedVaccinationPrescriptionToJson(
  PatchedVaccinationPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'my_type': vaccinationPrescriptionMyTypeEnumNullableToJson(instance.myType),
  'duration': durationEnumNullableToJson(instance.duration),
  'description': instance.description,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'drugs': instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': instance.executions?.map((e) => e.toJson()).toList(),
  'files': instance.files?.map((e) => e.toJson()).toList(),
};

PatchedWoundHealingPrescription _$PatchedWoundHealingPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedWoundHealingPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num?)?.toInt(),
  myType: woundHealingPrescriptionMyTypeEnumNullableFromJson(json['my_type']),
  duration: durationEnumNullableFromJson(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs:
      (json['drugs'] as List<dynamic>?)
          ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  executions:
      (json['executions'] as List<dynamic>?)
          ?.map(
            (e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  files:
      (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PatchedWoundHealingPrescriptionToJson(
  PatchedWoundHealingPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'my_type': woundHealingPrescriptionMyTypeEnumNullableToJson(instance.myType),
  'duration': durationEnumNullableToJson(instance.duration),
  'description': instance.description,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'drugs': instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': instance.executions?.map((e) => e.toJson()).toList(),
  'files': instance.files?.map((e) => e.toJson()).toList(),
};

Prescription _$PrescriptionFromJson(Map<String, dynamic> json) =>
    Prescription();

Map<String, dynamic> _$PrescriptionToJson(Prescription instance) =>
    <String, dynamic>{};

PrescriptionDrug _$PrescriptionDrugFromJson(Map<String, dynamic> json) =>
    PrescriptionDrug(
      drugId: (json['drug_id'] as num).toInt(),
      drugName: json['drug_name'] as String,
      usageInstruction: json['usage_instruction'] as String?,
      formOfDrug: json['form_of_drug'] as String?,
      drugDosage: (json['drug_dosage'] as num).toDouble(),
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
  Map<String, dynamic> json,
) => PrescriptionExecution(
  id: (json['id'] as num?)?.toInt(),
  executeAt: DateTime.parse(json['execute_at'] as String),
  status: prescriptionExecutionStatusEnumNullableFromJson(json['status']),
);

Map<String, dynamic> _$PrescriptionExecutionToJson(
  PrescriptionExecution instance,
) => <String, dynamic>{
  'id': instance.id,
  'execute_at': instance.executeAt.toIso8601String(),
  'status': prescriptionExecutionStatusEnumNullableToJson(instance.status),
};

PrescriptionExecutionToday _$PrescriptionExecutionTodayFromJson(
  Map<String, dynamic> json,
) => PrescriptionExecutionToday(
  id: (json['id'] as num?)?.toInt(),
  prescription: PrescriptionShort.fromJson(
    json['prescription'] as Map<String, dynamic>,
  ),
  executeAt: DateTime.parse(json['execute_at'] as String),
);

Map<String, dynamic> _$PrescriptionExecutionTodayToJson(
  PrescriptionExecutionToday instance,
) => <String, dynamic>{
  'id': instance.id,
  'prescription': instance.prescription.toJson(),
  'execute_at': instance.executeAt.toIso8601String(),
};

PrescriptionFile _$PrescriptionFileFromJson(Map<String, dynamic> json) =>
    PrescriptionFile(
      id: (json['id'] as num?)?.toInt(),
      file: json['file'] as String,
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

PrescriptionShort _$PrescriptionShortFromJson(Map<String, dynamic> json) =>
    PrescriptionShort(
      id: (json['id'] as num?)?.toInt(),
      myType: prescriptionShortMyTypeEnumNullableFromJson(json['my_type']),
      extraTypeAttributes: json['extra_type_attributes'],
      description: json['description'] as String?,
      animal: AnimalShort.fromJson(json['animal'] as Map<String, dynamic>),
      drugs:
          (json['drugs'] as List<dynamic>?)
              ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      files:
          (json['files'] as List<dynamic>?)
              ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PrescriptionShortToJson(PrescriptionShort instance) =>
    <String, dynamic>{
      'id': instance.id,
      'my_type': prescriptionShortMyTypeEnumNullableToJson(instance.myType),
      'extra_type_attributes': instance.extraTypeAttributes,
      'description': instance.description,
      'animal': instance.animal.toJson(),
      'drugs': instance.drugs.map((e) => e.toJson()).toList(),
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'files': instance.files?.map((e) => e.toJson()).toList(),
    };

ReadmissionPrescription _$ReadmissionPrescriptionFromJson(
  Map<String, dynamic> json,
) => ReadmissionPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num).toInt(),
  myType: readmissionPrescriptionMyTypeEnumFromJson(json['my_type']),
  duration: durationEnumNullableFromJson(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs:
      (json['drugs'] as List<dynamic>?)
          ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  executions:
      (json['executions'] as List<dynamic>?)
          ?.map(
            (e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  files:
      (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$ReadmissionPrescriptionToJson(
  ReadmissionPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'my_type': readmissionPrescriptionMyTypeEnumToJson(instance.myType),
  'duration': durationEnumNullableToJson(instance.duration),
  'description': instance.description,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'drugs': instance.drugs.map((e) => e.toJson()).toList(),
  'executions': instance.executions.map((e) => e.toJson()).toList(),
  'files': instance.files?.map((e) => e.toJson()).toList(),
};

ReleaseSerializers _$ReleaseSerializersFromJson(Map<String, dynamic> json) =>
    ReleaseSerializers(
      id: (json['id'] as num?)?.toInt(),
      place: json['place'] as String?,
      date: json['date'] == null
          ? null
          : DateTime.parse(json['date'] as String),
      veterinarianName: json['veterinarian_name'] as String?,
      veterinarianSurname: json['veterinarian_surname'] as String?,
      veterinarianPatronymic: json['veterinarian_patronymic'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ReleaseSerializersToJson(ReleaseSerializers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'place': instance.place,
      'date': _dateToJson(instance.date),
      'veterinarian_name': instance.veterinarianName,
      'veterinarian_surname': instance.veterinarianSurname,
      'veterinarian_patronymic': instance.veterinarianPatronymic,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

RemovingStitchesPrescription _$RemovingStitchesPrescriptionFromJson(
  Map<String, dynamic> json,
) => RemovingStitchesPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num).toInt(),
  myType: removingStitchesPrescriptionMyTypeEnumFromJson(json['my_type']),
  duration: durationEnumNullableFromJson(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs:
      (json['drugs'] as List<dynamic>?)
          ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  executions:
      (json['executions'] as List<dynamic>?)
          ?.map(
            (e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  files:
      (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$RemovingStitchesPrescriptionToJson(
  RemovingStitchesPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'my_type': removingStitchesPrescriptionMyTypeEnumToJson(instance.myType),
  'duration': durationEnumNullableToJson(instance.duration),
  'description': instance.description,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'drugs': instance.drugs.map((e) => e.toJson()).toList(),
  'executions': instance.executions.map((e) => e.toJson()).toList(),
  'files': instance.files?.map((e) => e.toJson()).toList(),
};

ShelterDrug _$ShelterDrugFromJson(Map<String, dynamic> json) => ShelterDrug(
  drug: Drug.fromJson(json['drug'] as Map<String, dynamic>),
  drugResiduesCount: (json['drug_residues_count'] as num?)?.toInt(),
);

Map<String, dynamic> _$ShelterDrugToJson(ShelterDrug instance) =>
    <String, dynamic>{
      'drug': instance.drug.toJson(),
      'drug_residues_count': instance.drugResiduesCount,
    };

ShelterSerializers _$ShelterSerializersFromJson(Map<String, dynamic> json) =>
    ShelterSerializers(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
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

ShelterShortSerializers _$ShelterShortSerializersFromJson(
  Map<String, dynamic> json,
) => ShelterShortSerializers(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String,
);

Map<String, dynamic> _$ShelterShortSerializersToJson(
  ShelterShortSerializers instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

Species _$SpeciesFromJson(Map<String, dynamic> json) => Species(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String,
  level: levelEnumFromJson(json['level']),
  parentId: (json['parent_id'] as num?)?.toInt(),
  parentName: json['parent_name'] as String?,
  categoryName: json['category_name'] as String?,
);

Map<String, dynamic> _$SpeciesToJson(Species instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'level': levelEnumToJson(instance.level),
  'parent_id': instance.parentId,
  'parent_name': instance.parentName,
  'category_name': instance.categoryName,
};

Status _$StatusFromJson(Map<String, dynamic> json) =>
    Status(status: json['status'] as String);

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
  'status': instance.status,
};

StatusTransitionsItem _$StatusTransitionsItemFromJson(
  Map<String, dynamic> json,
) => StatusTransitionsItem(
  statusSequence:
      (json['status_sequence'] as List<dynamic>?)
          ?.map((e) => e as Object)
          .toList() ??
      [],
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$StatusTransitionsItemToJson(
  StatusTransitionsItem instance,
) => <String, dynamic>{
  'status_sequence': instance.statusSequence,
  'count': instance.count,
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
    <String, dynamic>{'access': instance.access, 'refresh': instance.refresh};

UserChangePasswordSerializers _$UserChangePasswordSerializersFromJson(
  Map<String, dynamic> json,
) => UserChangePasswordSerializers(
  id: (json['id'] as num?)?.toInt(),
  password: json['password'] as String?,
  rePassword: json['re_password'] as String?,
  oldPassword: json['old_password'] as String?,
);

Map<String, dynamic> _$UserChangePasswordSerializersToJson(
  UserChangePasswordSerializers instance,
) => <String, dynamic>{
  'id': instance.id,
  'password': instance.password,
  're_password': instance.rePassword,
  'old_password': instance.oldPassword,
};

UserCurrentShelterSerializers _$UserCurrentShelterSerializersFromJson(
  Map<String, dynamic> json,
) => UserCurrentShelterSerializers(
  currentShelter: (json['current_shelter'] as num).toInt(),
  currentShelterUserRole: json['current_shelter_user_role'] as String,
  isUserCanEdit: json['is_user_can_edit'] as bool,
  isUserCanDelete: json['is_user_can_delete'] as bool,
);

Map<String, dynamic> _$UserCurrentShelterSerializersToJson(
  UserCurrentShelterSerializers instance,
) => <String, dynamic>{
  'current_shelter': instance.currentShelter,
  'current_shelter_user_role': instance.currentShelterUserRole,
  'is_user_can_edit': instance.isUserCanEdit,
  'is_user_can_delete': instance.isUserCanDelete,
};

UserResetPasswordComplete _$UserResetPasswordCompleteFromJson(
  Map<String, dynamic> json,
) => UserResetPasswordComplete(
  uidb64: json['uidb64'] as String,
  token: json['token'] as String,
  newPassword: json['new_password'] as String?,
);

Map<String, dynamic> _$UserResetPasswordCompleteToJson(
  UserResetPasswordComplete instance,
) => <String, dynamic>{
  'uidb64': instance.uidb64,
  'token': instance.token,
  'new_password': instance.newPassword,
};

UserSerializers _$UserSerializersFromJson(Map<String, dynamic> json) =>
    UserSerializers(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String?,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
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

UserShelterAdminSerializers _$UserShelterAdminSerializersFromJson(
  Map<String, dynamic> json,
) => UserShelterAdminSerializers(
  id: (json['id'] as num?)?.toInt(),
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  fathersName: json['fathers_name'] as String?,
  email: json['email'] as String,
  phoneNumber: json['phone_number'] as String?,
  address: json['address'] as String?,
  password: json['password'] as String?,
  rePassword: json['re_password'] as String?,
  isOfferSigned: json['is_offer_signed'] as bool,
  shelter: json['shelter'] == null
      ? null
      : ShelterSerializers.fromJson(json['shelter'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserShelterAdminSerializersToJson(
  UserShelterAdminSerializers instance,
) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'fathers_name': instance.fathersName,
  'email': instance.email,
  'phone_number': instance.phoneNumber,
  'address': instance.address,
  'password': instance.password,
  're_password': instance.rePassword,
  'is_offer_signed': instance.isOfferSigned,
  'shelter': instance.shelter?.toJson(),
};

UserShelterWorkerSerializers _$UserShelterWorkerSerializersFromJson(
  Map<String, dynamic> json,
) => UserShelterWorkerSerializers(
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  fathersName: json['fathers_name'] as String?,
  email: json['email'] as String,
  phoneNumber: json['phone_number'] as String?,
  address: json['address'] as String?,
  password: json['password'] as String?,
  rePassword: json['re_password'] as String?,
  shelter: (json['shelter'] as num?)?.toInt(),
  role: roleEnumNullableFromJson(json['role']),
  isOfferSigned: json['is_offer_signed'] as bool,
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
  'role': roleEnumNullableToJson(instance.role),
  'is_offer_signed': instance.isOfferSigned,
};

UserSheltersAdminSerializers _$UserSheltersAdminSerializersFromJson(
  Map<String, dynamic> json,
) => UserSheltersAdminSerializers(
  id: (json['id'] as num?)?.toInt(),
  user: json['user'] == null
      ? null
      : UserSerializers.fromJson(json['user'] as Map<String, dynamic>),
  userId: (json['user_id'] as num?)?.toInt(),
  role: roleEnumFromJson(json['role']),
  isVerifiedByAdmin: json['is_verified_by_admin'] as bool?,
);

Map<String, dynamic> _$UserSheltersAdminSerializersToJson(
  UserSheltersAdminSerializers instance,
) => <String, dynamic>{
  'id': instance.id,
  'user': instance.user?.toJson(),
  'user_id': instance.userId,
  'role': roleEnumToJson(instance.role),
  'is_verified_by_admin': instance.isVerifiedByAdmin,
};

UserSheltersWorkerSerializers _$UserSheltersWorkerSerializersFromJson(
  Map<String, dynamic> json,
) => UserSheltersWorkerSerializers(
  shelter: (json['shelter'] as num?)?.toInt(),
  role: roleEnumFromJson(json['role']),
);

Map<String, dynamic> _$UserSheltersWorkerSerializersToJson(
  UserSheltersWorkerSerializers instance,
) => <String, dynamic>{
  'shelter': instance.shelter,
  'role': roleEnumToJson(instance.role),
};

UserShortSerializers _$UserShortSerializersFromJson(
  Map<String, dynamic> json,
) => UserShortSerializers(
  id: (json['id'] as num?)?.toInt(),
  fullName: json['full_name'] as String?,
  email: json['email'] as String,
  phoneNumber: json['phone_number'] as String?,
  address: json['address'] as String?,
);

Map<String, dynamic> _$UserShortSerializersToJson(
  UserShortSerializers instance,
) => <String, dynamic>{
  'id': instance.id,
  'full_name': instance.fullName,
  'email': instance.email,
  'phone_number': instance.phoneNumber,
  'address': instance.address,
};

VaccinationPrescription _$VaccinationPrescriptionFromJson(
  Map<String, dynamic> json,
) => VaccinationPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num).toInt(),
  myType: vaccinationPrescriptionMyTypeEnumFromJson(json['my_type']),
  duration: durationEnumNullableFromJson(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs:
      (json['drugs'] as List<dynamic>?)
          ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  executions:
      (json['executions'] as List<dynamic>?)
          ?.map(
            (e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  files:
      (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$VaccinationPrescriptionToJson(
  VaccinationPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'my_type': vaccinationPrescriptionMyTypeEnumToJson(instance.myType),
  'duration': durationEnumNullableToJson(instance.duration),
  'description': instance.description,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'drugs': instance.drugs.map((e) => e.toJson()).toList(),
  'executions': instance.executions.map((e) => e.toJson()).toList(),
  'files': instance.files?.map((e) => e.toJson()).toList(),
};

ValuesForSelection _$ValuesForSelectionFromJson(Map<String, dynamic> json) =>
    ValuesForSelection(
      choicesName:
          (json['choices_name'] as List<dynamic>?)
              ?.map(
                (e) =>
                    ValuesForSelectionItem.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$ValuesForSelectionToJson(ValuesForSelection instance) =>
    <String, dynamic>{
      'choices_name': instance.choicesName.map((e) => e.toJson()).toList(),
    };

ValuesForSelectionItem _$ValuesForSelectionItemFromJson(
  Map<String, dynamic> json,
) => ValuesForSelectionItem(
  displayName: json['display_name'] as String,
  value: json['value'] as String,
);

Map<String, dynamic> _$ValuesForSelectionItemToJson(
  ValuesForSelectionItem instance,
) => <String, dynamic>{
  'display_name': instance.displayName,
  'value': instance.value,
};

WoundHealingPrescription _$WoundHealingPrescriptionFromJson(
  Map<String, dynamic> json,
) => WoundHealingPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num).toInt(),
  myType: woundHealingPrescriptionMyTypeEnumFromJson(json['my_type']),
  duration: durationEnumNullableFromJson(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs:
      (json['drugs'] as List<dynamic>?)
          ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  executions:
      (json['executions'] as List<dynamic>?)
          ?.map(
            (e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  files:
      (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$WoundHealingPrescriptionToJson(
  WoundHealingPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'my_type': woundHealingPrescriptionMyTypeEnumToJson(instance.myType),
  'duration': durationEnumNullableToJson(instance.duration),
  'description': instance.description,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'drugs': instance.drugs.map((e) => e.toJson()).toList(),
  'executions': instance.executions.map((e) => e.toJson()).toList(),
  'files': instance.files?.map((e) => e.toJson()).toList(),
};
