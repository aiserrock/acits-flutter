import 'package:flutter/widgets.dart';

import 'pages/pages.dart';

export 'pages/pages.dart';

/// Каталог экспонатов дизайн-системы ACITS.
///
/// Нейтральная структура **без зависимости на widgetbook/storybook**: один
/// [GalleryEntry] на компонент/раздел с секцией, именем и билдером. Хосты
/// (standalone example-апп, debug-экран основного приложения) сами
/// превращают этот список в дерево своего инструмента. Так каталог живёт в
/// `ui_kit` и переиспользуется всеми, а dev-инструмент (widgetbook) не течёт
/// в прод-граф пакета.
class GalleryEntry {
  const GalleryEntry(this.section, this.name, this.builder);

  /// Раздел верхнего уровня: `Foundations` | `Components` | `Layout`.
  final String section;

  /// Имя экспоната внутри раздела (`Colors`, `Buttons`, ...).
  final String name;

  /// Билдер виджета-страницы.
  final WidgetBuilder builder;
}

/// Все экспонаты галереи в порядке отображения. Секции и порядок совпадают с
/// историческим storybook (Foundations → Components → Layout).
const List<GalleryEntry> galleryEntries = <GalleryEntry>[
  // Foundations
  GalleryEntry('Foundations', 'Colors', _colors),
  GalleryEntry('Foundations', 'Typography', _typography),
  GalleryEntry('Foundations', 'Icons', _icons),
  GalleryEntry('Foundations', 'Images', _images),
  GalleryEntry('Foundations', 'Lottie', _lottie),
  // Components
  GalleryEntry('Components', 'Buttons', _buttons),
  GalleryEntry('Components', 'TextField', _textField),
  GalleryEntry('Components', 'Chip', _chip),
  GalleryEntry('Components', 'AppBar', _appBar),
  GalleryEntry('Components', 'BottomSheet', _bottomSheet),
  GalleryEntry('Components', 'Loaders', _loaders),
  GalleryEntry('Components', 'Holders', _holders),
  GalleryEntry('Components', 'SortChipsBar', _sortChips),
  GalleryEntry('Components', 'FormEditCard', _formCard),
  GalleryEntry('Components', 'Misc', _misc),
  // Layout
  GalleryEntry('Layout', 'AdaptiveScaffold', _adaptiveScaffold),
];

Widget _colors(BuildContext _) => const ColorsPage();
Widget _typography(BuildContext _) => const TypographyPage();
Widget _icons(BuildContext _) => const IconsPage();
Widget _images(BuildContext _) => const ImagesPage();
Widget _lottie(BuildContext _) => const LottiePage();
Widget _buttons(BuildContext _) => const ButtonsPage();
Widget _textField(BuildContext _) => const TextFieldPage();
Widget _chip(BuildContext _) => const ChipPage();
Widget _appBar(BuildContext _) => const AppBarPage();
Widget _bottomSheet(BuildContext _) => const BottomSheetPage();
Widget _loaders(BuildContext _) => const LoadersPage();
Widget _holders(BuildContext _) => const HoldersPage();
Widget _sortChips(BuildContext _) => const SortChipsPage();
Widget _formCard(BuildContext _) => const FormCardPage();
Widget _misc(BuildContext _) => const MiscPage();
Widget _adaptiveScaffold(BuildContext _) => const AdaptiveScaffoldPage();
