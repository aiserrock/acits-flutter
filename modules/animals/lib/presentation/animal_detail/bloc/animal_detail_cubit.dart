import 'package:util/util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:animals/domain/domain.dart';

/// Cubit карточки животного: грузит богатую сущность [Animal] из
/// [AnimalRepository] (Result, без DTO) в [DataState]. Загрузка назначений
/// (chopper-фича) НЕ здесь — она остаётся в корневом экране: это межфичевая
/// граница strangler-миграции.
class AnimalDetailCubit extends Cubit<DataState<Animal>> {
  AnimalDetailCubit(this._repository, this._shelterProvider, {required this.id}) : super(const DataState.loading()) {
    loadAnimal();
  }

  final AnimalRepository _repository;
  final CurrentShelterProvider _shelterProvider;
  final int id;

  void _safeEmit(DataState<Animal> state) {
    if (isClosed) return;
    emit(state);
  }

  /// Загрузить (или перезагрузить) карточку животного.
  Future<void> loadAnimal() async {
    _safeEmit(const DataState.loading());
    final result = await _repository.getById(id, shelterId: _shelterProvider.shelterId);
    result.fold((failure) => _safeEmit(DataState.error(failure)), (animal) => _safeEmit(DataState.content(animal)));
  }
}
