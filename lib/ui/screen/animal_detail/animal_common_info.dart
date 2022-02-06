part of 'animal_detail_screen.dart';

SliverList _buildCommonInfoPage(AnimalRead animal) {
  return SliverList(
    delegate: SliverChildListDelegate(
      _buildCommonInfoContent(animal),
    ),
  );
}

List<Widget> _buildCommonInfoContent(AnimalRead animal) {
  return [
    Padding(
      padding: const EdgeInsets.only(
        top: 24.0,
        left: 16.0,
        bottom: 8.0,
      ),
      child: Text(
        StringRes.current.animalCommonInfo,
        style: StyleRes.title.copyWith(fontSize: 22.0),
      ),
    ),
    AnimalContentCard([
      CardData(
        firstCaption: StringRes.current.animalSex,
        firstValue: animal.sexString ?? '',
        secondCaption: StringRes.current.animalAge,
        secondValue: animal.ageString ?? '',
      ),
      CardData(
        firstCaption: StringRes.current.aninmalSize,
        firstValue: animal.height ?? '',
        secondCaption: StringRes.current.animalWeight,
        secondValue: animal.weight ?? '',
      ),
    ]),
    AnimalContentCard([
      CardData(
        firstCaption: StringRes.current.animalReceiptDate,
        firstValue: animal.dateJoined != null
            ? _dateFormatter.format(animal.dateJoined!)
            : '',
        secondCaption: StringRes.current.animalStatus,
        secondValue: animal.statusString ?? '',
      ),
      CardData(
        firstCaption: StringRes.current.animalCatchPlace,
        firstValue: animal.placeOfCatch ?? '',
      ),
    ]),
    AnimalContentCard([
      CardData(
        firstCaption: StringRes.current.animalFamily,
        firstValue: animal.specFamily ?? '',
      ),
      CardData(
        firstCaption: StringRes.current.animalKind,
        firstValue: animal.specKind ?? '',
      ),
      CardData(
        firstCaption: StringRes.current.animalCategory,
        firstValue: animal.specCategory ?? '',
      ),
    ]),
    AnimalContentCard([
      CardData(
        firstCaption: StringRes.current.animalColor,
        firstValue: animal.colorString ?? '',
      ),
      CardData(
        firstCaption: StringRes.current.animalSpecSigns,
        firstValue: animal.specialSignsString ?? '',
      ),
    ]),
    AnimalContentCard([
      CardData(
        firstCaption: StringRes.current.animalChip,
        firstValue: animal.chippingCode ?? '',
      ),
      CardData(
        firstCaption: StringRes.current.animalChipDate,
        firstValue: animal.dateOfChipping != null
            ? _dateFormatter.format(animal.dateOfChipping!)
            : '',
      ),
    ]),
    const SizedBox(
      height: 12.0,
    )
  ];
}
