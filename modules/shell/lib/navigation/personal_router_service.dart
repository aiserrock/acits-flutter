import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:personal/personal.dart';

import 'package:di/di.dart';
import 'package:shell/navigation/app_router.dart';

/// Реализация навигационного контракта модуля «Личный кабинет / комментарии»
/// через go_router приложения. Модуль зависит только от абстракции
/// [PersonalRouterService]; конкретные роуты живут здесь.
///
/// [GoRouter] резолвится из [getIt] лениво (как в остальных router-сервисах).
@Injectable(as: PersonalRouterService)
class PersonalRouterServiceImpl implements PersonalRouterService {
  const PersonalRouterServiceImpl();

  GoRouter get _router => getIt<GoRouter>();

  @override
  Future<AnimalNote?> openCommentEdit(int animalId, {AnimalNote? comment}) =>
      _router.push<AnimalNote>(AppRoutes.commentEditPath(animalId), extra: comment);
}
