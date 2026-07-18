import 'package:ui_kit/ui_kit.dart';

/// Пути к lottie-анимациям, которые использует UI модуля «Личный кабинет /
/// комментарии».
///
/// Ассеты живут в дизайн-системе (ui_kit) и резолвятся как
/// `packages/ui_kit/assets/lottie/...` через package-scoped [Assets.lottie].
abstract final class PersonalLottieRes {
  static final loading = Assets.lottie.loading;
  static final dogLoading = Assets.lottie.dogLoading;
  static final crashScratch = Assets.lottie.crash;
}
