import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// Полноэкранные заглушки состояний: [ErrorHolderWidget], [SuccessHolderWidget],
/// [ErrorStubWidget].
///
/// NB: часть подписей этих виджетов резолвится через easy_localization `.tr()`.
/// В storybook нет бандла переводов, поэтому кнопки-ключи (`commonReloadBtn`
/// и т.п.) показываются как есть. Явно заданные title/message отображаются
/// нормально.
///
/// Виджеты сайзят Lottie как `min(maxH, maxW) * 0.75`, поэтому им нужна
/// квадратная-ish область: ограничиваем ширину и даём достаточную высоту, иначе
/// внутренняя Column переполняется.
class HoldersPage extends StatelessWidget {
  const HoldersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Holders')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _label(context, 'ErrorHolderWidget'),
          _Frame(
            child: ErrorHolderWidget(
              title: 'Что-то пошло не так',
              message: 'Не удалось загрузить данные. Попробуйте ещё раз.',
              button: 'Повторить',
              onPressed: () {},
            ),
          ),
          const Divider(height: 40.0),
          _label(context, 'SuccessHolderWidget'),
          _Frame(
            child: SuccessHolderWidget(
              title: 'Успешно',
              message: 'Изменения сохранены',
              button: 'Готово',
              onPressed: () {},
            ),
          ),
          const Divider(height: 40.0),
          _label(context, 'ErrorStubWidget'),
          _Frame(
            child: ErrorStubWidget(
              onPressed: () {},
              image: Assets.icon.errorStub.svg(height: 120.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(text, style: Theme.of(context).textTheme.titleSmall),
  );
}

/// Центрированная область ограниченной ширины и высоты под holder-виджет.
class _Frame extends StatelessWidget {
  const _Frame({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Ширина ограничена (Lottie сайзится как min(h,w)*0.75 → от ширины), высота
    // с запасом, чтобы non-scrollable Column виджета не переполнялась.
    return Center(child: SizedBox(width: 360.0, height: 560.0, child: child));
  }
}
