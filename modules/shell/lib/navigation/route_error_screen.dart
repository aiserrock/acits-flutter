import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart' show ErrorHolderWidget;
import 'package:util/util.dart' show ParseFailure;

import 'package:shell/navigation/app_router.dart';

/// Экран для URL, из которого нельзя восстановить экран: параметры пути/query
/// не разобрались, либо нужной сущности нет и загрузить её по id нечем.
///
/// Показывает стандартную заглушку ошибки. Кнопка возвращает на предыдущий
/// экран, а при прямом заходе по ссылке (вернуться некуда) ведёт на корень.
class RouteErrorScreen extends StatelessWidget {
  const RouteErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ErrorHolderWidget(
          error: const ParseFailure(),
          button: 'commonBack'.tr(),
          onPressed: () => context.canPop() ? context.pop() : context.go(AppRoutes.root),
        ),
      ),
    );
  }
}
