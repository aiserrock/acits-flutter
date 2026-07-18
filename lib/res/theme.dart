// Тема переехала в acits_ui_kit. Ре-экспорт сохраняет существующие импорты
// `package:acits_flutter/res/theme.dart` рабочими и — что важнее — делает
// AppColors/AppColorsX ОДНИМ типом для приложения и мигрированных модулей,
// поэтому `context.appColors` резолвит одну и ту же зарегистрированную
// ThemeExtension из любого слоя.
export 'package:ui_kit/acits_ui_kit.dart' show AppTheme, AppColors, AppColorsX;
