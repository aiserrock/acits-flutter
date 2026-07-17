import 'package:animals/animals.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';

/// Реализация навигационного контракта модуля «Животные» через go_router и
/// [AppRoutes] приложения. Модуль зависит только от абстракции
/// [AnimalsRouterService]; конкретные пути живут здесь.
///
/// [GoRouter] резолвится из [getIt] лениво (он регистрируется рантайм-синглтоном
/// в initDi, а не через injectable — как и в auth/deep-link сервисах), чтобы не
/// требовать его constructor-инъекции в dev/test-DI.
@Injectable(as: AnimalsRouterService)
class AnimalsRouterServiceImpl implements AnimalsRouterService {
  const AnimalsRouterServiceImpl(this._animalService);

  final AnimalService _animalService;

  GoRouter get _router => getIt<GoRouter>();

  @override
  void openDetail(int id) => _router.push(AppRoutes.animalDetailPath(id));

  @override
  Future<bool?> openCreate() => _router.push<bool>(AppRoutes.animalEdit);

  @override
  void openEdit(int id) => _router.push('${AppRoutes.animalEdit}?id=$id');

  @override
  void openAnimalPdf(int id) {
    _router.push(
      AppRoutes.docViewer,
      extra: <String, Object?>{
        'fetcher': () => _animalService.fetchPdfAnimalCard(id),
        'title': 'Animal $id',
        'fileName': 'animal_$id.pdf',
      },
    );
  }
}
