import 'package:util/util.dart';
import 'package:core/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:applicants/domain/domain.dart';
import 'package:applicants/util/util.dart';

const _emptyCurator = Curator(firstName: '', lastName: '', phoneNumber: '', address: '');

/// Cubit экрана создания/редактирования куратора.
///
/// Владеет состоянием загрузки [DataState]<[Curator]> и бизнес-логикой
/// (загрузка по id, создание, обновление). Данные — доменный [Curator] из
/// [StaffRepository] (Result, без DTO). UI-контроллеры остаются в виджете.
class CuratorEditCubit extends Cubit<DataState<Curator>> {
  CuratorEditCubit(this._repository, {this.curatorId}) : super(const DataState.content(_emptyCurator)) {
    _init();
  }

  final StaffRepository _repository;
  final int? curatorId;

  /// Режим редактирования (id задан) против создания.
  bool get isEdit => curatorId != null;

  /// Загружает куратора по id в режиме редактирования.
  Future<void> _init() async {
    if (!isEdit) return;
    Log.debug('CuratorEditCubit.init curatorId=$curatorId');
    safeEmit(const DataState.loading());
    final result = await _repository.getCuratorById(curatorId!);
    result.fold(
      (failure) {
        Log.error('CuratorEditCubit.init failed', failure);
        safeEmit(DataState.error(failure));
      },
      (curator) {
        Log.info('CuratorEditCubit.init ok: id=${curator.id}');
        safeEmit(DataState.content(curator));
      },
    );
  }

  /// Сохраняет куратора (создание или обновление).
  ///
  /// Возвращает сохранённого [Curator] при успехе или null при ошибке.
  Future<Curator?> submit(Curator draft) async {
    if (state.isLoading) return null;
    Log.debug('CuratorEditCubit.submit isEdit=$isEdit curatorId=$curatorId');
    safeEmit(const DataState.loading());
    final result = isEdit ? await _repository.updateCurator(curatorId!, draft) : await _repository.createCurator(draft);
    return result.fold(
      (failure) {
        Log.error('CuratorEditCubit.submit failed', failure);
        safeEmit(DataState.error(failure));
        return null;
      },
      (curator) {
        Log.info('CuratorEditCubit.submit ok: id=${curator.id}');
        safeEmit(DataState.content(curator));
        return curator;
      },
    );
  }
}
