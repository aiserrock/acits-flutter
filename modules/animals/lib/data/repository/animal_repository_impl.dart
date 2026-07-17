import 'package:acits_api/acits_api.dart';
import 'package:acits_core/acits_core.dart';
import 'package:dio/dio.dart';

import '../../domain/animal.dart';
import '../../domain/animal_edit_input.dart';
import '../../domain/animal_list_item.dart';
import '../../domain/animal_repository.dart';
import '../../domain/animal_species.dart';
import '../data_source/animal_remote_data_source.dart';
import '../mapper/animal_list_item_mapper.dart';
import '../mapper/animal_mapper.dart';
import '../mapper/animal_write_mapper.dart';

/// Реализация [AnimalRepository]. Здесь DTO заканчиваются: вызываем data source,
/// разворачиваем DTO → сущности мапперами, ловим исключения → типизированный
/// [Failure]. Наружу (в домен/UI) уходят только сущности в [Result].
class AnimalRepositoryImpl implements AnimalRepository {
  const AnimalRepositoryImpl(this._remote);

  final AnimalRemoteDataSource _remote;

  @override
  Future<Result<Failure, List<AnimalListItem>>> list({
    int? shelterId,
    String? search,
    String? ordering,
    int? limit,
    int? offset,
  }) {
    return _guard(() async {
      final dtos = await _remote.list(
        shelterId: shelterId,
        search: search,
        ordering: ordering,
        limit: limit,
        offset: offset,
      );
      return dtos.map((d) => AnimalListItemMapper(d).toEntity()).toList(growable: false);
    });
  }

  @override
  Future<Result<Failure, Animal>> getById(int id, {int? shelterId}) {
    return _guard(() async {
      final dto = await _remote.getById(id, shelterId: shelterId);
      return AnimalMapper(dto).toEntity();
    });
  }

  @override
  Future<Result<Failure, Animal>> create(
    Animal animal, {
    required List<AnimalAttributeInput> attributes,
    List<AnimalImageInput> newImages = const [],
    List<int> retainImageIds = const [],
    int? shelterId,
  }) {
    return _guard(() async {
      final body = _buildWriteDto(animal, attributes, newImages, retainImageIds);
      final dto = await _remote.create(body, shelterId: shelterId);
      return AnimalMapper(dto).toEntity();
    });
  }

  @override
  Future<Result<Failure, Animal>> update(
    int id,
    Animal animal, {
    required List<AnimalAttributeInput> attributes,
    List<AnimalImageInput> newImages = const [],
    List<int> retainImageIds = const [],
    int? shelterId,
  }) {
    return _guard(() async {
      final body = _buildWriteDto(animal, attributes, newImages, retainImageIds);
      final dto = await _remote.update(id, body, shelterId: shelterId);
      return AnimalMapper(dto).toEntity();
    });
  }

  @override
  Future<Result<Failure, void>> delete(int id, {int? shelterId}) {
    return _guard(() => _remote.delete(id, shelterId: shelterId));
  }

  @override
  Future<Result<Failure, List<AnimalSpecies>>> listSpecies({
    required int level,
    int? parentId,
    String? search,
    int? limit,
    int? offset,
    int? shelterId,
  }) {
    return _guard(() async {
      final dtos = await _remote.listSpecies(
        level: level,
        parentId: parentId,
        search: search,
        limit: limit,
        offset: offset,
        shelterId: shelterId,
      );
      return dtos.map(_mapSpecies).toList(growable: false);
    });
  }

  AnimalWriteDto _buildWriteDto(
    Animal animal,
    List<AnimalAttributeInput> attributes,
    List<AnimalImageInput> newImages,
    List<int> retainImageIds,
  ) {
    return animalToWriteDto(
      animal,
      attributes: attributes
          .map((a) => AnimalAttributeDto(attrId: a.attrId, name: a.name, value: a.value, isRequired: a.isRequired))
          .toList(growable: false),
      newImages: newImages
          .map((i) => AnimalImageWriteDto(name: i.name, image: i.image, isPrimary: i.isPrimary))
          .toList(growable: false),
      retainImageIds: retainImageIds,
    );
  }

  static AnimalSpecies _mapSpecies(SpeciesDto s) => AnimalSpecies(
    id: s.id,
    name: s.name,
    level: s.level,
    parentId: s.parentId,
    parentName: s.parentName,
    categoryName: s.categoryName,
  );

  /// Единая точка: сеть/парсинг-ошибки → типизированный [Failure].
  Future<Result<Failure, T>> _guard<T>(Future<T> Function() body) async {
    try {
      return Ok(await body());
    } on DioException catch (e) {
      return Err(_mapDioException(e));
    } on FormatException {
      return const Err(ParseFailure());
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }

  Failure _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const Timeout();
      case DioExceptionType.connectionError:
        return const NoInternet();
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        if (code == 401 || code == 403) return const AuthFailure();
        return ServerFailure(code ?? 0, e.response?.statusMessage);
      case DioExceptionType.badCertificate:
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
        return const UnknownFailure();
    }
  }
}
