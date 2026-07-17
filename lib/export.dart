export 'package:acits_flutter/util/util.dart';
export 'package:acits_flutter/domain/animal.dart';
export 'package:acits_flutter/domain/animal_note/animal_note.dart';
export 'package:acits_flutter/domain/animal_note/animal_note_file.dart';
export 'package:acits_flutter/domain/prescription.dart';
// Заявители/кураторы мигрированы на доменные сущности — берём их из домена, а
// одноимённые chopper-типы прячем из ре-экспорта ниже.
export 'package:acits_domain/acits_domain.dart' show Applicant, Curator;
// Заметки, назначения/лекарства и сотрудники мигрированы на доменные сущности —
// прячем соответствующие chopper-типы из ре-экспорта, чтобы UI брал сущности
// выше. (config_service больше не импортит gen/api.)
export 'package:acits_flutter/gen/api/openapi.swagger.dart'
    hide
        AnimalNote,
        AnimalNoteFile,
        AnimalShort,
        Applicant,
        Curator,
        Drug,
        PaginatedPrescriptionExecutionTodayList,
        PaginatedPrescriptionList,
        PaginatedShelterDrugList,
        PatchedAnimalNote,
        PatchedPrescription,
        Prescription,
        PrescriptionDrug,
        PrescriptionExecution,
        PrescriptionExecutionToday,
        PrescriptionFile,
        PrescriptionShort,
        ShelterDrug;
export 'package:acits_flutter/gen/assets.gen.dart';
export 'package:acits_flutter/res/theme.dart';
export 'package:acits_flutter/res/icon.dart';
export 'package:acits_flutter/res/lottie.dart';
export 'package:acits_flutter/gen/l10n/locale_keys.g.dart';
export 'package:collection/collection.dart';
export 'package:easy_localization/easy_localization.dart';
