/// Канонические пути роутов (kebab-case, URL == идентичность, web-safe).
///
/// Целевая схема из design-spec. Экраны мигрируют на эти пути по фичам; на время
/// миграции старые пути держатся алиасами ≥1 релиз. Обязательная идентичность —
/// в path/query; `extra` только для несериализуемого in-memory кэша с фолбэком
/// по id (правило зафиксировано здесь, снятие `extra` — в миграции фич).
abstract final class Routes {
  const Routes._();

  // Shell / auth
  static const shell = '/';
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const emailConfirmation = '/email-confirmation';
  static const pickShelter = '/pick-shelter';

  // Animals (reference slice)
  static const animals = '/animals';
  static const animalDetail = '/animals/:id';
  static const animalEdit = '/animals/:id/edit';
  static const animalNew = '/animals/new';

  // Prescriptions / applicants
  static const prescriptions = '/prescriptions';
  static const drugs = '/drugs';
  static const applicants = '/applicants';
  static const curators = '/curators';

  // Personal / media
  static const profile = '/profile';
  static const calendar = '/calendar';
  static const comments = '/animals/:id/comments';
  static const photos = '/animals/:id/photos';
  static const photoEdit = '/animals/:id/photos/edit';
  static const documentView = '/documents/:id';
  static const search = '/search';

  static String animalDetailPath(int id) => '/animals/$id';
  static String animalEditPath(int id) => '/animals/$id/edit';
  static String commentsPath(int animalId) => '/animals/$animalId/comments';
  static String photosPath(int animalId) => '/animals/$animalId/photos';
  static String documentViewPath(int id) => '/documents/$id';
  static String searchPath(String typeKey) => '/search?type=$typeKey';
}
