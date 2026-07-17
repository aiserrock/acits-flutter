/// Базовый маркер для навигационных контрактов фич. Каждая фича объявляет
/// `abstract <Feature>RouterService extends RouterService` со своими переходами;
/// единственная реализация (знающая go_router-пути) живёт в навигационном слое.
/// Так фичи не зависят ни от go_router, ни друг от друга.
abstract interface class RouterService {}
