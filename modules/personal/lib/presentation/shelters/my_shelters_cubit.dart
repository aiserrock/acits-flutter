import 'package:core/domain.dart' show Shelter;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/util.dart';

import 'package:personal/domain/domain.dart';

/// Cubit of the «My organisations» screen: loads the user's shelters from a
/// [MySheltersSource]. Read-only; switching is handled by the host app.
class MySheltersCubit extends Cubit<DataState<List<Shelter>>> {
  MySheltersCubit(this._source) : super(const DataState.loading());

  final MySheltersSource _source;

  /// Id of the current shelter, read at build time so the mark follows the session.
  int? get currentShelterId => _source.currentShelterId;

  /// Loads the list, showing the loader. Also serves as the retry action.
  Future<void> load() {
    safeEmit(const DataState.loading());
    return refresh();
  }

  /// Reloads the list while keeping the current one on screen (pull-to-refresh).
  Future<void> refresh() async {
    Log.debug('MySheltersCubit.refresh');
    final result = await _source.load();
    result.fold(
      (failure) {
        Log.error('MySheltersCubit.refresh failed: $failure');
        safeEmit(DataState.error(failure));
      },
      (shelters) {
        Log.info('MySheltersCubit.refresh ok: count=${shelters.length}');
        safeEmit(DataState.content(shelters));
      },
    );
  }
}
