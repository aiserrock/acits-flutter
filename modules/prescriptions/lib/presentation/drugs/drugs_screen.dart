import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prescriptions/domain/domain.dart';
import 'package:prescriptions/presentation/drugs/cubit/cubit.dart';
import 'package:prescriptions/presentation/drugs/drugs_view.dart';

/// Точка входа экрана «Медикаменты» (read-only каталог препаратов приюта).
/// Поднимает [DrugsCubit] поверх [PrescriptionRepository].
class DrugsScreen extends StatelessWidget {
  const DrugsScreen({required this.repository, this.onMenuPressed, super.key});

  final PrescriptionRepository repository;

  /// Открыть корневой drawer (app-level). null — кнопка-меню ничего не делает.
  final VoidCallback? onMenuPressed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DrugsCubit(repository),
      child: DrugsView(onMenuPressed: onMenuPressed),
    );
  }
}
