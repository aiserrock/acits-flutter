import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

import 'package:prescriptions/presentation/calendar/cubit/cubit.dart';
import 'package:prescriptions/presentation/calendar/widgets/day_executions.dart';
import 'package:prescriptions/presentation/calendar/widgets/month_grid.dart';

/// Экран «Календарь» (read-only). Cubit поднимает родитель ([CalendarScreen])
/// через BlocProvider.
class CalendarView extends StatelessWidget {
  const CalendarView({this.onMenuPressed, super.key});

  /// Открыть корневой drawer. null — кнопка-меню ничего не делает.
  final VoidCallback? onMenuPressed;

  static const _gridMaxWidth = 560.0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final localizations = MaterialLocalizations.of(context);
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        final cubit = context.read<CalendarCubit>();
        return Scaffold(
          backgroundColor: scheme.surface,
          appBar: AppBar(
            backgroundColor: scheme.surface,
            shadowColor: Colors.transparent,
            leading: IconButton(
              tooltip: localizations.openAppDrawerTooltip,
              onPressed: onMenuPressed,
              icon: Icon(Icons.menu, color: scheme.primary),
            ),
            title: Text(LocaleKeys.commonCalendar.tr(), style: TextStyle(color: scheme.onSurface)),
            centerTitle: true,
            actions: [
              IconButton(
                tooltip: LocaleKeys.calendarPrevMonth.tr(),
                onPressed: () => cubit.showMonth(DateTime(state.visibleMonth.year, state.visibleMonth.month - 1)),
                icon: Icon(Icons.chevron_left, color: scheme.primary),
              ),
              IconButton(
                tooltip: LocaleKeys.calendarNextMonth.tr(),
                onPressed: () => cubit.showMonth(DateTime(state.visibleMonth.year, state.visibleMonth.month + 1)),
                icon: Icon(Icons.chevron_right, color: scheme.primary),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  tooltip: LocaleKeys.commonToday.tr(),
                  onPressed: cubit.goToToday,
                  icon: Icon(Icons.today, color: scheme.primary),
                ),
              ),
            ],
          ),
          body: ListDetailLayout.isSplit(context) ? _buildSplit(context, state) : _buildNarrow(context, state),
        );
      },
    );
  }

  Widget _buildNarrow(BuildContext context, CalendarState state) {
    return ContentWidth(
      maxWidth: ContentWidth.reading,
      child: _refreshable(
        context,
        ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          children: [
            _MonthHeader(month: state.visibleMonth),
            _grid(context, state),
            const SizedBox(height: 24.0),
            _day(context, state),
          ],
        ),
      ),
    );
  }

  Widget _buildSplit(BuildContext context, CalendarState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _gridMaxWidth),
              child: _refreshable(
                context,
                ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _MonthHeader(month: state.visibleMonth),
                    _grid(context, state),
                  ],
                ),
              ),
            ),
          ),
        ),
        const VerticalDivider(width: 1.0, thickness: 1.0),
        SizedBox(
          width: ListDetailLayout.defaultListWidth,
          child: _refreshable(
            context,
            ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              children: [_day(context, state)],
            ),
          ),
        ),
      ],
    );
  }

  Widget _refreshable(BuildContext context, Widget child) {
    return RefreshIndicator(onRefresh: () => context.read<CalendarCubit>().load(), child: child);
  }

  Widget _grid(BuildContext context, CalendarState state) {
    return MonthGrid(
      month: state.visibleMonth,
      selectedDay: state.selectedDay,
      executions: state.data.valueOrNull,
      onDaySelected: context.read<CalendarCubit>().selectDay,
    );
  }

  Widget _day(BuildContext context, CalendarState state) {
    return DayExecutions(state: state, onRetry: context.read<CalendarCubit>().load);
  }
}

class _MonthHeader extends StatelessWidget {
  const _MonthHeader({required this.month});

  final DateTime month;

  @override
  Widget build(BuildContext context) {
    final title = toBeginningOfSentenceCase(DateFormat.yMMMM(context.locale.toString()).format(month));
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Semantics(
        header: true,
        liveRegion: true,
        child: Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
