import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/staff/staff_service.dart';
import 'package:acits_flutter/util/logger/log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit экрана создания/редактирования заявителя.
///
/// Владеет состоянием загрузки [DataState] и бизнес-логикой (загрузка по id,
/// создание, обновление). UI-контроллеры ([TextEditingController]) остаются
/// во [StatefulWidget] экрана.
class ApplicantEditCubit extends Cubit<DataState<Applicant>> {
  ApplicantEditCubit({this.applicantId})
    : _service = getIt<StaffService>(),
      super(DataState.content(const Applicant(firstName: '', lastName: '', phoneNumber: ''))) {
    _init();
  }

  final StaffService _service;
  final int? applicantId;

  /// Режим редактирования (id задан) против создания.
  bool get isEdit => applicantId != null;

  /// Загружает заявителя по id в режиме редактирования.
  Future<void> _init() async {
    if (!isEdit) return;
    Log.debug('ApplicantEditCubit._init: load id=$applicantId');
    safeEmit(const DataState.loading());
    try {
      final applicant = await _service.fetchApplicantById(id: applicantId!);
      Log.info('ApplicantEditCubit._init ok: id=$applicantId');
      safeEmit(
        DataState.content(
          applicant ?? const Applicant(firstName: '', lastName: '', phoneNumber: ''),
        ),
      );
    } catch (e, s) {
      Log.error('ApplicantEditCubit._init failed: id=$applicantId', e, s);
      safeEmit(DataState.error(e));
    }
  }

  /// Отправляет форму: создаёт или обновляет заявителя.
  ///
  /// Возвращает сохранённого [Applicant] при успехе, либо `null` при ошибке.
  Future<Applicant?> submit(Applicant draft) async {
    if (state.isLoading) return null;
    Log.debug('ApplicantEditCubit.submit: isEdit=$isEdit id=$applicantId');
    final previous =
        state.valueOrNull ?? const Applicant(firstName: '', lastName: '', phoneNumber: '');
    safeEmit(const DataState.loading());
    try {
      final Applicant? result;
      if (isEdit) {
        result = await _service.updateApplicant(id: applicantId!, applicant: draft);
      } else {
        result = await _service.createApplicant(applicant: draft);
      }
      Log.info('ApplicantEditCubit.submit ok: id=$applicantId');
      safeEmit(DataState.content(result ?? previous));
      return result;
    } catch (e, s) {
      Log.error('ApplicantEditCubit.submit failed: id=$applicantId', e, s);
      safeEmit(DataState.error(e));
      return null;
    }
  }
}
