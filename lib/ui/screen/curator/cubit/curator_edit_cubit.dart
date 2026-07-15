import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/staff/staff_service.dart';
import 'package:acits_flutter/util/logger/log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit экрана создания/редактирования куратора.
///
/// Владеет состоянием загрузки [DataState]<[Curator]> и бизнес-логикой
/// (загрузка по id, создание, обновление). UI-контроллеры остаются в виджете.
class CuratorEditCubit extends Cubit<DataState<Curator>> {
  CuratorEditCubit({this.curatorId})
    : _service = getIt<StaffService>(),
      super(DataState.content(const Curator(firstName: '', lastName: '', phoneNumber: '', address: ''))) {
    _init();
  }

  final StaffService _service;
  final int? curatorId;

  /// Режим редактирования (id задан) против создания.
  bool get isEdit => curatorId != null;

  /// Загружает куратора по id в режиме редактирования.
  Future<void> _init() async {
    if (!isEdit) return;
    Log.debug('CuratorEditCubit.init curatorId=$curatorId');
    safeEmit(const DataState.loading());
    try {
      final curator = await _service.fetchCuratorById(id: curatorId!);
      Log.info('CuratorEditCubit.init ok: id=${curator?.id}');
      safeEmit(DataState.content(curator ?? const Curator(firstName: '', lastName: '', phoneNumber: '', address: '')));
    } catch (e, s) {
      Log.error('CuratorEditCubit.init failed', e, s);
      safeEmit(DataState.error(e));
    }
  }

  /// Сохраняет куратора (создание или обновление).
  ///
  /// Возвращает сохранённого [Curator] при успехе или null при ошибке.
  Future<Curator?> submit(Curator draft) async {
    if (state.isLoading) return null;
    Log.debug('CuratorEditCubit.submit isEdit=$isEdit curatorId=$curatorId');
    safeEmit(const DataState.loading());
    try {
      final result = isEdit
          ? await _service.updateCurator(id: curatorId!, curator: draft)
          : await _service.createCurator(curator: draft);
      Log.info('CuratorEditCubit.submit ok: id=${result?.id}');
      safeEmit(DataState.content(result ?? draft));
      return result;
    } catch (e, s) {
      Log.error('CuratorEditCubit.submit failed', e, s);
      safeEmit(DataState.error(e));
      return null;
    }
  }
}
