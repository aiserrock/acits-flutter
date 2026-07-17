// Ввод форм регистрации переехал в модуль auth (его доменный контракт).
// Ре-экспорт сохраняет существующие импорты
// `package:acits_flutter/domain/registration_input.dart` и — что важнее —
// делает Admin/Worker input и WorkerRole ОДНИМ типом для приложения (AuthService)
// и модуля, поэтому `AuthService implements AuthSessionApi` типизируется.
export 'package:auth/auth.dart' show AdminRegistrationInput, WorkerRegistrationInput, WorkerRole;
