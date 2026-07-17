import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Ассеты, которые использует UI медиа-модуля.
///
/// Ассеты физически лежат в бандле приложения (`assets/**`); модуль ссылается
/// на них строковыми путями через [SvgPicture.asset] / [Image.asset] (как
/// `.tr()` резолвит переводы из бандла приложения). Значения совпадают с
/// исходными путями из app `gen/assets.gen.dart`.
abstract final class MediaAssets {
  /// SVG-иконка «очистить» в поле поиска.
  static const closeIcon = 'assets/icon/close.svg';

  /// SVG-заглушка «ничего не найдено».
  static const emptyState = 'assets/common/empty_state.svg';

  /// SVG-заглушка ошибки (для [ui_kit] ErrorStubWidget).
  static const errorStub = 'assets/image/error_stub.svg';

  /// PNG-заглушка сетевого фото животного (для ShimmerNetworkImage).
  static const animalStub = 'assets/image/animal_stub.png';

  /// Пресетные аватарки-заготовки для галереи фото.
  static const galleryAvatars = <String>[
    'assets/gallery/avatar_alpaka.png',
    'assets/gallery/avatar_cat_0.png',
    'assets/gallery/avatar_cat_1.png',
    'assets/gallery/avatar_dog.png',
    'assets/gallery/avatar_dolphin.png',
    'assets/gallery/avatar_eagle.png',
    'assets/gallery/avatar_mouse.png',
  ];

  static Widget closeIconSvg({double? width, double? height, Color? color}) => SvgPicture.asset(
    closeIcon,
    width: width,
    height: height,
    colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
  );

  static Widget emptyStateSvg() => SvgPicture.asset(emptyState);

  static Widget errorStubSvg() => SvgPicture.asset(errorStub);

  static Widget animalStubImage({BoxFit? fit, double? width, double? height}) =>
      Image.asset(animalStub, fit: fit, width: width, height: height);
}
