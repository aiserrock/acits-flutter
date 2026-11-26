/// Компактная ссылка на животное внутри назначения (карточка «на сегодня»).
class AnimalShort {
  const AnimalShort({
    required this.id,
    required this.uuid,
    required this.specName,
    this.name,
    this.specParentName,
    this.avatar,
    this.defaultImageId,
  });

  final int id;
  final String uuid;
  final String? name;
  final String specName;
  final String? specParentName;
  final String? avatar;
  final int? defaultImageId;
}
