part of 'animal_detail_screen.dart';

SliverList _buildCommonInfoPage(AnimalRead animal) {
  return SliverList(delegate: SliverChildListDelegate(_buildCommonInfoContent(animal)));
}

List<Widget> _buildCommonInfoContent(AnimalRead animal) {
  return [
    Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 16.0, bottom: 8.0),
      child: Text(LocaleKeys.animalCommonInfo.tr(), style: StyleRes.title.copyWith(fontSize: 22.0)),
    ),
    AnimalContentCard([
      CardData(
        firstCaption: LocaleKeys.animalSex.tr(),
        firstValue: animal.sexString ?? '',
        secondCaption: LocaleKeys.animalAge.tr(),
        secondValue: animal.ageString ?? '',
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
        secondValue: animal.statusString ?? '',
      ),
      CardData(
        firstCaption: LocaleKeys.animalCatchPlace.tr(),
        firstValue: animal.placeOfCatch ?? '',
      ),
    ]),
    AnimalContentCard([
      CardData(firstCaption: LocaleKeys.animalFamily.tr(), firstValue: animal.specFamily ?? ''),
      CardData(firstCaption: LocaleKeys.animalKind.tr(), firstValue: animal.specKind ?? ''),
      CardData(firstCaption: LocaleKeys.animalCategory.tr(), firstValue: animal.specCategory ?? ''),
    ]),
    AnimalContentCard([
      CardData(firstCaption: LocaleKeys.animalColor.tr(), firstValue: animal.colorString ?? ''),
      CardData(
        firstCaption: LocaleKeys.animalSpecSigns.tr(),
        firstValue: animal.specialSignsString ?? '',
      ),
    ]),
    AnimalContentCard([
      CardData(firstCaption: LocaleKeys.animalChip.tr(), firstValue: animal.chippingCode ?? ''),
      CardData(
        firstCaption: LocaleKeys.animalChipDate.tr(),
        firstValue: animal.dateOfChipping != null
            ? _dateFormatter.format(animal.dateOfChipping!)
            : '',
      ),
    ]),
    const SizedBox(height: 12.0),
  ];
}
