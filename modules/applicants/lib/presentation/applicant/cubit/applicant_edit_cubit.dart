import 'package:util/util.dart';
import 'package:core/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:applicants/domain/domain.dart';
import 'package:applicants/util/util.dart';

const _emptyApplicant = Applicant(firstName: '', lastName: '', phoneNumber: '');

/// Cubit экрана создания/редактирования заявителя.
///
/// Владеет состоянием загрузки [DataState] и бизнес-логикой (загрузка по id,
/// создание, обновление). Данные — доменный [Applicant] из [StaffRepository]
/// (Result, без DTO). UI-контроллеры ([TextEditingController]) остаются
/// во [StatefulWidget] экрана.
class ApplicantEditCubit extends Cubit<DataState<Applicant>> {
  ApplicantEditCubit(this._repository, {this.applicantId}) : super(const DataState.content(_emptyApplicant)) {
    _init();
  }

  final StaffRepository _repository;
  final int? applicantId;

  /// Режим редактирования (id задан) против создания.
  bool get isEdit => applicantId != null;

  /// Загружает заявителя по id в режиме редактирования.
  Future<void> _init() async {
    if (!isEdit) return;
    Log.debug('ApplicantEditCubit._init: load id=$applicantId');
    safeEmit(const DataState.loading());
    final result = await _repository.getApplicantById(applicantId!);
    result.fold(
      (failure) {
        Log.error('ApplicantEditCubit._init failed: id=$applicantId', failure);
        safeEmit(DataState.error(failure));
      },
      (applicant) {
        Log.info('ApplicantEditCubit._init ok: id=$applicantId');
        safeEmit(DataState.content(applicant));
      },
    );
  }

  /// Отправляет форму: создаёт или обновляет заявителя.
  ///
  /// Возвращает сохранённого [Applicant] при успехе, либо `null` при ошибке.
  Future<Applicant?> submit(Applicant draft) async {
    if (state.isLoading) return null;
    Log.debug('ApplicantEditCubit.submit: isEdit=$isEdit id=$applicantId');
    safeEmit(const DataState.loading());
    final result = isEdit
        ? await _repository.updateApplicant(applicantId!, draft)
        : await _repository.createApplicant(draft);
    return result.fold(
      (failure) {
        Log.error('ApplicantEditCubit.submit failed: id=$applicantId', failure);
        safeEmit(DataState.error(failure));
        return null;
      },
      (applicant) {
        Log.info('ApplicantEditCubit.submit ok: id=$applicantId');
        safeEmit(DataState.content(applicant));
        return applicant;
      },
    );
  }
}
