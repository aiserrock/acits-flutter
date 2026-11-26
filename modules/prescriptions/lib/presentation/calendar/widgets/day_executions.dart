import 'package:easy_localization/easy_localization.dart';
import 'package:localization/localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:util/util.dart';

import 'package:prescriptions/presentation/calendar/cubit/cubit.dart';
import 'package:prescriptions/presentation/calendar/widgets/calendar_execution_card.dart';

/// Блок выбранного дня: заголовок с датой и список исполнений по времени.
/// Пока месяц грузится — лоадер, при ошибке — заглушка с повтором, у пустого
/// дня — сообщение.
class DayExecutions extends StatelessWidget {
  const DayExecutions({required this.state, required this.onRetry, super.key});

  final CalendarState state;
  final VoidCallback onRetry;

  static const _stubHeight = 240.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = toBeginningOfSentenceCase(DateFormat.yMMMMEEEEd(context.locale.toString()).format(state.selectedDay));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(header: true, child: Text(title, style: theme.textTheme.titleMedium)),
        const SizedBox(height: 12.0),
        DataStateBuilder<CalendarExecutions>(
          state: state.data,
          loader: (_) => const SizedBox(height: _stubHeight, child: LoaderHolderWidget()),
          errorBuilder: (_, error) => SizedBox(
            height: _stubHeight,
            child: ErrorHolderWidget(error: error, onPressed: onRetry),
          ),
          builder: (context, _) => _buildList(context),
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    final executions = state.selectedExecutions;
    if (executions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Text(
          LocaleKeys.calendarEmptyDay.tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }
    return Column(
      children: [
        for (final execution in executions)
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: CalendarExecutionCard(execution: execution),
          ),
      ],
    );
  }
}
