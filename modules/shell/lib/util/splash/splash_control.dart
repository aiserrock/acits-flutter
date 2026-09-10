/// Снятие стартового splash по завершении auth-решения на splash-роуте.
///
/// Единая точка [removeSplash] для обеих платформ:
///  • mobile — `FlutterNativeSplash.remove()` убирает нативный splash, который
///    держался с `preserve()` в `main()`;
///  • web — удаляет DOM-элементы `#splash` (картинка на #6776E0) и `#loader`
///    (белый спиннер) из `web/index.html`, которые играют роль нативного splash.
///
/// Смысл: авторизованный юзер на холодном старте видит только splash-кадр, пока
/// идёт refresh + восстановление приюта, затем сразу root — без мелькания login.
library;

export 'splash_control_stub.dart' if (dart.library.js_interop) 'splash_control_web.dart';
