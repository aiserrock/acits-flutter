export 'package:acits_flutter/util/util.dart';
export 'package:acits_flutter/domain/animal.dart';
export 'package:acits_flutter/domain/animal_note/animal_note.dart';
export 'package:acits_flutter/domain/animal_note/animal_note_file.dart';
export 'package:acits_flutter/domain/applicant.dart';
export 'package:acits_flutter/domain/prescription.dart';
// Заметки и назначения/лекарства мигрированы на доменные сущности — прячем
// соответствующие chopper-типы из ре-экспорта, чтобы UI брал сущности выше.
// (config_service ещё импортит gen/api напрямую — на него это не влияет.)
export 'package:acits_flutter/gen/api/openapi.swagger.dart'
    hide
        AnimalNote,
        AnimalNoteFile,
        AnimalShort,
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
