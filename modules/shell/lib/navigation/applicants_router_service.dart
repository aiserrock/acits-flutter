import 'package:applicants/applicants.dart';
import 'package:injectable/injectable.dart';

/// Реализация навигационного контракта модуля «Заявители/кураторы».
///
/// Экраны редактирования возвращают сохранённую сущность через
/// `Navigator.pop(result)` (framework-навигация), поэтому контракт пока не
/// объявляет переходов. Реализация регистрируется для единообразия с
/// animals/auth router-сервисами и как точка расширения для будущих переходов.
@Injectable(as: ApplicantsRouterService)
class ApplicantsRouterServiceImpl implements ApplicantsRouterService {
  const ApplicantsRouterServiceImpl();
}
