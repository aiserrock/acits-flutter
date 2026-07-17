import 'package:acits_api/acits_api.dart';
import 'package:acits_domain/acits_domain.dart' show Transformable;

import 'package:animals/domain/domain.dart';

/// DTO → [AnimalListItem]. Отдельный класс-маппер (Transformable), а не метод на
/// DTO: домен про DTO не знает. Превью берём с приоритетного (или первого) фото.
class AnimalListItemMapper implements Transformable<AnimalListItem> {
  const AnimalListItemMapper(this._dto);

  final AnimalDto _dto;

  @override
  AnimalListItem toEntity() {
    final avatar = _pickAvatar(_dto.images);
    return AnimalListItem(
      id: _dto.id,
      name: _dto.name ?? '',
      status: AnimalStatus.fromWire(_dto.status),
      thumbUrl: avatar == null ? null : _thumb(avatar.image),
      speciesParentName: _dto.spec?.parentName,
      speciesName: _dto.spec?.name,
      dateJoined: _dto.dateJoined,
    );
  }

  static AnimalImageDto? _pickAvatar(List<AnimalImageDto> images) {
    if (images.isEmpty) return null;
    for (final image in images) {
      if (image.isPrimary ?? false) return image;
    }
    return images.first;
  }

  static String _thumb(ImageThumbnailsDto t) =>
      t.small.isNotEmpty ? t.small : (t.medium.isNotEmpty ? t.medium : t.large);
}
