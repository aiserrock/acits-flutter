import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:animals/domain/domain.dart';
import 'package:animals/presentation/animals_list/animals_list.dart';

/// Точка входа фичи «Список животных». Поднимает [AnimalsCubit] (репозиторий +
/// текущий приют) и отдаёт его во [AnimalsView]. Зависимости приходят от корня
/// (DI): порты навигации/прав/названий-статусов и app-ассеты как виджеты.
class AnimalsPage extends StatelessWidget {
  const AnimalsPage({
    required this.repository,
    required this.shelterProvider,
    required this.router,
    required this.permissions,
    required this.statusLabels,
    this.onMenuPressed,
    this.emptyStateIllustration,
    this.avatarFallback,
    super.key,
  });

  final AnimalRepository repository;
  final CurrentShelterProvider shelterProvider;
  final AnimalsRouterService router;
  final AnimalPermissions permissions;
  final AnimalStatusLabels statusLabels;
  final VoidCallback? onMenuPressed;
  final Widget? emptyStateIllustration;
  final Widget? avatarFallback;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AnimalsCubit(repository, shelterProvider),
      child: AnimalsView(
        router: router,
        permissions: permissions,
        statusLabels: statusLabels,
        onMenuPressed: onMenuPressed,
        emptyStateIllustration: emptyStateIllustration,
        avatarFallback: avatarFallback,
      ),
    );
  }
}
