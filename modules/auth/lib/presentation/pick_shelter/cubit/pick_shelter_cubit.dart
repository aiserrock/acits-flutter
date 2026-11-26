import 'package:util/util.dart';
import 'package:core/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:auth/domain/domain.dart';
import 'package:auth/presentation/pick_shelter/cubit/cubit.dart';

/// Cubit экрана выбора приюта.
///
/// Владеет списком приютов и жизненным циклом выбора ([DataState]). Загрузку
/// конфига и установку текущего приюта делает сам; автоприменение единственного
/// приюта выполняется ровно один раз (защита от повторного входа). Навигацию к
/// корню после успешного выбора делает виджет по возвращённому `true`.
class PickShelterCubit extends Cubit<PickShelterState> {
  /// [shelterList] — необязательный кэш списка из навигации. Без него берётся
  /// список из сессии ([AuthSessionApi.shelterList]); если и он пуст (экран
  /// открыт по ссылке или после перезагрузки страницы), список загружается
  /// самим cubit: пока идёт запрос — состояние загрузки, при сбое — ошибка с
  /// ретраем.
  PickShelterCubit({
    required AuthSessionApi authService,
    required AuthConfigInitializer configService,
    required this.autoSelectSingle,
    List<Shelter>? shelterList,
  }) : _authService = authService,
       _configService = configService,
       super(_initial(shelterList, authService)) {
    if (state.status.isLoading) _loadShelters();
  }

  static PickShelterState _initial(List<Shelter>? passed, AuthSessionApi authService) {
    final shelters = passed ?? authService.shelterList;
    final needsLoad = passed == null && shelters.isEmpty;
    return PickShelterState(
      shelters: shelters,
      status: needsLoad ? const DataState.loading() : const PickShelterState().status,
    );
  }

  final AuthSessionApi _authService;
  final AuthConfigInitializer _configService;

  /// Автоматически выбирать единственный приют без участия пользователя.
  final bool autoSelectSingle;

  /// Флаг однократного автовыбора: защищает от повторного применения при
  /// повторных вызовах [maybeAutoSelectSingle] (напр. из didChangeDependencies).
  bool _autoSelectHandled = false;

  /// Один раз применить единственный приют, если включён [autoSelectSingle].
  ///
  /// Возвращает `true`, если приют был успешно применён и нужно перейти к корню;
  /// `false` — если автовыбор не сработал или уже был обработан ранее.
  Future<bool> maybeAutoSelectSingle() async {
    if (_autoSelectHandled) return false;
    if (!autoSelectSingle || state.results.length != 1) return false;
    _autoSelectHandled = true;
    Log.debug('PickShelterCubit.maybeAutoSelectSingle: auto-selecting single shelter');
    return pickShelter(0);
  }

  /// Применить приют по индексу: загрузить конфиг и установить текущий приют.
  ///
  /// Возвращает `true` при успехе (виджет уходит на корневой экран), `false` —
  /// если применение упало (в состоянии выставляется ошибка и показывается
  /// ретрай).
  Future<bool> pickShelter(int index) async {
    if (state.status.isLoading) return false;
    final results = state.results;
    if (index < 0 || index >= results.length) return false;
    final shelter = results[index];
    Log.debug('PickShelterCubit.pickShelter: index=$index id=${shelter.id}');
    safeEmit(state.copyWith(status: const DataState.loading()));
    final failure =
        (await _authService.setCurrentShelter(shelter.id)).failureOrNull ??
        (await _configService.initConfig(currentShelterId: shelter.id)).failureOrNull;
    if (failure != null) {
      Log.error('PickShelterCubit.pickShelter failed: id=${shelter.id}: $failure');
      safeEmit(state.copyWith(status: DataState.error(failure)));
      return false;
    }
    Log.info('PickShelterCubit.pickShelter ok: id=${shelter.id}');
    return true;
  }

  /// Сбросить ошибку выбора и вернуть экран к отрисовке списка. Если списка
  /// нет (его загрузка упала), загружает его заново.
  void retry() {
    if (state.results.isEmpty) {
      _loadShelters();
      return;
    }
    safeEmit(state.copyWith(status: const PickShelterState().status));
  }

  /// Загрузить список приютов пользователя, когда его нет ни в аргументах
  /// экрана, ни в сессии.
  Future<void> _loadShelters() async {
    Log.debug('PickShelterCubit._loadShelters');
    safeEmit(state.copyWith(status: const DataState.loading()));
    final result = await _authService.getShelterList();
    result.fold(
      (failure) {
        Log.error('PickShelterCubit._loadShelters failed: $failure');
        safeEmit(state.copyWith(status: DataState.error(failure)));
      },
      (shelters) {
        Log.info('PickShelterCubit._loadShelters ok: ${shelters.length} shelters');
        safeEmit(state.copyWith(shelters: shelters, status: const PickShelterState().status));
      },
    );
  }
}
