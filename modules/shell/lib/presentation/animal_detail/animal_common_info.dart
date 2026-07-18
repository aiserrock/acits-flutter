part of 'animal_detail_screen.dart';

SliverList _buildCommonInfoPage(BuildContext context, Animal animal) {
  return SliverList(delegate: SliverChildListDelegate(_buildCommonInfoContent(context, animal)));
}

/// Локализованный возраст из даты рождения (дни/месяцы/годы). Перенесено из
/// старого `AnimalX.ageString` — LocaleKeys живут в приложении, поэтому логика
/// остаётся в корневом экране, а не в модуле.
String? _ageString(Animal animal) {
  final birthDate = animal.birthDate;
  if (birthDate == null) return null;
  final days = DateTime.now().difference(birthDate).inDays;
  if (days < 30) return LocaleKeys.commonNDays.plural(days);
  if (days < 365) return LocaleKeys.commonNMonth.plural((days / 30).floor());
  return LocaleKeys.commonNYears.plural((days / 365).floor());
}

/// Человекочитаемое название статуса из серверного конфига (через порт модуля).
String? _statusString(Animal animal) => getIt<AnimalStatusLabels>().label(animal.status);

List<Widget> _buildCommonInfoContent(BuildContext context, Animal animal) {
  return [
    Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 16.0, bottom: 8.0),
      child: Text(
        LocaleKeys.animalCommonInfo.tr(),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22.0),
      ),
    ),
    AnimalContentCard([
      CardData(
        firstCaption: LocaleKeys.animalSex.tr(),
        firstValue: animal.sex ?? '',
        secondCaption: LocaleKeys.animalAge.tr(),
        secondValue: _ageString(animal) ?? '',
      ),
      CardData(
        firstCaption: LocaleKeys.aninmalSize.tr(),
        firstValue: animal.height ?? '',
        secondCaption: LocaleKeys.animalWeight.tr(),
        secondValue: animal.weight ?? '',
      ),
    ]),
    AnimalContentCard([
      CardData(
        firstCaption: LocaleKeys.animalReceiptDate.tr(),
        firstValue: animal.dateJoined != null ? _dateFormatter.format(animal.dateJoined!) : '',
        secondCaption: LocaleKeys.animalStatus.tr(),
        secondValue: _statusString(animal) ?? '',
      ),
      CardData(firstCaption: LocaleKeys.animalCatchPlace.tr(), firstValue: animal.placeOfCatch),
    ]),
    AnimalContentCard([
      CardData(firstCaption: LocaleKeys.animalFamily.tr(), firstValue: animal.speciesParentName ?? ''),
      CardData(firstCaption: LocaleKeys.animalKind.tr(), firstValue: animal.speciesName ?? ''),
      CardData(firstCaption: LocaleKeys.animalCategory.tr(), firstValue: animal.speciesCategoryName ?? ''),
    ]),
    AnimalContentCard([
      CardData(firstCaption: LocaleKeys.animalColor.tr(), firstValue: animal.color ?? ''),
      CardData(firstCaption: LocaleKeys.animalSpecSigns.tr(), firstValue: animal.specialSigns ?? ''),
    ]),
    AnimalContentCard([
      CardData(firstCaption: LocaleKeys.animalChip.tr(), firstValue: animal.chippingCode ?? ''),
      CardData(
        firstCaption: LocaleKeys.animalChipDate.tr(),
        firstValue: animal.dateOfChipping != null ? _dateFormatter.format(animal.dateOfChipping!) : '',
      ),
    ]),
    const SizedBox(height: 12.0),
  ];
}
