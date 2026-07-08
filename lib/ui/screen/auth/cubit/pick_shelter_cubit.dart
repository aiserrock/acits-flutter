import 'package:acits_flutter/api/openapi.swagger.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:acits_flutter/ui/screen/auth/cubit/pick_shelter_state.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:acits_flutter/util/bloc_ext.dart';

/// Cubit экрана выбора приюта.
///
/// Владеет списком приютов и жизненным циклом выбора ([DataState]). Загрузку
/// конфига и установку текущего приюта делает сам; автоприменение единственного
/// приюта выполняется ровно один раз (защита от повторного входа). Навигацию к
/// корню после успешного выбора делает виджет по возвращённому `true`.
class PickShelterCubit extends Cubit<PickShelterState> {
  PickShelterCubit({
    required this.autoSelectSingle,
    PaginatedShelterShortSerializersList? shelterList,
  }) : super(PickShelterState(shelters: shelterList ?? getIt<AuthService>().shelterList));

  final AuthService _authService = getIt<AuthService>();
  final ConfigService _configService = getIt<ConfigService>();

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
    safeEmit(state.copyWith(status: const DataState.loading()));
    try {
      await _authService.setCurrentShelter(shelter.id!);
      await _configService.initConfig(currentShelterId: shelter.id);
      return true;
    } catch (e) {
      safeEmit(state.copyWith(status: DataState.error(e)));
      return false;
    }
  }

  /// Сбросить ошибку выбора и вернуть экран к отрисовке списка.
  void retry() {
    safeEmit(state.copyWith(status: const PickShelterState().status));
  }
}
