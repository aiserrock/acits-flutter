import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

/// Ассеты, которые использует UI медиа-модуля.
///
/// Ассеты живут в дизайн-системе (ui_kit) и резолвятся как
/// `packages/ui_kit/assets/**` через package-scoped [Assets]. Строковые пути
/// (галерея) берутся из `keyName` — то есть с package-префиксом, чтобы
/// [Image.asset] нашёл их в бандле приложения.
abstract final class MediaAssets {
  /// Пресетные аватарки-заготовки для галереи фото (package-scoped пути).
  static final galleryAvatars = <String>[
    Assets.gallery.avatarAlpaka.keyName,
    Assets.gallery.avatarCat0.keyName,
    Assets.gallery.avatarCat1.keyName,
    Assets.gallery.avatarDog.keyName,
    Assets.gallery.avatarDolphin.keyName,
    Assets.gallery.avatarEagle.keyName,
    Assets.gallery.avatarMouse.keyName,
  ];

  static Widget closeIconSvg({double? width, double? height, Color? color}) =>
      Assets.icon.close.svg(
        width: width,
        height: height,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      );

  static Widget emptyStateSvg() => Assets.common.emptyState.svg();

  static Widget errorStubSvg() => Assets.icon.errorStub.svg();

  static Widget animalStubImage({BoxFit? fit, double? width, double? height}) =>
      Assets.image.animalStub.image(fit: fit, width: width, height: height);
}
