import 'package:ui_kit/ui_kit.dart';

/// Ресурсы анимации state holders. Ассеты живут в дизайн-системе (ui_kit) и
/// резолвятся как `packages/ui_kit/assets/lottie/...` через package-scoped
/// [Assets.lottie]. Значения — те же пути, только с package-префиксом.
class LottieRes {
  LottieRes._();

  static final loading = Assets.lottie.loading,
      pawLoading = Assets.lottie.pawLoading,
      dogLoading = Assets.lottie.dogLoading,
      catsLoading = Assets.lottie.catsLoading,
      crashScratch = Assets.lottie.crash,
      crashBox = Assets.lottie.crash1,
      success = Assets.lottie.success;
}
