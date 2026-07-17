/// Компактная ссылка на выбранное животное на экране редактора назначения.
///
/// Экрану нужны лишь id/имя/миниатюра — сущность декуплирует форму от полной
/// [Animal] (модуль) и от поисковой выдачи. Собирается из [Animal] (init/edit)
/// либо из элемента поиска.
class PrescriptionAnimalRef {
  const PrescriptionAnimalRef({required this.id, this.name, this.thumbUrl});

  final int id;
  final String? name;
  final String? thumbUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrescriptionAnimalRef && other.id == id && other.name == name && other.thumbUrl == thumbUrl;

  @override
  int get hashCode => Object.hash(id, name, thumbUrl);
}
