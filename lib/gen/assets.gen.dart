/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsCommonGen {
  const $AssetsCommonGen();

  /// File path: assets/common/empty_state.svg
  SvgGenImage get emptyState =>
      const SvgGenImage('assets/common/empty_state.svg');
}

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/calendar.svg
  SvgGenImage get calendar => const SvgGenImage('assets/icon/calendar.svg');

  /// File path: assets/icon/close.svg
  SvgGenImage get close => const SvgGenImage('assets/icon/close.svg');

  /// File path: assets/icon/drugs.svg
  SvgGenImage get drugs => const SvgGenImage('assets/icon/drugs.svg');

  /// File path: assets/icon/paw.svg
  SvgGenImage get paw => const SvgGenImage('assets/icon/paw.svg');

  /// File path: assets/icon/today.svg
  SvgGenImage get today => const SvgGenImage('assets/icon/today.svg');

  /// File path: assets/icon/visible.svg
  SvgGenImage get visible => const SvgGenImage('assets/icon/visible.svg');

  /// File path: assets/icon/visible_off.svg
  SvgGenImage get visibleOff =>
      const SvgGenImage('assets/icon/visible_off.svg');
}

class $AssetsImageGen {
  const $AssetsImageGen();

  /// File path: assets/image/logo_bar.svg
  SvgGenImage get logoBar => const SvgGenImage('assets/image/logo_bar.svg');

  /// File path: assets/image/logo_leading_bar.svg
  SvgGenImage get logoLeadingBar =>
      const SvgGenImage('assets/image/logo_leading_bar.svg');

  /// File path: assets/image/logo_native.png
  AssetGenImage get logoNative =>
      const AssetGenImage('assets/image/logo_native.png');

  /// File path: assets/image/logo_splash.svg
  SvgGenImage get logoSplash =>
      const SvgGenImage('assets/image/logo_splash.svg');
}

class $AssetsOnboardingGen {
  const $AssetsOnboardingGen();

  /// File path: assets/onboarding/drugs.svg
  SvgGenImage get drugs => const SvgGenImage('assets/onboarding/drugs.svg');

  /// File path: assets/onboarding/free.svg
  SvgGenImage get free => const SvgGenImage('assets/onboarding/free.svg');

  /// File path: assets/onboarding/news.svg
  SvgGenImage get news => const SvgGenImage('assets/onboarding/news.svg');

  /// File path: assets/onboarding/plan.svg
  SvgGenImage get plan => const SvgGenImage('assets/onboarding/plan.svg');
}

class Assets {
  Assets._();

  static const $AssetsCommonGen common = $AssetsCommonGen();
  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsImageGen image = $AssetsImageGen();
  static const $AssetsOnboardingGen onboarding = $AssetsOnboardingGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
    );
  }

  String get path => _assetName;
}
