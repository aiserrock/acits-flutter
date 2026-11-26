import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prescriptions/domain/domain.dart';
import 'package:prescriptions/presentation/calendar/calendar_view.dart';
import 'package:prescriptions/presentation/calendar/cubit/cubit.dart';

/// Точка входа экрана «Календарь» (read-only): месяц с отметками дней, где есть
/// исполнения назначений, и список исполнений выбранного дня. Поднимает
/// [CalendarCubit] поверх [PrescriptionRepository].
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({required this.repository, this.onMenuPressed, super.key});

  final PrescriptionRepository repository;

  /// Открыть корневой drawer (app-level). null — кнопка-меню ничего не делает.
  final VoidCallback? onMenuPressed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalendarCubit(repository),
      child: CalendarView(onMenuPressed: onMenuPressed),
    );
  }
}
