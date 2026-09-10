import 'package:animals/animals.dart' show AnimalListItem;
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:prescriptions/prescriptions.dart';

import 'package:di/di.dart';
import 'package:shell/navigation/app_router.dart';
import 'package:media/media.dart' show SearchTypeKey;

/// Реализация навигационного контракта модуля «Назначения» через go_router и
/// generic-поиск приложения. Модуль зависит только от абстракции
/// [PrescriptionsRouterService]; конкретные роуты/типы поиска живут здесь.
///
/// [GoRouter] резолвится из [getIt] лениво (регистрируется рантайм-синглтоном в
/// initDi), как в animals/auth router-сервисах.
@Injectable(as: PrescriptionsRouterService)
class PrescriptionsRouterServiceImpl implements PrescriptionsRouterService {
  const PrescriptionsRouterServiceImpl();

  GoRouter get _router => getIt<GoRouter>();

  @override
  Future<PrescriptionAnimalRef?> pickAnimal() async {
    final animal = await _router.push<AnimalListItem>(AppRoutes.searchPath(SearchTypeKey.animal));
    if (animal == null) return null;
    return PrescriptionAnimalRef(id: animal.id, name: animal.name, thumbUrl: animal.thumbUrl);
  }

  @override
  Future<Drug?> pickDrug() => _router.push<Drug>(AppRoutes.searchPath(SearchTypeKey.drug));
}
