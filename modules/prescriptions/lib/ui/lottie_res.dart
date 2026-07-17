/// Пути к lottie-анимациям, которые использует UI модуля «Назначения».
///
/// Ассеты физически лежат в бандле приложения (`assets/lottie/*.json`); модуль
/// ссылается на них строковыми путями (как `.tr()` резолвит переводы из бандла
/// приложения). Значения совпадают с app `res/lottie.dart`.
abstract final class PrescriptionsLottieRes {
  static const dogLoading = 'assets/lottie/dog_loading.json';
  static const crashScratch = 'assets/lottie/crash.json';
}
